<cfinclude template="header.cfm" />
	<cfparam name="URL.view" default="output" />
	<cfswitch expression="#URL.view#">
		<cfcase value="output">
			<cfparam name="url.type" default="registrations" />
			
			<cfif url.type eq "registrations">
				<!--- query the database --->
				<cfquery name="registrations" datasource="">
				SELECT * FROM registrations r
				WHERE registration_deleted = 0
				ORDER BY r.registration_fname
				</cfquery>
				
				<!---
				<cfheader name="Content-Disposition" value="inline; filename=abstract-report_#dateformat(now(),'mm-dd-YY')#.xls">
				<cfcontent type="application/msexcel" >
				--->
	
				<table border="1" style="width:100%">
					<tr>
						<th>ID</th>
						<th>Added</th>
						<th>Last Updated</th>
						<th>Type</th>
						<th>First</th>
						<th>Last</th>
						<th>Title</th>
						<th>Organization</th>
						<th>Address 1</th>
						<th>Address 2</th>
						<th>City</th>
						<th>State</th>
						<th>ZIP</th>
						<th>Phone</th>
						<th>Fax</th>
						<th>Email</th>
					</tr>
					
					<!--- loop through the registrations --->
					<cfoutput query="registrations">
						<tr>
							<td>#registration_id#</td>
							<td>#dateformat(registration_dateadded,"mm/dd/yyyy")#</td>
							<td>#dateformat(registration_lastupdated,"mm/dd/yyyy")#</td>
							<td>#registration_type#</td>
							<td>#registration_fname#</td>
							<td>#registration_lname#</td>
							<td>#registration_title#</td>
							<td>#registration_organization#</td>
							<td>#registration_address1#</td>
							<td>#registration_address2#</td>
							<td>#registration_city#</td>
							<td>#registration_state#</td>
							<td>#registration_zip#</td>
							<td>#registration_phone#<cfif registration_phoneext neq ""> ext. #registration_phoneext#</cfif></td>
							<td>#registration_fax#</td>
							<td><a href="mailto:#registration_email#">#registration_email#</a></td>
						</tr>
					</cfoutput>
					<!--- end loop --->
				</table>
	
			</cfif>		
		</cfcase>
	</cfswitch>
<cfinclude template="footer.cfm" />