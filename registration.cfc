<!---
	Functions for registration
--->
<cfcomponent>	
	<cffunction name="getRegistration" access="public" returnType="query" output="no">
		<cfargument name="id" type="numeric" required="false" default="0" />
		<cfargument name="hash" type="string" required="false" default="0" />
		<cfquery name="registration" dataSource="#session.ds#">
			SELECT * FROM registrations
			WHERE 1 = 1
			AND registration_deleted = 0
			<cfif arguments.id neq 0>
				AND registration_id = #arguments.id#
			</cfif>
			<cfif arguments.hash neq 0>
				AND registration_hash = '#arguments.hash#'
			</cfif>		
		</cfquery>
		<cfreturn registration />
	</cffunction>
	
	<cffunction name="cancelRegistration" access="public" returnType="void" output="no">
		<cfargument name="hash" required="true" />
		<cfquery name="cancel" dataSource="#session.ds#">
		UPDATE registrations
		SET registration_deleted = 1,
		registration_lastupdated = now()
		WHERE registration_hash = '#arguments.hash#'
		</cfquery>
	</cffunction>
	
	<cffunction name="getTotals" access="public" returnType="query" output="no">
		<cfargument name="event" required="true" />
		<cfquery name="totals" dataSource="#session.ds#">
			SELECT count(registration_id) as totalreg from registrations WHERE registration_eventid = #arguments.event# and registration_deleted = 0
		</cfquery>
		<cfreturn totals />
	</cffunction>
	
	<cffunction name="getConfirmation" access="public" returnType="string" output="no">
		<cfargument name="hash" type="string" required="true" />
		<cfset confirmation = "" />
		<cfsavecontent variable="confirmation"><cfinclude template="confirmation.cfm" /></cfsavecontent>
		<cfreturn confirmation />
	</cffunction>
	
	<cffunction name="sendConfirmation" access="public" returnType="void" output="no">
		<cfargument name="hash" type="string" required="true" />
		<cfset registration = getRegistration(0,arguments.hash) />
		
		<!--- send confirmation email --->
		<cfmail to="#registration.registration_email#" from="Your Name <your.name@yourname.com>" subject="Registration Confirmation" type="html">
		<html>
		<body>
		<table width="650" align="center" border="0" cellspacing="0" cellpadding="0" class="container" bgcolor="##DDDDDDD">
			<tbody>
				<tr>
					<tr>
						<td height="10">&nbsp;</td>
					</tr>
					<td valign="top"> 
					<table width="625" align="center" border="0" cellspacing="0" cellpadding="0" class="row" bgcolor="##FFFFFF">
						<tbody>
							<tr>
								<td height="10">&nbsp;</td>
							</tr>
							<tr>
								<td style="font-size: 14px; line-height: 22px; font-family: Arial, Tahoma, Helvetica, sans-serif; color: ##666666; font-weight: 300; text-align: left; word-break: break-word;padding: 0 10px;"> 
								<h1>
									Registration Confirmation 
								</h1>
								<cfoutput>#getConfirmation(arguments.hash)#</cfoutput> </td>
							</tr>
							<tr>
								<td height="10">&nbsp;</td>
							</tr>
						</tbody>
					</table>
					<tr>
						<td height="10">&nbsp;</td>
					</tr>
					</td>
				</tr>
			</tbody>
		</table>
		</body>
		</html>
		</cfmail>
	</cffunction>

	<!--- Trim form --->
	<cffunction name="trimForm" access="public" returntype="void" output="no">
		<cfloop collection="#form#" item="formVar">
			<cfif isvalid("string",form[formVar])>
				<cfset form[formVar] = trim(form[formVar]) />
			</cfif>
		</cfloop>
	</cffunction>
	
	<cffunction name="removeHTML" returntype="Any">
		<cfargument name="content" default="" type="any" required="true" />
		<cfset tmpcontent = arguments.content />
		<cfset myreg = "<\s*?[^>]+\s*?>" />
		<cfloop condition="#refindnocase(myreg,tmpcontent)# neq 0">
			<cfset tmpcontent = rereplace(tmpcontent,myreg,"") />
		</cfloop>
		<cfreturn tmpcontent />
	</cffunction>
	
	<cffunction name="validateDate" returntype="boolean">
		<cfargument name="date" required="true" type="any">
		<cfset isvalid = true />
			<cftry>
				<cfset tmp = parsedatetime(arguments.date) />
			<cfcatch>
				<cfset isvalid = false />
			</cfcatch>
			</cftry>
		<cfreturn isvalid />
	</cffunction>
	
	<cffunction name="validateform" returntype="string">
		<cfargument name="form" required="true" />
		<cfargument name="requiredfields" required="false" default="" />
		<cfset errors  = "" />
		<cfloop from="1" to="#listlen(ARGUMENTS.requiredfields)#" index="i">
			<cfif NOT structKeyExists(arguments.form,listgetat(ARGUMENTS.requiredfields,i)) OR structKeyExists(arguments.form,listgetat(ARGUMENTS.requiredfields,i)) AND ARGUMENTS.form[listgetat(ARGUMENTS.requiredfields,i)] eq "">
				<cfset errors = listappend(errors,listgetat(ARGUMENTS.requiredfields,i)) />
			</cfif>
		</cfloop>
		<cfreturn errors />
	</cffunction>
	
	<cffunction name="formatPhone" returntype="String" output="false" >
		<cfargument name="phonenumber" required="true" />
		<cfset tempphone = rereplaceNoCase(arguments.phonenumber,"[^0-9]","","all") />
		<cfset temp = "" />
		<cfswitch expression="#len(tempphone)#">
			<cfcase value="7"><cfset temp = mid(tempphone,1,3) & "-" & mid(tempphone,3,4) /></cfcase>
			<cfcase value="10"><cfset temp = mid(tempphone,1,3) & "-" & mid(tempphone,4,3) & "-" & mid(tempphone,7,4) /></cfcase>
			<cfcase value="11"><cfset temp = mid(tempphone,1,1) & "-" & mid(tempphone,2,3) & "-" & mid(tempphone,5,3) & "-" & mid(tempphone,8,4) /></cfcase>
			<cfdefaultcase><cfset temp = phonenumber /></cfdefaultcase>
		</cfswitch>
		<cfreturn temp />	
	</cffunction>

	<cffunction name="queryToTable" access="public" returntype="void" output="true">
		<cfargument name="q" type="query" required="true">
		<cfoutput>
			<table>
				<tr>
					<cfloop list="#arrayToList(arguments.q.getColumnNames())#" index="x">
						<th>#variables.x#</th>
					</cfloop>
				</tr>
				<cfloop query="arguments.q">
					<tr>
						<cfloop list="#arrayToList(arguments.q.getColumnNames())#" index="x">
							<td>#arguments.q[x][arguments.q.currentrow]#</td>
						</cfloop>
					</tr>
				</cfloop>
			</table>
		</cfoutput>
	</cffunction>

	<cffunction name="getHolidays" returntype="Struct" >
		<!--- create struct --->
		<cfset holidays = structnew() />
		
		<!--- set up each holiday --->
		<cfset holidays["New Year's Day"] = parsedatetime("1-1-#year#") />
		<cfset holidays["Martin Luther King"] = calculateHoliday(3,2,1,year) /><!--- 3rd Monday in Jan. --->
		<cfset holidays["Washington's Birthday"] = calculateHoliday(3,2,2,year) /><!--- 3rd Monday in Feb. --->
		<cfset holidays["Memorial Day"] = calculateHoliday(4,2,5,year) /><!--- last Monday in May --->
		<cfif isDate(dateadd("d",7,holidays["Memorial Day"]))><!--- check to see if it falls on the 5th monday --->
			<cfset holidays["Memorial Day"] = dateadd("d",7,holidays["Memorial Day"]) />
		</cfif>
		<cfset holidays["Independence Day"] = parsedatetime("7-4-#year#") />
		<cfset holidays["Labor Day"] = calculateHoliday(1,2,9,year) /><!--- First Monday in September --->
		<cfset holidays["Columbus Day"] = calculateHoliday(2,2,10,year) /><!--- Second Monday in October --->
		<cfset holidays["Veterans Day"] = parsedatetime("11-11-#year#") />
		<cfset holidays["Thanksgiving Day"] = calculateHoliday(4,5,11,year) /><!--- Fourth Thursday in November --->
		<cfset holidays["Christmas Day"] = parsedatetime("12-25-#year#") />
		<!--- check to see if the following new years observed falls in the current year --->
		<cfif datecompare(parsedatetime("1-1-#year+1#"),this.getObsevedHoliday(parsedatetime("1-1-#year+1#"))) neq 0>
			<cfset holidays["New Years Day (observed)"] = this.getObsevedHoliday(parsedatetime("1-1-#year+1#")) />
		</cfif>
		
		<!--- get observed holidays --->
		<cfloop list="#structkeylist(holidays)#" index="i">
			<cfif datecompare(holidays[i],this.getObsevedHoliday(holidays[i])) neq 0>
				<cfset holidays[i&" (observed)"] = this.getObsevedHoliday(holidays[i]) />
			</cfif>
		</cfloop>
		<!--- return holidays --->
		<cfreturn holidays />
	</cffunction>
	
	<cffunction name="calculateHoliday" returntype="String">
		<cfargument name="occurence" required="true" /><!--- the occurence, e.g. third Monday --->
		<cfargument name="targetDayOfWeek" required="true" /><!--- day of week, e.g. Monday --->
		<cfargument name="targetMonth" required="true" />
		<cfargument name="targetYear" required="true" />
		<!--- find earliest date it could be --->
		<cfset nEarliestDate = 1 + 7 * (arguments.occurence - 1) />
		<!--- find out what day of the week it falls on --->
		<cfset nWeekDay = dayOfWeek(parseDateTime(arguments.targetMonth&"-"&nEarliestDate&"-"&arguments.targetYear)) />
		<!--- calculate offset for the date --->
		<cfset nOffset = 0 />
		<cfscript>
			if( arguments.targetDayOfWeek != nWeekday )
			{
			  if( arguments.targetDayOfWeek<nWeekday ) nOffset = arguments.targetDayOfWeek + (7 - nWeekday);
			  else nOffset = (arguments.targetDayOfWeek + (7 - nWeekday)) - 7;
			}
		</cfscript>
		<!--- create the final day of the holiday --->
		<cfset finalDay = nEarliestDate + nOffset />
		<!--- set final date --->
		<cfset finalHoliday = parseDateTime(arguments.targetMonth&"-"&finalDay&"-"&arguments.targetYear) />
		<cfreturn finalHoliday />
	</cffunction>
	
	<cffunction name="getObsevedHoliday" returntype="String" >
		<cfargument name="dateToFind" required="true" />
		<cfset finalDay = arguments.dateToFind />
		<cfswitch expression="#dayOfWeek(parseDateTime(arguments.dateToFind))#">
			<cfcase value="1"><!--- if sunday, set for monday --->
				<cfset finalDay = dateadd("d",1,arguments.dateToFind) />
			</cfcase>
			<cfcase value="7"><!--- if saturday, set for friday --->
				<cfset finalDay = dateadd("d",-1,arguments.dateToFind) />
			</cfcase>
		</cfswitch>
		<cfreturn finalDay />
	</cffunction>
	
	<cffunction name="getStates" returnType="query">
		<cfquery name="states" dataSource="#session.ds#">
		SELECT * FROM states
		ORDER BY abbrv ASC			
		</cfquery>
		<cfreturn states />
	</cffunction>
</cfcomponent>