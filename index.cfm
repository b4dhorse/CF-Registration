<!--- URL.view controls the switch statement --->
<cfparam name="url.view" default="register" />

<cfinclude template="header.cfm" />

<!--- switch based on what needs to be displayed --->
<cfswitch expression="#url.view#">
	
	<!--- default case --->
	<cfdefaultcase>
		<p><a href="?view=register">Register</a></p>
	</cfdefaultcase>
	
	<!--- registration form case --->
	<cfcase value="register">
		
		<!--- vars for error validation, if there were any errors, this will highlight the fields --->
		<cfparam name="URL.errors" default="">
		
		<!--- check to see if ther eare errors --->
		<cfif isdefined("SESSION.tmpformdata.errors")>
			<cfset URL.errors = SESSION.tmpformdata.errors />
		</cfif>
		
		<cfoutput>
			<h2>Register</h2>
			
			<!--- build registration form --->
			<form name="registrationform" action="?view=submit" method="post" class="form-horizontal">
				<fieldset>
				
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_fname">First Name</label>  
						<div class="col-sm-6">
							<input id="registration_fname" name="registration_fname" <cfif isdefined("SESSION.tmpformdata.registration_fname")>value="#SESSION.tmpformdata.registration_fname#"</cfif> type="text" placeholder="First Name" class="form-control input-md" required="">
						<cfif listfind(URL.errors,"registration_fname")><span class="label label-danger">First Name is required.</span></cfif>
						</div>
					</div>
					
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_lname">Last Name</label>  
						<div class="col-sm-6">
							<input id="registration_lname" name="registration_lname" <cfif isdefined("SESSION.tmpformdata.registration_lname")>value="#SESSION.tmpformdata.registration_lname#"</cfif> type="text" placeholder="Last Name" class="form-control input-md" required="">
						<cfif listfind(URL.errors,"registration_lname")><span class="label label-danger">Last Name is required.</span></cfif>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_organization">Organization</label>  
						<div class="col-sm-6">
							<input  name="registration_organization" id="registration_organization" <cfif isdefined("SESSION.tmpformdata.registration_organization")>value="#SESSION.tmpformdata.registration_organization#"</cfif> type="text" placeholder="Organization" class="form-control input-md">
						
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_title">Title</label>  
						<div class="col-sm-6">
							<input  name="registration_title" id="registration_title" <cfif isdefined("SESSION.tmpformdata.registration_title")>value="#SESSION.tmpformdata.registration_title#"</cfif> type="text" placeholder="Title" class="form-control input-md">
						
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_address1">Address</label>  
						<div class="col-sm-6">
							<input  name="registration_address1" id="registration_address1" <cfif isdefined("SESSION.tmpformdata.registration_address1")>value="#SESSION.tmpformdata.registration_address1#"</cfif> type="text" placeholder="Address" class="form-control input-md">
						
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_address2">Address</label>  
						<div class="col-sm-6">
							<input  name="registration_address2" id="registration_address2" <cfif isdefined("SESSION.tmpformdata.registration_address2")>value="#SESSION.tmpformdata.registration_address2#"</cfif> type="text" placeholder="Address" class="form-control input-md">
						
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_city">City</label>  
						<div class="col-sm-6">
							<input  name="registration_city" id="registration_city" <cfif isdefined("SESSION.tmpformdata.registration_city")>value="#SESSION.tmpformdata.registration_city#"</cfif> type="text" placeholder="City" class="form-control input-md">
						
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-4 control-label" for="registration_state">State</label>  
						<div class="col-sm-6">
							<select name="registration_state" id="registration_state" required="">
								<option label="Please select" ></option>
								<cfloop query="#regObj.getStates()#">
									<option <cfif isdefined("session.tmpformdata.registration_state") and session.tmpformdata.registration_state eq abbrv>selected="selected"</cfif> value="#abbrv#">#state#</option>
								</cfloop>
							</select>
							<cfif listfind(URL.errors,"registration_state")><span class="label label-danger">State is required.</span></cfif>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_zip">ZIP Code</label>  
						<div class="col-sm-6">
							<input name="registration_zip" id="registration_zip" <cfif isdefined("SESSION.tmpformdata.registration_zip")>value="#SESSION.tmpformdata.registration_zip#"</cfif> type="text" placeholder="ZIP Code" class="form-control input-md">
						
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="registration_email">Email Address</label>  
						<div class="col-sm-6">
							<input name="registration_email" id="registration_email" <cfif isdefined("SESSION.tmpformdata.registration_email")>value="#SESSION.tmpformdata.registration_email#"</cfif> type="text" placeholder="Email Address" class="form-control input-md" required="">
							<cfif listfind(URL.errors,"registration_email")><span class="label label-danger">Valid email is required.</span></cfif>
						</div>
					</div>
					
					<div class="form-group">
						<label class="col-sm-3 control-label" for="confirmemail">Confirm Email Address</label>  
						<div class="col-sm-6">
							<input name="confirmemail" id="confirmemail" type="text" placeholder="Confirm Email Address" class="form-control input-md" required="">
							<cfif listfind(URL.errors,"confirmemail")><span class="label label-danger">Email addresses do not match.</span></cfif>
						</div>
					</div>
					
					<!--- submit button --->
					<div class="form-group">
						<label class="col-sm-3">&nbsp;</label>
						<div class="col-sm-6">
							<input type="submit" value="Submit" class="btn btn-primary" />
						</div>
					</div>
				</fieldset>
			</form><!--- end of form --->
	    </cfoutput>
	    
	    <!--- reset the form data, this is done in case they leave the page to do something else and then come back --->
	    <cfset SESSION.tmpformdata = false />
	</cfcase>
	
	<!--- form submit case --->
	<cfcase value="submit">
		<!--- make util object --->
		<cfobject name="registrationObj" component="registration" />
		
		<!--- required fields --->
		<cfset requiredfields = "registration_fname,registration_lname,registration_email" />
		
		<!--- validate form, get errors --->
		<cfset errors = registrationObj.validateform(duplicate(FORM),requiredfields) />
		
		<!--- check email and confirm email match --->
		<cfif FORM.registration_email neq FORM.confirmemail>
			<cfset errors = listappend(errors,"confirmemail") />
		</cfif>
		
		<!---check for valid email --->
		<cfif not isvalid("email",form.registration_email)>
			<cfset errors = listappend(errors,"registration_email") />
		</cfif>
		
		<!--- if there were no errors, reset the temp form data --->
		<cfif errors eq "">
			<cfset SESSION.tmpformdata = false />
		<cfelse>
			<!--- add the submitted form fields to a temp struct, used to re-fill the form --->
			<cfset SESSION.tmpformdata = duplicate(FORM) />
			
			<!--- list of error fields, used for highlighting the form fields --->
			<cfset SESSION.tmpformdata.errors = errors />
			<cflocation url="?view=register" addtoken="no">
		</cfif>
		
		<!--- past this point the form is valid, time to process --->
		<cfset structdelete(FORM,"confirmemail") />
		<cfset structdelete(FORM,"fieldnames") />
		
		<!--- set dates --->
		<cfset form.registration_dateadded = now() />
		<cfset form.registration_lastupdated = now() />
		
		<!--- insert into database --->
		<cfinsert dataSource="" tableName="registrations" />
		
		<!--- create hash --->
		<cfquery name="reg" dataSource="#session.ds#">
		SELECT * FROM registrations
		WHERE registration_id = (select max(registration_id) from nih_registrations)
		</cfquery>

		<cfquery name="update" dataSource="#session.ds#">
		UPDATE registrations
		SET registration_hash = md5('#reg.registration_id#')	
		WHERE registration_id = #reg.registration_id#
		</cfquery>
		
		<cfquery name="reghash" dataSource="#session.ds#">
		SELECT registration_hash FROM registrations
		WHERE registration_id = #reg.registration_id#			
		</cfquery>
		
		<!--- send confirmation email --->
		<cfset registrationObj.sendConfirmation(reghash.registration_hash) />
		
		<!--- send to confirmation page --->
		<cflocation url="?view=confirmation" addToken="false" />
	</cfcase>
	
	<!--- confirmation page case --->
	<cfcase value="confirmation">
		<h2>Registration Confirmation</h2>
		<p>We are pleased to confirm your registration. We look forward to your participation in the event.</p>
	</cfcase>
</cfswitch>

<cfinclude template="footer.cfm" />