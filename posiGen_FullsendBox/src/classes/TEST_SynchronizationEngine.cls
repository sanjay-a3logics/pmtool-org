@isTest 
private class TEST_SynchronizationEngine {
	
	private static String sampleLeadJSON = '{"attributes":{"type":"Lead","url":"/services/data/v37.0/sobjects/Lead/00Q17000006rQUTEA2"},"Id":"00Q17000006rQUTEA2","IsDeleted":false,"LastName":"Tester","FirstName":"Zack","Salutation":"Mr.","MiddleName":"M","Suffix":"Jr.","Name":"Zack M Tester Jr.","Company":"brightcureent","Street":"56 Belle Grove Dr.","City":"Destrehan","State":"Louisiana","PostalCode":"65532","Country":"United States","StateCode":"LA","CountryCode":"US","Address":{"city":"Destrehan","country":"United States","countryCode":"US","geocodeAccuracy":null,"latitude":null,"longitude":null,"postalCode":"65532","state":"Louisiana","stateCode":"LA","street":"56 Belle Grove Dr."},"Phone":"(555) 500-3222","MobilePhone":"400-3333","Email":"zberg@test.com","Description":"descriptio here","LeadSource":"TV","Status":"Not Qualified","Rating":"Warm","OwnerId":"005d0000004ZQJfAAO","HasOptedOutOfEmail":false,"IsConverted":false,"IsUnreadByOwner":false,"CreatedDate":"2016-09-26T16:58:56.000+0000","CreatedById":"005d0000004ZQJfAAO","LastModifiedDate":"2016-09-28T20:04:42.000+0000","LastModifiedById":"005d0000004ZQJfAAO","SystemModstamp":"2016-09-28T20:04:42.000+0000","DoNotCall":true,"LastViewedDate":"2016-09-28T20:04:51.000+0000","LastReferencedDate":"2016-09-28T20:04:51.000+0000","Mobile_Phone__c":"400-3333","Unqualified_Reason__c":"Renters","Preferred_Method_of_Contact__c":"Mobile Phone","Checked_for_Duplicates__c":false,"Lead_Age__c":2,"Open_WTD__c":1,"Application__c":"2013-01-02","Open_MTD__c":1,"Application_WTD__c":0,"Application_MTD__c":0,"Signed_WTD__c":0,"Signed_MTD__c":0,"Submitted_WTD__c":0,"Submitted_MTD__c":0,"Approved_WTD__c":0,"Approved_MTD__c":0,"Open_CUR__c":1,"Approved_CUR__c":0,"Submitted_CUR__c":0,"smagicinteract__SMSOptOut__c":false,"Assess_Req_CUR__c":0,"Assess_Req_WTD__c":0,"Assess_Req_MTD__c":0,"Assessed_Feas_CUR__c":0,"Assessed_Feas_WTD__c":0,"Assessed_Feas_MTD__c":0,"Closed_CUR__c":0,"Closed_WTD__c":0,"Closed_MTD__c":0,"SolarNexus_Proposal_Fetched__c":false,"Sub_Lead_Source__c":"Infomercial","Initial_Appointment_Kept__c":false,"Rescheduled_Appt_Kept__c":false,"Lead_Created_Date_to_Flow_to_Accounts__c":"2016-09-26","Is_Feasible__c":false,"Customer_File_Approved__c":false,"Customer_File_Submitted__c":false,"Lead_Status_for_Opportunity_Reference__c":"Not Qualified","Roof_Assessment_Complete__c":false,"IsLead__c":1,"Had_Appointment_Eventually__c":0,"Numeric_ID__c":"499462","Roof_Assesment_Assigned__c":false,"Residence_Type__c":"Stand-Alone House","Number_of_Units__c":1,"Is_Portion_of_Roof_Facing_South_or_West__c":true,"Home_Heating_Method__c":"Electric","Own_Property_at_This_Address__c":false,"Number_of_Owners__c":1,"Lower_Monthly_Lease_Rate_Incentive_del__c":0,"Numeric_ID_Copy_For_Conversion__c":"499462","Roof_Type_SF2__c":"Shingle","Hot_Water_Heating_Method__c":"Electric","roofcondition__c":"Not Sure","Are_you_past_due_on_your_electric_bill__c":true,"Reason_for_Past_Due__c":"not enough money","Number_of_Months_Past_Due__c":1,"Does_client_have_shading_around_home__c":"Yes","If_yes_shading_details__c":"details on shading","Verified_name_spellings_with_customer__c":"Yes","Confirmed_home_is_not_a_double__c":"Yes","Status__c":"In Contacting Process","emma__Bounced__c":false,"Can_owner_access_utility_bill_online__c":true,"Client_has_a_unique_ownership_situation__c":false,"Preferred_Method_Notes__c":"notes here","CaseSafeID__c":"00Q17000006rQUTEA2","Infomercial_Type__c":"Daytime","Referring_Ambassador_Community_Partner__c":false,"created_day__c":"Monday","Active_Campaign__c":"701d00000022S2xAAE","Add_to_Campaign__c":false,"Electricity_Provider_BC__c":"National Grid","Lock_Lead_Source__c":false}';
	//OLD VERSION //private static String sampleProspectJSON = '{"attributes":{"type":"Prospect__c","url":"/services/data/v37.0/sobjects/Prospect__c/a5F17000000CbJpEAK"},"Id":"a5F17000000CbJpEAK","OwnerId":"005d0000004ZQJfAAO","IsDeleted":false,"Name":"P00000012","CreatedDate":"2016-09-28T01:48:47.000+0000","CreatedById":"005d0000004ZQJfAAO","LastModifiedDate":"2016-09-28T20:13:05.000+0000","LastModifiedById":"005d0000004ZQJfAAO","SystemModstamp":"2016-09-28T20:13:05.000+0000","LastViewedDate":"2016-09-28T20:13:06.000+0000","LastReferencedDate":"2016-09-28T20:13:06.000+0000","LeadSource__c":"Direct Mail","FirstName__c":"Rob","LastName__c":"Mayflower","Phone__c":"(555) 444-3321","Number_of_Owners__c":1,"Ready_To_Sync__c":false,"Activity_Time_Difference__c":0,"Add_to_Campaign__c":false,"Appt_Date_Time__c":"2016-09-28T01:44:00.000+0000","Are_you_past_due_on_your_electric_bill__c":false,"Brightcurrent_Average_Monthly_bill__c":2,"Can_owner_access_utility_bill_online__c":true,"CaseSafeID__c":"a5F17000000CbJpEAK","Checked_for_Duplicates__c":false,"Client_has_a_unique_ownership_situation__c":false,"Confirmed_home_is_not_a_double__c":"Yes","Does_client_have_shading_around_home__c":"Yes","Electricity_Provider_BC__c":"PSEG","Home_Heating_Method__c":"Electric","Hot_Water_Heater__c":"Electric","Hot_Water_Heating_Method__c":"Natural Gas","Is_Portion_of_Roof_Facing_South_or_West__c":true,"Lead_Age__c":1,"Lead_Source_Detail_1__c":"CBS","Lease_Source_Detail_2__c":"Morning News","Lock_Lead_Source__c":false,"Multiple_Owners__c":"No","Number_of_Activities__c":2,"Number_of_Units__c":1,"Own_Property_at_This_Address__c":false,"Residence_Type__c":"Stand-Alone House","Roof_Type_SF2__c":"Shingle","Status__c":"In Contacting Process","Verified_name_spellings_with_customer__c":"Yes","created_day__c":"Tuesday","roofcondition__c":"Not Sure","Description__c":"description here","Do_Not_Call__c":false,"Email__c":"rob@test.com","HasOptedOutOfEmail__c":false}';
	private static String sampleProspectJSON = '{"attributes":{"type":"Prospect__c","url":"/services/data/v38.0/sobjects/Prospect__c/' + string.valueOf(Schema.SObjectType.Prospect__c.getKeyPrefix()) + '"},"OwnerId":"005d0000003XKcbAAG","IsDeleted":false,"Name":"P00200418","CreatedDate":"2016-10-10T14:41:38.000+0000","CreatedById":"005d0000003XKcbAAG","LastModifiedDate":"2016-10-14T14:50:48.000+0000","LastModifiedById":"005d0000005B8L5AAK","SystemModstamp":"2016-10-15T10:36:10.000+0000","LastViewedDate":"2016-10-19T17:42:58.000+0000","LastReferencedDate":"2016-10-19T17:42:58.000+0000","Add_to_Campaign__c":false,"Appt_Date_Time__c":"2016-10-11T14:42:00.000+0000","Are_you_past_due_on_your_electric_bill__c":false,"Brightcurrent_Average_Monthly_bill__c":150,"Can_owner_access_utility_bill_online__c":true,"CaseSafeID__c":"a5SR0000000FQ58MAG","Checked_for_Duplicates__c":false,"Client_has_a_unique_ownership_situation__c":false,"Confirmed_home_is_not_a_double__c":"Yes","DoNotCall__c":false,"Does_client_have_shading_around_home__c":"Yes","Email__c":"test@gmail.com","FirstName__c":"Anthony","HasOptedOutOfEmail__c":false,"Highest_Electric_Bill_in_Past_12_Months__c":250,"Home_Heating_Method__c":"Natural Gas","Hot_Water_Heater__c":"Gas","Hot_Water_Heating_Method__c":"Natural Gas","If_yes_shading_details__c":"tons of shading","Is_Portion_of_Roof_Facing_South_or_West__c":true,"LastName__c":"Davis","LeadSource__c":"Direct Mail","Lead_Age__c":9,"Lock_Lead_Source__c":true,"Mobile_Phone__c":"(504) 321-6547","Multiple_Owners__c":"No","Number_of_Owners__c":1,"Number_of_Units__c":1,"Own_Property_at_This_Address__c":false,"Phone__c":"(504) 123-4567","Rating__c":"Hot","Ready_To_Sync__c":false,"Residence_Type__c":"Stand-Alone House","Roof_Type_SF2__c":"Shingle","Status__c":"In Contacting Process","created_date_time__c":"2016-10-11T14:42:00.000+0000","created_day__c":"Monday","City__c":"New Orleans","Emma_Bounced__c":false,"Numeric_IDx__c":"497567","PostalCode__c":"70001","SMS_Opt_Out__c":false,"State__c":"Louisiana","Street__c":"123 Main Street","OverrideProcessBuilder__c":false}';
	private static String sampleOpportunityJSON = '{"attributes":{"type":"Opportunity","url":"/services/data/v37.0/sobjects/Opportunity/006d000000porcpAAA"},"Id":"006d000000porcpAAA","IsDeleted":false,"AccountId":"001d0000024HZ8kAAG","RecordTypeId":"012d0000000xFexAAE","IsPrivate":false,"Name":"*Rear Building* William & Linda LeMon@16 Paulding Ave. Cold Spring, NY 10516","StageName":"Layout Approval","Amount":250,"Probability":85,"ExpectedRevenue":212.5,"CloseDate":"2016-09-30","LeadSource":"Canvassing","IsClosed":false,"IsWon":false,"ForecastCategory":"Pipeline","ForecastCategoryName":"Pipeline","HasOpportunityLineItem":false,"OwnerId":"005d000000676jVAAQ","CreatedDate":"2016-07-29T12:53:25.000+0000","CreatedById":"005d000000676jVAAQ","LastModifiedDate":"2016-09-28T20:24:22.000+0000","LastModifiedById":"005d0000004ZQJfAAO","SystemModstamp":"2016-09-28T20:24:22.000+0000","LastActivityDate":"2016-08-08","FiscalQuarter":3,"FiscalYear":2016,"Fiscal":"2016 3","LastViewedDate":"2016-09-28T20:24:28.000+0000","LastReferencedDate":"2016-09-28T20:24:28.000+0000","HasOpenActivity":false,"HasOverdueTask":false,"Included_in_Commission_Run_ISS__c":false,"Feasible_Stage__c":"Install Released","PV_Month_09__c":54.99,"Signed_PV_Lease_Size__c":"4.5","PV_Month_10__c":54.99,"Closed_Lost_Abandoned_Reason__c":"Changed Mind","PV_Month_11__c":54.99,"Closed_Lost_Abandoned_Reason_Detail__c":"asdf fdasf ads","Contracts_Approved_Date__c":"2016-07-31","Install_Released__c":"2016-09-28","Final_Inspection_Notification_Received__c":"2016-09-28","Roof_Assessor__c":"Veteran Contractors","Roof_Assessment_Complete_Date__c":"2016-09-28","Name_s_on_Assessor_Page__c":"fdafda","Install_Completed__c":"2016-09-28","Lead_Sheet__c":"2016-09-28","Intake_Questionnaire__c":"2016-09-28","PV_Month_12__c":54.99,"Driver_s_License_State_ID__c":"2016-09-28","Consulting_Agreement__c":"2016-09-28","EE_Month_01__c":10,"Install_Passed_Final_Inspection__c":"2016-09-28","Submitted_to_3rd_Party_Admin__c":"2016-09-28","Approved_by_3rd_Party_Paid__c":"2016-09-28","Submitted_to_Iberia__c":"2016-09-28","Funded_by_KWF__c":"2016-09-28","Released_to_EE_Provider__c":"2016-09-28","State_Program_Application_Received_Date__c":"2016-09-28","State_Program_Application_Submitted_Date__c":"2016-09-28","Packet_Not_Approved_Reason__c":"fdsaf fdsa fds  tr h","Feasible_Solar_Hot_Water_Heater__c":"Yes","Hot_Water_Heater__c":"Electric","Appointment_Required__c":false,"Photo_of_House__c":true,"Photo_of_Panel__c":true,"Savings_Guarantee__c":"12 months of utility bills","Closed_Lost__c":false,"Permanent_Removal__c":false,"House_Photo_Uploader__c":"005d000000676jVAAQ","Panel_Photo_Uploader__c":"005d000000676jVAAQ","ACH_Chosen__c":true,"Last_Schedule_Appointment_Date__c":"2016-07-29T12:53:26.000+0000","Last_Client_Signed_Date__c":"2016-07-30T03:09:54.000+0000","Last_Contracts_Submitted_to_DC_Date__c":"2016-07-30T04:11:59.000+0000","Roof_Assessor_Assigned_Date__c":"2016-09-27","EE_Month_02__c":0,"EE_Month_03__c":0,"EE_Month_04__c":0,"EE_Month_05__c":0,"EE_Month_06__c":0,"EE_Month_07__c":10,"EE_Month_08__c":10,"Monthly_Billing_Amount__c":64.99,"EE_Month_09__c":10,"Notes__c":"ghghrhg  a sdf fdsa","Submitted_to_KWF__c":"2016-09-28","Funded_by_Iberia__c":"2016-09-28","Lead_Age_Converted__c":0,"Days_Install_Released__c":61,"Days_Install_Completed__c":61,"Days_Final_Inspection__c":61,"Layout_Approval_Required__c":true,"Submitted_to_US_Bank__c":"2016-09-28","Funded_by_US_Bank__c":"2016-09-28","Iberia_Submitted_Age__c":0,"KWF_Submitted_Age__c":0,"US_Bank_Submitted_Age__c":0,"EE_Month_10__c":10,"Solar_Product__c":"Energy Efficiency;Solar Panels","Lease_Fee__c":234,"Panel_Post_Install_Picture__c":false,"Customer_Incentive__c":"asdfdsaf","SHW_Contract_Signed__c":"Yes","EE_Month_11__c":10,"EE_Month_12__c":10,"ACH_Payment_Date__c":"10","Country__c":"United States","SHW_Packet_Signed_Date__c":"2016-09-28","SHW_Notes__c":"dsfgfsdg","Solar_Hot_Water_Assessor__c":"KDH","SHW_Release_Date__c":"2016-09-28","OppStatus__c":"Pending","Contract_Approved_By__c":"Ashley Mashke","Pre_Install_Notice_Notes__c":"fdasdffffdfdfdfdfd","HDLC_Approval_Required__c":false,"Monitoring_Data_Verified__c":false,"Included_in_Commission_Run__c":false,"Breaker_Box_Picture__c":false,"Diagram__c":false,"Feasible_Solar__c":"4.5 kw","Non_Feasible_Reason__c":"Roof Size","Quoted_Lease_Total__c":0,"RevocableIrrevocable_Trust__c":false,"Agreement_Monthly_PV_Rate__c":54.99,"Agreement_Payment_Total__c":13197.6,"Agreement_No_Units__c":18,"Page_4__c":false,"First_Closing_Call_Made__c":false,"Lock_Promo__c":true,"First_Intro_Call_Made__c":false,"Solar_Electric_System__c":"X","Inspection_Request_Date__c":"2016-09-28","Inspection_Received_Date__c":"2016-09-28","HDLC_Approval__c":false,"Long_ID__c":"006d000000porcpAAA","PV_Month_01__c":40,"PV_Month_02__c":0,"PV_Month_03__c":0,"Transferred_System__c":false,"Account_Address_1__c":"16 Paulding Ave","Account_City__c":"Cold Spring","Account_State__c":"New York","Account_Zip__c":"10516","Created_Month__c":"2016-07-01","Net_Meter_Installed__c":false,"Install_Complete__c":true,"Install_Matl_Left_Warehouse__c":true,"Converted_Lead_Status__c":"Qualified","Days_Lead_Created_to_Installed__c":61,"Owns_Residence__c":true,"Account_Numeric_ID__c":39383,"Numeric_ID__c":"57245","Contracts_Last_Reviewed_By_DC_Date__c":"2016-07-31","EU_Completed_old__c":true,"EU_Assigned_old__c":true,"PVA_Assessment_Complete_Date__c":"2016-09-02","Lease_Uploaded_to_Lease_Billing_System__c":false,"Install_Released_to_Vendor__c":true,"Roof_Assessment_Complete__c":true,"Lead_Numeric_ID_Text__c":"496392","Roof_Assesment_Assigned__c":true,"PV_Month_04__c":0,"Multiple_Owner_Names__c":"Linda Lemon, William Lemon","Number_of_Owners__c":2,"Highest_Electric_Bill_in_Past_12_Months__c":100,"Home_Heating_Method__c":"Natural Gas","Property_Number_Of_Units__c":1,"Is_Portion_of_Roof_Facing_South_or_West__c":false,"People_In_Household__c":2,"Annual_Household_Income__c":100000,"SSN__c":"543513536","EE_work_done_in_Past__c":false,"Customer_Waives_Roof_Layout_Approval__c":false,"Elec_Acct_First_Name__c":"William","Elec_Acct_Last_Name__c":"Lemon","Elec_Acct_Street_1__c":"16 Paulding Ave","Elec_Acct_City__c":"Cold Spring","Elec_Acct_Zip__c":"10516","Date_of_Birth__c":"1980-09-28","Elec_Acct_State__c":"NY","Deferment_Incentive_Months__c":0,"Lower_Monthly_Lease_Payment_Amount__c":0,"Lower_Monthly_Lease_Duration_Months__c":0,"Elec_Acct_Number__c":"74222400025","Requires_Attention_From_Me__c":true,"Need_My_Depts_Action__c":false,"User_Types_With_Next_Action__c":"Customer Liason","Need_My_Action__c":false,"Deposit_Received_Date__c":"2016-09-27","Processing_Fee_Verification__c":false,"Financing_Bill_Payment_Options__c":"Checking / Savings Acct (Auto-pay)","Current_User_Email_Address__c":"posigensupport@salesforcesuperheroes.com","Current_User_ID__c":"005d0000004ZQJf","Create_Property_SP_Name__c":"SF_CreatePropertyFromNewOpp","Utility_Address_Identical_to_Assessors__c":false,"Create_Project_SP_Name__c":"SF_CreateTemplateProjectForOpportunity","EE_Stage__c":"Not Ready for EE","Processing_Fee_Payment_Method__c":"CASH","Age_Signed_to_Submitted__c":1,"Lead_Number_of_Units__c":1,"Lead_Is_Portion_of_Roof_Facing_South_or__c":false,"Interested_In_Solar_Hot_Water__c":false,"Processing_Fee_Not_Verified__c":true,"Lead_Residence_Type__c":"Townhome","Account_Name_Text__c":"Linda Lemon","Are_you_in_a_Homeowner_s_Association__c":false,"Hot_Water_Heating_Method__c":"Oil","Elec_Account_Middle_Name__c":"M","Last_Contracts_Approved_Date__c":"2016-08-01T15:27:35.000+0000","Last_Feasibility_Analysis_Date__c":"2016-08-08T20:53:14.000+0000","Last_Layout_Approval_Date__c":"2016-09-06T13:26:13.000+0000","PV_Assessor_Name__c":"PosiGen NY","Roof_Type__c":"Shingle","Contracts_Initially_Submitted_to_DC_Date__c":"2016-07-30","Current_User_is_CL__c":false,"Financing_is_Checking_or_Savings__c":true,"Financing_is_Credit_Card__c":false,"Financing_is_Online_Pay__c":false,"Financing_is_Postal_Mail__c":false,"Interested_in_Energy_Efficiency__c":true,"Are_you_past_due_on_your_electric_bill__c":false,"Has_PV_As_a_Product__c":true,"Customer_Name_And_Property_Address__c":"at 16 Paulding Ave, Cold Spring NY 10516","Address_Ported_Over_Pre_SF2__c":false,"Full_Address_from_UA__c":"16 Paulding Ave, Cold Spring NY 10516","Has_EE_as_a_Solar_Product__c":true,"Is_Feasible__c":true,"Are_Contracts_Approved__c":true,"Days_Contract_Approved_to_Feasible__c":59,"Days_Feasible_to_Installed__c":0,"Days_Contract_Approved_to_Installed__c":59,"Estimated_Lease_Start_Date__c":"2017-04-26","Deposit_Clearing_Status__c":"Cleared","Deposit_Refunded_On_Date__c":"2016-09-28","Estimated_Cancellation_Date__c":"2016-08-03","Estimated_First_Payment_Date__c":"2016-11-01","Docusign_Fields_Contain_Data__c":true,"Account_Phone__c":"(845) 591-5164","Transaction_Type__c":"Lease","Won__c":true,"Result__c":"Feasible (Smaller System)","Initial_Contracts_Signed_Date__c":"2016-07-29","Contracts_Finally_Submitted_to_DC_Date__c":"2016-07-29","Property_Address__c":"16 Paulding Ave","Property_City__c":"Cold Spring","Property_State__c":"NY","Property_ZIP__c":"10516","Projected_ITC_in_Dollars__c":0,"Financing_Term_in_Months__c":240,"LMS_Account__c":"257245","LMS_Customer_Number__c":"257245","Remaining_Payments_for_Unboarded_Leases__c":240,"Opp_Numeric_ID__c":"57245","Customer_No_Matches__c":true,"Building_Storys__c":"Single Story","Attic_Access__c":"Yes","Account_Last_Name__c":"Lemon","Can_owner_access_utility_bill_online__c":false,"Attic_Type__c":"Interior","Electrical_Service_Panel__c":"Interior","Wegowise_Monitoring__c":false,"Appointment_Kept__c":false,"Bank_Routing_Number__c":"123321","of_Months_Deferred__c":1,"Finance_Type__c":"No Initial Payment","Finance_Option_Code__c":"NI","Send_Invoice__c":true,"Payment_Inclusive_of_Tax__c":true,"Property_Classification__c":"Residential","PVI_Total_Cost__c":343,"EU_Total_Cost__c":243,"State_Tax_Credit_Refund_Date__c":"2016-09-28","Remaining_Lease_Term__c":240,"Are_black_panels_required__c":false,"SF2_Days_Contract_Approved_to_Feasible__c":33,"Pipeline_Stage__c":"Layout Approval","Age_in_Feasibility__c":33,"Materials_Left_WH_Age__c":59,"Age_for_Install_Complete__c":59,"EE_Audit_Age__c":59,"EU_Complete_Age__c":59,"Overall_Customer_Satisfaction_Level__c":"5","Rate_your_customer_liaison_experience__c":"5","Would_you_recommend_family_friends__c":"Yes","Customer_Testimonial__c":"Yes","Customer_Testimonialmessage__c":"fffdssdf<b>asdfadf</b>das f<i>fadf<u>fdasf</u></i>","Retail_Price__c":234,"System_Size_in_KW__c":222,"Payment_Amount_Year_1__c":54.99,"Payment_Amount_Year_10__c":54.99,"Is_PVA_Assessment_Complete_Date_Invalid__c":false,"Is_PL_Stage_Not_Same_as_Snapshot__c":true,"Is_Property_Invalid__c":false,"Is_LMS_Account_Number_Invalid__c":false,"Is_Fund_Invalid__c":false,"Is_EU_Total_Cost_Invalid__c":false,"Is_EU_Completed_Date_Invalid__c":false,"Is_BB_Funding_Amount_Invalid__c":false,"Is_BB_Funding_Date_Invalid__c":false,"Is_PVI_Total_Cost_Invalid__c":false,"Is_PVI_Placed_In_Service_Date_Invalid__c":false,"Is_PVI_Rails_Panels_Left_WH_Date_Inval__c":false,"Is_Contracts_Approved_Date_Invalid__c":false,"Is_ITC_Funding_Amount_Invalid__c":false,"Is_ITC_Funding_Recd_Date_Invalid__c":false,"Is_State_Tax_Credit_Refund_Date_Invalid__c":false,"Is_State_Tax_Credit_Refund_Amount_Invali__c":false,"Is_Retail_Price_Invalid__c":false,"Is_System_Size_in_KW_Invalid__c":false,"Is_Lease_Amount_Invalid__c":false,"Is_Lease_Start_Date_Invalid__c":false,"Is_Last_Month_PV_Production_Invalid__c":false,"Is_EU_Projected_Electrical_kWh_yr_Saving__c":false,"Is_EU_Projected_Nat_Gas_Therms_yr_Saving__c":false,"Is_EU_Projected_Nat_Gas_Savings_yr_Inv__c":false,"Is_EU_Projected_Electrical_Savings_yr__c":false,"LMS_Number_from_Opp__c":257245,"Num_of_LD_Leases__c":0,"Bill_to_Contact_Name__c":"Linda Lemon","Bill_to_Contact_Phone__c":"(845) 591-5164","Bill_to_Contact_E_mail__c":"linda2753@aol.com","Energy_Efficiency_Charge__c":10,"Payment_Amount_Year_11__c":54.99,"Payment_Amount_Year_12__c":54.99,"Payment_Amount_Year_13__c":54.99,"Payment_Amount_Year_14__c":54.99,"Payment_Amount_Year_15__c":54.99,"Payment_Amount_Year_16__c":54.99,"Payment_Amount_Year_17__c":54.99,"Payment_Amount_Year_18__c":54.99,"Payment_Amount_Year_19__c":54.99,"Payment_Amount_Year_2__c":54.99,"Payment_Amount_Year_20__c":54.99,"Payment_Amount_Year_3__c":54.99,"Payment_Amount_Year_4__c":54.99,"Payment_Amount_Year_5__c":54.99,"Payment_Amount_Year_6__c":54.99,"Payment_Amount_Year_7__c":54.99,"Payment_Amount_Year_8__c":54.99,"Payment_Amount_Year_9__c":54.99,"Send_Invoice_Text__c":"Y","Payment_Inclusive_of_Tax_Text__c":"Y","Fair_Market_Value__c":0,"Lease_System_Monthly_Payment__c":54.99,"Lease_System_Term__c":240,"Lease_System_Lease_Amount__c":13197.6,"Validation_EE_Monthly_Payment__c":10,"EE_Term__c":240,"EE_Amount__c":2400,"Missing_Lease_Info__c":false,"Rebate_Program__c":"CEFIA","Rebate_Incentive_Program__c":"CEFIA Solar Lease 2 (AFC)","Rebate_Program_Stage__c":"Not Submitted","Rebate_Incentive_Amount__c":200,"Opp_Derived_Term__c":4,"Estimated_Lease_Amount__c":15598,"Lease_Validated_Lease_Amount__c":15598,"EE_Lease_Amount__c":1200,"Pay_via_ACH__c":"Yes","Has_Been_Boarded__c":false,"Copy_of_Pipeline_Stage__c":"Schedule Appointment","Num_of_Properties__c":1,"Sales_Tax_Rate__c":9,"Account_Email__c":"linda2753@aol.com","Rebate_Submission_Date__c":"2016-09-28","EA_Status__c":"Active","Assessor_Owner_Name_1__c":"William L Lemon","Assessor_Owner_Name_2__c":"Linda A LeMon","Revised_Contract_Submitted_to_DC_Date__c":"2016-09-28","Power_of_1__c":1,"Reduced_Lease_Promo__c":false,"Opportunity_ID__c":"006d000000porcp","Account_ID__c":"001d0000024HZ8kAAG","PV_Installer_Name__c":"PosiGen NY","Contracts_Signed_Date__c":"2016-07-29","EE_Pipeline_Stage__c":"Pending EA","Redeployed_System__c":false,"Elec_Acct_Full_Name__c":"William M Lemon","Payment_Amount_Year_1_Month_1__c":54.99,"Payment_Amount_Year_1_Month_2__c":54.99,"Payment_Amount_Year_1_Month_3__c":54.99,"Payment_Amount_Year_1_Month_4__c":54.99,"Payment_Amount_Year_1_Month_5__c":54.99,"Payment_Amount_Year_1_Month_6__c":54.99,"Payment_Amount_Year_1_Month_7__c":54.99,"Payment_Amount_Year_1_Month_8__c":54.99,"Payment_Amount_Year_1_Month_9__c":54.99,"Payment_Amount_Year_1_Month_10__c":54.99,"Payment_Amount_Year_1_Month_11__c":54.99,"Payment_Amount_Year_1_Month_12__c":54.99,"ACS_Median_Income__c":73125,"Census_Tract__c":"36079010700","State_Median_Income__c":58003,"LMI__c":false,"Contract_Applicant_Name__c":"William L Lemon","Contract_Joint_Applicant_Name__c":"Linda A LeMon","Approved_DocuSign_Packet__c":true,"Rejected_DocuSign_Packet__c":false,"Referree_Contact_Id__c":"003d0000033zCLz","Rebate_Completion_Date__c":"2016-09-28","Client_has_a_unique_ownership_situation__c":false,"PV_Feasibility_NAME__c":"PV Feasibility for Linda Lemon @ 16 Paulding Ave, Cold Spring, NY 10516","PV_Install_NAME__c":"PV Install for Linda Lemon @ 16 Paulding Ave, Cold Spring, NY 10516","Has_Referral__c":false,"NVM_Phone__c":"(845) 591-5164","Total_Commission_with_Bonus__c":0,"Population_Density__c":"Not Updated","Payment_Escalator__c":false,"O_Box_Folder_Id__c":"9100248753","Commission_Charged_Back__c":false,"Sub_Lead_Source__c":"Door Knocking","SAD__c":"2016-07-29","Are_You_Interested_In_Solar_Hot_Water__c":false,"Family_Friend_Contact_1__c":"son","Family_Friend_Contact_2__c":"son","Levelized_Billing__c":false,"Electric_Usage_1__c":550,"Electric_Usage_2__c":550,"Electric_Usage_3__c":700,"Electric_Usage_4__c":700,"Electric_Usage_5__c":1000,"Electric_Usage_6__c":1100,"Electric_Usage_7__c":1300,"Electric_Usage_8__c":1300,"Electric_Usage_9__c":700,"Electric_Usage_10__c":700,"Electric_Usage_11__c":550,"Electric_Usage_12__c":550,"Referrer_confirmed__c":"false","Account_Home_Phone__c":"(845) 591-5164","Account_Monthly_Income__c":5000,"Secondary_Applicant_Monthly_Income__c":0,"Account_DOB__c":"1953-07-29","Account_SSN__c":"059482942","Account_Employer__c":"NYP Hudson Valley Hospital","Account_Employer_Phone__c":"(914) 734-3896","Aging_Submit_to_Approve__c":0,"Aging_Signed_to_Approve__c":0,"GreenSky_Processed__c":false,"ISS_Charged_Back__c":false,"Total_ISS_Commission_with_Bonus__c":0,"PV_Month_05__c":0,"PV_Month_06__c":0,"Touch_Milestones__c":"Intro Call","PV_Month_07__c":54.99,"PV_Month_08__c":54.99}';
	private static String sampleDealJSON = '{"attributes":{"type":"Deal__c","url":"/services/data/v37.0/sobjects/Deal__c/' + string.valueOf(Schema.SObjectType.Prospect__c.getKeyPrefix()) + '"},"Opportunity_Name__c":"test deal","IsDeleted":false,"Name":"4.5KW Qianna Thomas-@281 West Oakland Street, St Rose, LA","CreatedDate":"2016-09-28T03:48:41.000+0000","CreatedById":"005d0000004ZQJfAAO","LastModifiedDate":"2016-09-28T20:46:51.000+0000","LastModifiedById":"005d0000004ZQJfAAO","Probability__c":20,"SystemModstamp":"2016-09-28T20:46:51.000+0000","LastViewedDate":"2016-09-28T20:46:54.000+0000","LastReferencedDate":"2016-09-28T20:46:54.000+0000","ACH_Payment_Date__c":"1","ACS_Median_Income__c":2,"A_R_Outstanding__c":2,"Ach_Debit__c":"s","Address_Ported_Over_Pre_SF2__c":false,"Electrical_Service_Panel__c":"Exterior","Energy_Audit_Completed_Date__c":"2016-09-28","Energy_Efficiency_Assessor__c":"John","Last_Client_Signed_Date__c":"2016-09-28T20:43:00.000+0000","Last_Closed_Lost_Date__c":"2016-09-28T20:43:00.000+0000","Last_Closed_Won_Date__c":"2016-09-28T20:43:00.000+0000","Last_Contract_Revision_Date__c":"2016-09-28T20:43:00.000+0000","Last_Contracts_Approved_Date__c":"2016-09-28T20:43:00.000+0000","Last_Contracts_Rejected_by_DC_Date__c":"2016-09-28T20:43:00.000+0000","Last_Contracts_Rejected_by_UW_Date__c":"2016-09-28T20:43:00.000+0000","Last_Contracts_Submitted_to_DC_Date__c":"2016-09-28T20:43:00.000+0000","Last_Contracts_Submitted_to_UW_Date__c":"2016-09-28T20:43:00.000+0000","Last_Feasibility_Analysis_Date__c":"2016-09-28T20:43:00.000+0000","Last_Input_Documents_Date__c":"2016-09-28T20:43:00.000+0000","Last_Layout_Approval_Date__c":"2016-09-28T20:43:00.000+0000","Last_Release_to_Installer_Date__c":"2016-09-28T20:43:00.000+0000","Last_Reschedule_Appointment_Date__c":"2016-09-28T20:43:00.000+0000","Last_Sales_Appt_Update__c":"2016-09-28T20:43:00.000+0000","Last_Schedule_Appointment_Date__c":"2016-09-28T20:43:00.000+0000","Last_Unknown_Need_to_Research_Date__c":"2016-09-28T20:43:00.000+0000","Layout_Approval_Required__c":false,"Lead_Age_Converted__c":0,"Lead_Is_Portion_of_Roof_Facing_South_or__c":false,"Lead_Number_of_Units__c":1,"Lead_Numeric_ID_Text__c":"498803","Lead_Residence_Type__c":"Stand-Alone House","Lease_Account_Name__c":"d","Lease_Started__c":false,"Lease_System_Lease_Amount__c":0,"Lease_Uploaded_to_Lease_Billing_System__c":false,"Levelized_Billing__c":true,"X1st_Full_Payment__c":"2016-09-28","ACH_Chosen__c":true,"Account_Address_1__c":"281 West Oakland Street","Account_City__c":"St. Rose","Account_DOB__c":"1981-01-15","Account_Email__c":"qianna49@hotmail.com","Account_Employer__c":"Self Employed","Account_ID__c":"001d0000024JhbF","Account_Last_Name__c":"Thomas","Account_Mobile__c":"(504) 914-6395","Account_Monthly_Income__c":1500,"Account_Name_Text__c":"Qianna Thomas","Account_Numeric_ID__c":40873,"Account_Phone__c":"(504) 914-6395","Account_SSN__c":"435430925","Account_State__c":"Louisiana","Account_Zip__c":"70084","Age_Signed_to_Submitted__c":0,"Age_for_Install_Complete__c":1,"Age_in_Feasibility__c":1,"Age_of_Home__c":3,"Aging_Reject_to_Approve__c":0,"Aging_Signed_to_Approve__c":-1,"Aging_Submit_to_Approve__c":0,"Aging_Submit_to_Reject__c":0,"Amount__c":234,"Annual_Household_Income__c":18000,"Appointment_Kept__c":false,"Appointment_Required__c":false,"Approved_DocuSign_Packet__c":false,"Approved_by_3rd_Party_Paid__c":"2016-09-28","Are_Contracts_Approved__c":true,"Are_You_Interested_In_Solar_Hot_Water__c":false,"Are_black_panels_required__c":true,"Are_you_in_a_Homeowner_s_Association__c":true,"Are_you_past_due_on_your_electric_bill__c":false,"Area__c":"Mid Fort","Area_of_Home__c":234,"Assessor_Owner_Name_1__c":"Qianna R. Thomas","Assessors_Page_Signed__c":"2016-09-28","Attic_Access__c":"Yes","Attic_Type__c":"Interior","BB_Funding_Amount__c":432,"BB_Funding_Date__c":"2016-09-28","Bank_Account_Number__c":"234234","Bank_Routing_Number__c":"53242","Bill_to_Contact_E_mail__c":"qianna49@test.com","Bill_to_Contact_Name__c":"Qianna Thomas","Bill_to_Contact_Phone__c":"(504) 914-6395","Billing_Packet_Approved_Date__c":"2016-09-28","Bonus_Amount__c":4,"Bonus_Paid_Date__c":"2016-09-28","Booking_Date__c":"2016-09-28","Breaker_Box_Picture__c":false,"Building_Storys__c":"Single Story","CR_Rebate_Received__c":"2016-09-28","CR_Submission_Date__c":"2016-09-28","Can_owner_access_utility_bill_online__c":false,"Census_Tract__c":"s","Certificate_Ordered_Date__c":"2016-09-28","Certificate_Received_Date__c":"2016-09-28","Clearesult_Submission_Date__c":"2016-09-28","Client_has_a_unique_ownership_situation__c":false,"CloseDate__c":"2016-09-30","Closed_Lost_Abandoned_Reason_Detail__c":"asdfdsa fasdff dsa","Closed_Lost_Abandoned_Reason__c":"Not Feasible","Closed_Lost__c":false,"Co_Owner_Date_of_Birth__c":"1950-09-27","Co_Owner_Email__c":"test@test.com","Co_Owner_Employer_Contact_Name__c":"das","Co_Owner_Employer_Phone__c":"4324","Co_Owner_Employer__c":"bill Myrraty","Co_Owner_Mobile_Phone__c":"432523","Co_Owner_Monthly_Income__c":2343,"Co_Owner_SSN__c":"324","Co_Owner_Work_Phone__c":"4324","Commencement_Date__c":"2016-09-28","Commission_Amount__c":2,"Commission_Approved_Payout_Date__c":"2016-09-28","Commission_Approved_Payout__c":23,"Commission_Charged_Back__c":false,"Commission_Description__c":"fdafdsa sdaff dsahgh","Commission_Install_Payout_Date__c":"2016-09-28","Commission_Paid_Date__c":"2016-09-28","Commission_Tier__c":2,"Confirmed_home_is_not_a_double__c":"No","Consulting_Agreement__c":"2016-09-28","Contract_Applicant_Name__c":"Qianna R. Thomas","Contracts_Approved_Date__c":"2016-09-27","Contracts_Finally_Submitted_to_DC_Date__c":"2016-09-27","Contracts_Initially_Submitted_to_DC_Date__c":"2016-09-27","Contracts_Last_Reviewed_By_DC_Date__c":"2016-09-27","Contracts_Rejected_By_DC_Date__c":"2016-09-27","Contracts_Signed_Date__c":"2016-09-27","Copy_of_Pipeline_Stage__c":"Schedule Appointment","Country__c":"United States","Create_Project_SP_Name__c":"SF_CreateTemplateProjectForOpportunity","Create_Property_SP_Name__c":"SF_CreatePropertyFromNewOpp","Created_Month__c":"2016-09-02","Current_User_Email_Address__c":"posigensupport@salesforcesuperheroes.com","Current_User_ID__c":"005d0000004ZQJf","Current_User_is_CL__c":false,"Customer_Hold_Expiry__c":"2016-09-28","Customer_Incentive__c":"asdf","Customer_Name_And_Property_Address__c":"at 281 West Oakland Dr., St. Rose LA 70087","Customer_No_Matches__c":true,"Customer_Service_Survey__c":"Exuberant","Customer_Testimonial__c":"Yes","Customer_Testimonialmessage__c":"fdsafsd<strike>fdaf dsa</strike>","Customer_Waives_Roof_Layout_Approval__c":false,"Date_Electrical_Completed__c":"2016-09-28","Date_Install_Material_Equip_Left_Whse__c":"2016-09-28","Date_PV_Electrical_Left_W_H__c":"2016-09-28","Date_Released_to_Contractor__c":"2016-09-28","Date_Released_to_EE__c":"2016-09-28","Date_Released_to_Installer__c":"2016-09-28","Date_of_Birth__c":"2016-09-28","Date_of_Customer_Survey__c":"2016-09-28","Days_Contract_Approved_to_EU_Complete__c":1,"Days_Contract_Approved_to_Installed__c":1,"Days_Final_Inspection__c":1,"Days_Install_Completed__c":1,"Days_Install_Released__c":1,"Days_Lead_Created_to_Installed__c":29,"Days_Matl_Out_of_WH_to_Install_Complete__c":0,"Days_Mtrls_leave_Whse__c":1,"Deferment_Incentive_Months__c":0,"Deferral_Start_Date__c":"2016-09-28","Deposit_Received_Date__c":"2016-09-28","Deposit_Refunded_On_Date__c":"2016-09-28","Description__c":"kjhbkj","Diagram__c":false,"Disconnect_Status__c":"Never Disconnected","Docusign_Fields_Contain_Data__c":true,"Driver_s_License_State_ID__c":"2016-09-28","EA_Assigned_Date__c":"2016-09-28","EA_Completed_Date__c":"2016-09-28","EE_Amount__c":0,"EE_Audit_Age__c":1,"EE_Lease_Amount__c":1200,"EE_Pipeline_Stage__c":"Pending EA","EE_Stage__c":"Not Ready for EE","EE_work_done_in_Past__c":false,"EU_Assigned_Date__c":"2016-09-28","EU_Assigned_old__c":true,"EU_Complete_Age__c":1,"EU_Completed_Date__c":"2016-09-28","EU_Completed_old__c":true,"EU_Projected_Elec_Savings_DlrsPerYr__c":567,"EU_Projected_Elec_kWh_perYear_Savings__c":455,"EU_Projected_NG_Therms_PerYear_Savings__c":754,"EU_Projected_Nat_Gas_Savings_yr__c":654,"EU_Status__c":"s","EU_Total_Cost__c":345,"Earliest_Lease_Maturity_Date__c":"2016-09-28","Elec_Acct_First_Name__c":"Quianna","Elec_Acct_Full_Name__c":"Quianna Thomas","Elec_Acct_Last_Name__c":"Thomas","Elec_Acct_Number__c":"77062834","Elec_Acct_Street_1__c":"281 W Oakland St St Rose LA 70087","Energy_Efficiency_Charge__c":10,"Energy_Efficiency_Complete_Date__c":"2016-09-28","Energy_Efficiency_Completion_Date__c":"2016-09-28","Energy_Upgrade_Invoice_Date__c":"2016-09-28","Estimated_Cancellation_Date__c":"2016-09-08","Estimated_First_Payment_Date__c":"2016-11-01","Estimated_Lease_Amount__c":0,"Estimated_Rebate_Amount_in_Dollars__c":231,"ExpectedRevenue__c":6546,"FICO_validated__c":"***","Fair_Market_Value__c":0,"Family_Friend_Contact_1__c":"sdfggs","Family_Friend_Contact_2__c":"fdsgfdg","Feasible_Solar_Hot_Water_Heater__c":"Yes","Feasible_Solar__c":"4 kw","Feasible_Stage__c":"Install Completed","Federal_Grant_ITC_Status__c":"Submitted","Final_3rd_Party_Inspection_Compete_Date__c":"2016-09-28","Final_Inspection_Notification_Received__c":"2016-09-28","Finance_Option_Code__c":"NI","Finance_Type__c":"No Initial Payment","Financing_Bill_Payment_Options__c":"Checking / Savings Acct (Auto-pay)","Financing_Term_in_Months__c":0,"Financing_is_Checking_or_Savings__c":true,"Financing_is_Credit_Card__c":false,"Financing_is_Online_Pay__c":false,"Financing_is_Postal_Mail__c":false,"First_Closing_Call_Made__c":false,"First_Intro_Call_Made__c":false,"First_Payment_Date__c":"2016-09-28","First_Payment_Due_Dat__c":"2016-09-28","First_Payment_Due_Date_Default__c":"2016-11-01","First_Payment_Due_Date_Override__c":"2016-09-28","Forecast_Category__c":"Omitted","Full_Address_from_UA__c":"281 W Oakland St St Rose LA 70087,","Funded_by_ITC_Investor__c":"2016-09-28","Funded_by_Iberia__c":"2016-09-28","Funded_by_KWF__c":"2016-09-28","Funded_by_US_Bank__c":"2016-09-28","GG_Number__c":"34","GreenSky_Expiration__c":"2016-09-28","GreenSky_Processed__c":false,"HDLC_Approval__c":false,"Has_Been_Boarded__c":false,"Has_EE_as_a_Solar_Product__c":true,"Has_PV_As_a_Product__c":true,"Has_Referral__c":false,"Home_Heating_Method__c":"Natural Gas","Hot_Water_Heater__c":"Gas","Hot_Water_Heating_Method__c":"Propane","ISS_Appointment_Payout_Date__c":"2016-09-28","ISS_Approved_Payout_Date__c":"2016-09-28","ISS_Bonus_Amount__c":123,"ISS_Bonus_Paid_Date__c":"2016-09-28","ISS_Charged_Back__c":false,"Included_in_Commission_Run__c":false,"Infomercial_Type__c":"Late Night","Informed_Net_Meter_Installed_Date__c":"2016-09-28","Initial_Contracts_Signed_Date__c":"2016-09-28","Initial_Payment_in_Dollars__c":3213,"Inspection_Notes__c":"asdsaD","Inspection_Received_Date__c":"2016-09-28","Inspection_Request_Date__c":"2016-09-28","Install_Complete__c":true,"Install_Completed__c":"2016-09-28","Install_Crew__c":"Matiled","Install_Matl_Left_Warehouse__c":true,"Install_Passed_Final_Inspection__c":"2016-09-28","Install_Released__c":"2016-09-28","Install_Released_to_Vendor__c":true,"Install_Scheduled__c":"2016-09-28","Intake_Questionnaire__c":"2016-09-28","Interconnection_Date__c":"2016-09-28","Interested_In_Solar_Hot_Water__c":false,"Interested_in_Energy_Efficiency__c":true,"Inverter_Make_Model__c":"SS","Inverter_Serial_Number_from_System__c":"234324","Inverter__c":"String","IsPrivate__c":false,"Is_Feasible__c":false,"Joint_Applicant_First_Name__c":"asdf","Joint_Applicant_Last_Name__c":"fda","Joint_Applicant_Middle_Name__c":"a","LMI__c":true,"LMS_Account__c":"200006","LMS_Customer_Number__c":"200006","LMS_Number_from_Opp__c":200006,"Lease_Validated_Lease_Amount__c":0,"Lock_Promo__c":false,"Long_ID__c":"a5G17000000CbDhEAK","Lower_Monthly_Lease_Duration_Months__c":0,"Materials_Left_WH_Age__c":1,"Missing_Lease_Info__c":true,"Mobile_Number__c":"(504) 914-6395","Monitoring_Data_Verified__c":false,"NMIA_verified__c":false,"Need_My_Depts_Action__c":false,"Net_Meter_Installed__c":false,"Num_of_Properties__c":1,"Number_of_Owners__c":1,"Numeric_ID__c":"6","O_Box_Folder_Id__c":"11127662059","Opp_Numeric_ID__c":"6","Opportunity_ID__c":"a5G17000000CbDh","Owns_Residence__c":false,"PV_Feasibility_NAME__c":"PV Feasibility for Qianna Thomas @ 281 West Oakland Street, St. Rose, LA 70084","PV_Install_NAME__c":"PV Install for Qianna Thomas @ 281 West Oakland Street, St. Rose, LA 70084","Page_4__c":false,"Panel_Post_Install_Picture__c":false,"Pay_via_ACH__c":"Yes","Payment_Amount_Year_10__c":0,"Payment_Amount_Year_11__c":0,"Payment_Amount_Year_12__c":0,"Payment_Amount_Year_13__c":0,"Payment_Amount_Year_14__c":0,"Payment_Amount_Year_15__c":0,"Payment_Amount_Year_16__c":0,"Payment_Amount_Year_17__c":0,"Payment_Amount_Year_18__c":0,"Payment_Amount_Year_19__c":0,"Payment_Amount_Year_1_Month_10__c":-10,"Payment_Amount_Year_1_Month_11__c":-10,"Payment_Amount_Year_1_Month_12__c":-10,"Payment_Amount_Year_1_Month_1__c":-10,"Payment_Amount_Year_1_Month_2__c":-10,"Payment_Amount_Year_1_Month_3__c":-10,"Payment_Amount_Year_1_Month_4__c":-10,"Payment_Amount_Year_1_Month_5__c":-10,"Payment_Amount_Year_1_Month_6__c":-10,"Payment_Amount_Year_1_Month_7__c":-10,"Payment_Amount_Year_1_Month_8__c":-10,"Payment_Amount_Year_1_Month_9__c":-10,"Payment_Amount_Year_1__c":-10,"Payment_Amount_Year_20__c":0,"Payment_Amount_Year_2__c":0,"Payment_Amount_Year_3__c":0,"Payment_Amount_Year_4__c":0,"Payment_Amount_Year_5__c":0,"Payment_Amount_Year_6__c":0,"Payment_Amount_Year_7__c":0,"Payment_Amount_Year_8__c":0,"Payment_Amount_Year_9__c":0,"Payment_Escalator__c":false,"Payment_Inclusive_of_Tax_Text__c":"Y","Payment_Inclusive_of_Tax__c":true,"People_In_Household__c":4,"Permanent_Removal__c":false,"Photo_of_House__c":true,"Photo_of_Panel__c":true,"Population_Density__c":"Not Updated","Power_of_1__c":1,"Primary_Reference_Home_Phone__c":"55","Processing_Fee_Not_Verified__c":true,"Processing_Fee_Verification__c":false,"Projected_ITC_in_Dollars__c":0,"Property_Address__c":"281 West Oakland Dr.","Property_City__c":"St. Rose","Property_Classification__c":"Residential","Property_Number_Of_Units__c":1,"Property_State__c":"LA","Property_ZIP__c":"70087","Redeployed_System__c":false,"Referral_Instructions__c":"Before this Opp can be flagged as Client Signed, the Referral Detail must correctly document if this Customer was referred to us.  Please look up the Referrer and add him or her below.  If you cannot find them, please create a new Account for them then select it under Referrer.","Referree_Contact_Id__c":"003d0000036YBg6","Rejected_DocuSign_Packet__c":false,"Remaining_Payments_for_Unboarded_Leases__c":0,"Requires_Attention_From_Me__c":true,"Roof_Assesment_Assigned__c":true,"Roof_Assessment_Complete__c":true,"SAD__c":"2016-09-01","SF2_Days_EA_Complete_to_EU_Complete__c":0,"Savings_Guarantee__c":"Waives the Savings Guarantee","Secondary_Applicant_Monthly_Income__c":0,"Secondary_Reference_Home_Phone__c":"435","Secondary_Reference_Name__c":"bob","Send_Invoice_Text__c":"Y","Send_Invoice__c":true,"Solar_Electric_System__c":"X","Solar_Product__c":"Energy Efficiency;Solar Panels","StageName__c":"Schedule Appointment","State_Median_Income__c":44874,"Total_Commission_with_Bonus__c":29,"Total_ISS_Commission_with_Bonus__c":123,"Transaction_Type__c":"Lease","User_Types_With_Next_Action__c":"Telemarketer","Utility_Address_Identical_to_Assessors__c":false,"Wegowise_Monitoring__c":false,"Won__c":false,"of_Months_Deferred__c":1,"Market__c":"LA 6.0"}';
	
	private static User sampleAdminUser = new User();
	private static Lead sampleLeadRecord = new Lead(); 
	private static Lead[] sampleListOfLeads = new Lead[]{};
	private static Prospect__c sampleProspectRecord = new Prospect__c();
	private static Opportunity sampleOpportunityRecord = new Opportunity();
	private static Opportunity[] sampleListOfOpportunities = new Opportunity[]{};
	private static Deal__c sampleDealRecord = new Deal__c();
	private static Account sampleAccountRecord = new Account();
	private static Account sampleMunicipalityAccountRecord = new Account();
	private static System_Part__c[] sampleListOfSystemParts = new System_Part__c[]{};
	private static Issue__c sampleIssueRecord = new Issue__c();
	private static Issue_Comment__c sampleIssueCommentRecord = new Issue_Comment__c();
	private static Task[] sampleListOfTasks = new Task[]{};
	private static Event[] sampleListOfEvents = new Event[]{};
	
	/*
		Special Considerations:
			1.) The process builder on lead object "Lead Add to Campaign" was failing on insertion of lead. To fix we implemented a checkbox on lead named OverrideProcessBuilder__c.
				-Marking this checkbox true will bypass the process builder in the unit tests.
				-Files affected by this:
					-TEST_Synchronization.cls (this class) - all lead unit tests will set checkbox true before insertion of lead record
					-SynchronizationEngine.cls - if and only if unit test is running, then the checkbox on the lead will be set to true
		
		
		FIELDS_TO_SKIP_FOR_OPPORTUNITY reasons for skipping:
			-expectedrevenue: not an editable field on opportunity. This however is not caught by the SF function isCalculated() and isAutoNumber() methods.
			-last_schedule_appointment_date: a workflow is updating this field after sync occurs to Opportunity record.
			-pv_assessor_name: a workflow is updating this field after sync occurs to Opportunity record.
			-copy_of_pipeline_stage: a workflow is updating this field after sync occurs to Opportunity record.
			-pv_installer_name: a workflow is updating this field after sync occurs to Opportunity record.
			-nvm_phone: a workflow is updating this field after sync occurs to Opportunity record.
	*/
	private static final Set<String> TEMPORARY_FIELDS_TO_SKIP_FOR_OPPORTUNITY = new Set<String>{
																						'expectedrevenue',
																						'last_schedule_appointment_date',
																						'last_layout_approval_date',
																						'pv_assessor_name',
																						'copy_of_pipeline_stage',
																						'pv_installer_name',
																						'nvm_phone'
																						};/*'feasible_stage'*/ 
	
/*LEAD TO PROSPECT UNIT TESTS*/
    static testMethod void test_Insert_LeadToProspect() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        sampleLeadRecord.OverrideProcessBuilder__c = true;
        insert sampleLeadRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //query inserted record before sync, in case workflows fired causing field updates
        sampleLeadRecord = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleLeadRecord.Id), 'Lead', 'Id = \'' + sampleLeadRecord.Id + '\''));
        
        //query both objects
        sampleLeadRecord = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleLeadRecord.Id), 'Lead', 'Id = \'' + sampleLeadRecord.Id + '\''));
        Prospect__c syncedProspect = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Prospect__c.getSobjectType()), 'Prospect__c ', 'Lead__c = \'' + sampleLeadRecord.Id + '\''));
        
        //retrieve fields for each object
        Map<String, Schema.sObjectField> leadFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(sampleLeadRecord.getsObjectType());
        Map<String, Schema.sObjectField> prospectFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(syncedProspect.getsObjectType());
        system.assert(leadFieldMap.size() > 0);
        system.assert(prospectFieldMap.size() > 0);
        
        //asserts
        for(String key : leadFieldMap.keySet()){
        	//loop over all fields and assert the lead field value matches the prospect field value
        	if(SynchronizationEngine.verifyIfFieldIsEditable(key, leadFieldMap, prospectFieldMap)){
    			system.assertEquals(sampleLeadRecord.get(leadFieldMap.get(key)), syncedProspect.get(prospectFieldMap.get(key)), key);
        	}
        	else{
    			system.debug('field not present in field mapping: ' + key);
    		}
        }
        
        Test.stopTest();
    }
    
    static testMethod void test_Update_LeadToProspect() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        sampleLeadRecord.OverrideProcessBuilder__c = true;
        insert sampleLeadRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //update a few fields on standard record
        sampleLeadRecord.LastName = 'Haroldeen';
        sampleLeadRecord.Email = 'Haroldeen@test.com';
        sampleLeadRecord.Phone = '555-5555';
        update sampleLeadRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //query both objects
        sampleLeadRecord = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleLeadRecord.Id), 'Lead', 'Id = \'' + sampleLeadRecord.Id + '\''));
        Prospect__c syncedProspect = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Prospect__c.getSobjectType()), 'Prospect__c ', 'Lead__c = \'' + sampleLeadRecord.Id + '\''));
        
        //retrieve fields for each object
        Map<String, Schema.sObjectField> leadFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(sampleLeadRecord.getsObjectType());
        Map<String, Schema.sObjectField> prospectFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(syncedProspect.getsObjectType());
        system.assert(leadFieldMap.size() > 0);
        system.assert(prospectFieldMap.size() > 0);
        
        //asserts
        for(String key : leadFieldMap.keySet()){
        	//loop over all fields and assert the lead field value matches the prospect field value
        	if(SynchronizationEngine.verifyIfFieldIsEditable(key, leadFieldMap, prospectFieldMap)){
    			system.assertEquals(sampleLeadRecord.get(leadFieldMap.get(key)), syncedProspect.get(prospectFieldMap.get(key)), key);
    		}
        	else{
    			system.debug('field not present in field mapping: ' + key);
    		}
        }
        
        Test.stopTest();
    }
    
    static testMethod void test_Delete_LeadToProspect() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        sampleLeadRecord.OverrideProcessBuilder__c = true;
        insert sampleLeadRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        Id leadId = sampleLeadRecord.Id;
        system.assertNotEquals(null, leadId);
        
        //perform deletion of standard record
        delete sampleLeadRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //attempt to query to deleted records
        Lead[] queriedLead = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getSobjectType()), 'Lead', 'Id = \'' + leadId + '\''));
        Prospect__c[] queriedProspect = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Prospect__c.getSobjectType()), 'Prospect__c', 'Lead__c = \'' + leadId + '\''));
        
        //asserts
        system.assertEquals(0, queriedLead.size());
        system.assertEquals(0, queriedProspect.size());
        
        Test.stopTest();
    }
    
/*PROSPECT TO LEAD UNIT TESTS*/
    static testMethod void test_Insert_ProspectToLead() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        sampleProspectRecord.OverrideProcessBuilder__c = true;
        insert sampleProspectRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //query prospect
		sampleProspectRecord = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleProspectRecord.Id), 'Prospect__c', 'Id = \'' + sampleProspectRecord.Id + '\''));
		
		//assert that the prospect was linked to a lead
		system.assertNotEquals(null, sampleProspectRecord.Lead__c);
		
		//query lead
		Lead syncedLead = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getSobjectType()), 'Lead', 'Id = \'' + sampleProspectRecord.Lead__c + '\''));
        
        //retrieve fields for each object
		Map<String, Schema.sObjectField> prospectFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(sampleProspectRecord.getsObjectType());
		Map<String, Schema.sObjectField> leadFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(syncedLead.getsObjectType());
		system.assert(leadFieldMap.size() > 0);
        system.assert(prospectFieldMap.size() > 0);
        
        //asserts
		for(String key : prospectFieldMap.keySet()){
			//loop over all fields and assert the lead field value matches the prospect field value
			if(SynchronizationEngine.verifyIfFieldIsEditable(key, prospectFieldMap, leadFieldMap)){
				system.assertEquals(sampleProspectRecord.get(prospectFieldMap.get(key)), syncedLead.get(leadFieldMap.get(key)), key);
			}
			else{
				system.debug('field not present in field mapping: ' + key);
			}
		}
		
		Test.stopTest();
    }
    
    static testMethod void test_Update_ProspectToLead() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        sampleProspectRecord.OverrideProcessBuilder__c = true;
        insert sampleProspectRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //update a few fields on mirror record
        sampleProspectRecord.LastName__c = 'Haroldeen';
        sampleProspectRecord.Email__c = 'Haroldeen@test.com';
        sampleProspectRecord.Phone__c = '555-5555';
        update sampleProspectRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
          
        //query prospect
        sampleProspectRecord = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleProspectRecord.Id), 'Prospect__c', 'Id = \'' + sampleProspectRecord.Id + '\''));
        //assert that the prospect was linked to a lead
		system.assertNotEquals(null, sampleProspectRecord.Lead__c);
        
        //query lead
        Lead syncedLead = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getsObjectType()), 'Lead', 'Id = \'' + sampleProspectRecord.Lead__c + '\''));
        
        //retrieve fields for each object
        Map<String, Schema.sObjectField> leadFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(syncedLead.getsObjectType());
        Map<String, Schema.sObjectField> prospectFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(sampleProspectRecord.getsObjectType());
        system.assert(leadFieldMap.size() > 0);
        system.assert(prospectFieldMap.size() > 0);
        
        //asserts
        for(String key : prospectFieldMap.keySet()){
        	//loop over all fields and assert the lead field value matches the prospect field value
        	if(SynchronizationEngine.verifyIfFieldIsEditable(key, prospectFieldMap, leadFieldMap)){
    			system.assertEquals(sampleProspectRecord.get(prospectFieldMap.get(key)), syncedLead.get(leadFieldMap.get(key)), key);
        	}
        	else{
    			system.debug('field not present in field mapping: ' + key);
    		}
        }
        
        Test.stopTest();
    }
    
    static testMethod void test_Delete_ProspectToLead() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        sampleProspectRecord.OverrideProcessBuilder__c = true;
        insert sampleProspectRecord;
        Id prospectId = sampleProspectRecord.Id; //store id before deletion to allow for querying
        
        //query prospect to get the lead id related to prospect
        Prospect__c[] queriedProspect = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(prospectId), 'Prospect__c', 'Id = \'' + prospectId + '\''));
        Id leadId = queriedProspect[0].Lead__c;
        system.assertEquals(1, queriedProspect.size());
        system.assertNotEquals(null, leadId);
        
        //perform deletion of mirror record
        delete sampleProspectRecord;
        
        //attempt to query the delete records
        queriedProspect = new Prospect__c[]{};
        queriedProspect = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleProspectRecord.Id), 'Prospect__c', 'Id = \'' + prospectId + '\''));
        Lead[] queriedLead = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getsObjectType()), 'Lead', 'Id = \'' + leadId + '\''));
        
        //asserts
        system.assertEquals(0, queriedProspect.size());
        system.assertEquals(0, queriedLead.size());
        
        Test.stopTest();
    }
    
/*OPPORTUNITY TO DEAL UNIT TESTS*/
    static testMethod void test_Insert_OpportunityToDeal() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleOpportunityRecord;
        
        //query both objects
        sampleOpportunityRecord = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleOpportunityRecord.Id), 'Opportunity', 'Id = \'' + sampleOpportunityRecord.Id + '\''));
        Deal__c syncedDeal = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Deal__c.getsObjectType()), 'Deal__c', 'Opportunity__c = \'' + sampleOpportunityRecord.Id + '\''));
        
        //retrieve fields for each object
        Map<String, Schema.sObjectField> opportunityFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(sampleOpportunityRecord.getsObjectType());
        Map<String, Schema.sObjectField> dealFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(syncedDeal.getsObjectType());
        system.assert(opportunityFieldMap.size() > 0);
        system.assert(dealFieldMap.size() > 0);
        
        //asserts
        for(String key : opportunityFieldMap.keySet()){
        	//loop over all fields and assert the deal field value matches the opportunity field value
        	if(SynchronizationEngine.verifyIfFieldIsEditable(key, opportunityFieldMap, dealFieldMap) && !TEMPORARY_FIELDS_TO_SKIP_FOR_OPPORTUNITY.contains(key)){
    			system.assertEquals(sampleOpportunityRecord.get(opportunityFieldMap.get(key)), syncedDeal.get(dealFieldMap.get(key)), key);
        	}
        	else{
    			system.debug('field not present in field mapping: ' + key);
    		}
        }
        
        Test.stopTest();
    }
    
/*DEAL TO OPPORTUNITY UNIT TESTS*/
    static testMethod void test_Insert_DealToOpportunity() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleDealRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
		
        //query both objects
        sampleDealRecord = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleDealRecord.Id), 'Deal__c ', 'Id = \'' + sampleDealRecord.Id + '\''));
        Opportunity syncedOpportunity = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Opportunity.getsObjectType()), 'Opportunity ', 'Id = \'' + sampleDealRecord.Opportunity__c + '\''));
        
        //retrieve fields for each object
        Map<String, Schema.sObjectField> dealFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(sampleDealRecord.getsObjectType());
        Map<String, Schema.sObjectField> opportunityFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(syncedOpportunity.getsObjectType());
        system.assert(dealFieldMap.size() > 0);
        system.assert(opportunityFieldMap.size() > 0);
        
        //asserts
        for(String key : dealFieldMap.keySet()){
        	//loop over all fields and assert the deal field value matches the opportunity field value
        	if(SynchronizationEngine.verifyIfFieldIsEditable(key, dealFieldMap, opportunityFieldMap) && !TEMPORARY_FIELDS_TO_SKIP_FOR_OPPORTUNITY.contains(key)){
    			system.assertEquals(sampleDealRecord.get(dealFieldMap.get(key)), syncedOpportunity.get(opportunityFieldMap.get(key)), key);
        	}
        	else{
    			system.debug('field not present in field mapping: ' + key);
    		}
        }
        
        Test.stopTest();
    }
    
    static testMethod void test_Update_DealToOpportunity() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleDealRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //update a few fields on mirror record
        sampleDealRecord.Opportunity_Name__c = 'Haroldeen';
        sampleDealRecord.Opportunity__c = sampleOpportunityRecord.Id;
        update sampleDealRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //query both objects
        sampleDealRecord = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(sampleDealRecord.Id), 'Deal__c ', 'Id = \'' + sampleDealRecord.Id + '\''));
        Opportunity syncedOpportunity = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Opportunity.getsObjectType()), 'Opportunity', 'Id = \'' + sampleDealRecord.Opportunity__c + '\''));
        
        //retrieve fields for each object
        Map<String, Schema.sObjectField> opportunityFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(syncedOpportunity.getsObjectType());
        Map<String, Schema.sObjectField> dealFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(sampleDealRecord.getsObjectType());
        system.assert(opportunityFieldMap.size() > 0);
        system.assert(dealFieldMap.size() > 0);
        
        //asserts
        for(String key : dealFieldMap.keySet()){
        	//loop over all fields and assert the deal field value matches the opportunity field value
        	if(SynchronizationEngine.verifyIfFieldIsEditable(key, dealFieldMap, opportunityFieldMap) && !TEMPORARY_FIELDS_TO_SKIP_FOR_OPPORTUNITY.contains(key)){
    			system.assertEquals(sampleDealRecord.get(dealFieldMap.get(key)), syncedOpportunity.get(opportunityFieldMap.get(key)), key);
        	}
        	else{
    			system.debug('field not present in field mapping: ' + key);
    		}
        }
        
        Test.stopTest();
    }
    
    static testMethod void test_Delete_DealToOpportunity() {
        //generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleDealRecord;
        Id dealId = sampleDealRecord.Id; //store id before deletion to allow for querying
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //query deal to get the opportunity id related to deal
        Deal__c[] queriedDeal = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(dealId), 'Deal__c', 'Id = \'' + dealId + '\''));
        Id opportunityId = queriedDeal[0].Opportunity__c;
        system.assertEquals(1, queriedDeal.size());
        system.assertNotEquals(null, opportunityId);
        
        //perform deletion of mirror record
        delete sampleDealRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //attempt to query the deleted records
        queriedDeal = new Deal__c[]{};
        queriedDeal = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(dealId), 'Deal__c', 'Id = \'' + dealId + '\''));
        Opportunity[] queriedOpporunity = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(opportunityId), 'Opportunity', 'Id = \'' + opportunityId + '\''));
        
        //asserts
        system.assertEquals(0, queriedDeal.size());
        system.assertEquals(0, queriedOpporunity.size());
        
        Test.stopTest();
    }

/*SYSTEM PART TO OPPORTUNITY LINE ITEM UNIT TESTS
NOTE: This is a one-way sync. So unit tests only setup from system part to opportunity line item object*/
    static testMethod void test_Insert_SystemPartToOpportunityLineItem() {
    	//generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleDealRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //query for deal
        Deal__c queriedDeal = [SELECT Id, Opportunity__c FROM Deal__c WHERE Id =: sampleDealRecord.Id];
        system.assertNotEquals(null, queriedDeal.Opportunity__c);
        
    	//set deal id on system part records before insert of system parts
    	for(System_Part__c p : sampleListOfSystemParts){
    		p.Deal__c = queriedDeal.Id;
    	}
    	insert sampleListOfSystemParts;
    	
    	//verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //create set list of product codes to use to query for the opportunity line items (product code is used to link opp line item to system part)
        Set<String> productCodes = new Set<String>();
        for(System_Part__c sp : sampleListOfSystemParts){
        	productCodes.add(sp.Part_Code__c);
        }
        
        //query opportunity line items
        OpportunityLineItem[] oppLineItems = [SELECT Id, OpportunityId, ProductCode, Quantity FROM OpportunityLineItem WHERE ProductCode IN: productCodes AND OpportunityId =: queriedDeal.Opportunity__c];
        
        //ASSERTS
        system.assertNotEquals(0, oppLineItems.size());
        system.assertEquals(sampleListOfSystemParts.size(), oppLineItems.size());
    	
    	for(OpportunityLineItem o : oppLineItems){
    		//find matching system part and compare quantities
    		for(System_Part__c p : sampleListOfSystemParts){
    			if(o.ProductCode == p.Part_Code__c){
    				system.assertEquals(p.Quantity__c, o.Quantity);
    			}
    		}
    	}
    	
    	Test.stopTest();
    }
    
    static testMethod void test_Update_SystemPartToOpportunityLineItem() {
     	//generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleDealRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //query for deal
        Deal__c queriedDeal = [SELECT Id, Opportunity__c FROM Deal__c WHERE Id =: sampleDealRecord.Id];
        system.assertNotEquals(null, queriedDeal.Opportunity__c);
        
    	//set deal id on system part records before insert of system parts
    	for(System_Part__c p : sampleListOfSystemParts){
    		p.Deal__c = queriedDeal.Id;
    	}
    	insert sampleListOfSystemParts;
    	
    	//verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //update system parts
        for(System_Part__c ps : sampleListOfSystemParts){
        	ps.Quantity__c = 1;
        }
        update sampleListOfSystemParts;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //create set list of product codes to use to query for the opportunity line items (product code is used to link opp line item to system part)
        Set<String> productCodes = new Set<String>();
        for(System_Part__c sp : sampleListOfSystemParts){
        	productCodes.add(sp.Part_Code__c);
        }
        
        //query opportunity line items
        OpportunityLineItem[] oppLineItems = [SELECT Id, OpportunityId, ProductCode, Quantity FROM OpportunityLineItem WHERE ProductCode IN: productCodes AND OpportunityId =: queriedDeal.Opportunity__c];
        
        //ASSERTS
        system.assertNotEquals(0, oppLineItems.size());
        system.assertEquals(sampleListOfSystemParts.size(), oppLineItems.size());
    	
    	for(OpportunityLineItem o : oppLineItems){
    		//find matching system part and compare quantities
    		for(System_Part__c p : sampleListOfSystemParts){
    			if(o.ProductCode == p.Part_Code__c){
    				system.assertEquals(p.Quantity__c, o.Quantity);
    			}
    		}
    	}
    	
    	Test.stopTest();
    }
    
    static testMethod void test_Delete_SystemPartToOpportunityLineItem() {
    	//generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleDealRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //query for deal
        Deal__c queriedDeal = [SELECT Id, Opportunity__c FROM Deal__c WHERE Id =: sampleDealRecord.Id];
        system.assertNotEquals(null, queriedDeal.Opportunity__c);
        
    	//set deal id on system part records before insert of system parts
    	for(System_Part__c p : sampleListOfSystemParts){
    		p.Deal__c = queriedDeal.Id;
    	}
    	insert sampleListOfSystemParts;
    	
    	//verify no error logs were created
        assertNoSyncErrorLogsCreated();
        
        //create set list of product codes to use to query for the opportunity line items (product code is used to link opp line item to system part)
        Set<String> productCodes = new Set<String>();
        for(System_Part__c sp : sampleListOfSystemParts){
        	productCodes.add(sp.Part_Code__c);
        }
        
        //query opportunity line items
        OpportunityLineItem[] oppLineItems = [SELECT Id, OpportunityId, ProductCode, Quantity FROM OpportunityLineItem WHERE ProductCode IN: productCodes AND OpportunityId =: queriedDeal.Opportunity__c];
        
        //ASSERTS
        system.assertNotEquals(0, oppLineItems.size());
        system.assertEquals(sampleListOfSystemParts.size(), oppLineItems.size());
    	
    	//delete system parts
    	delete sampleListOfSystemParts;
    	
    	//verify no error logs were created
        assertNoSyncErrorLogsCreated();
    	
    	system.assertEquals(0, [SELECT Id, OpportunityId, ProductCode, Quantity FROM OpportunityLineItem WHERE ProductCode IN: productCodes AND OpportunityId =: queriedDeal.Opportunity__c].size());
    	
    	Test.stopTest();
    }
    /*
    static testMethod void test_Insert_IssueCommentAndSyncLastCaseCommentOnRelatedIssue() {
    	//generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleIssueCommentRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
		
		//query issue record
		sampleIssueRecord = [SELECT Id, Last_Case_Comment__c FROM Issue__c WHERE Id =: sampleIssueRecord.Id];
		
		//asserts
		system.assertEquals(sampleIssueCommentRecord.Comment__c, sampleIssueRecord.Last_Case_Comment__c);
		
		Test.stopTest();
    }
    */
    static testMethod void test_LeadConversion() {
    	//generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        sampleProspectRecord.Municipality__c = sampleMunicipalityAccountRecord.Id;
        sampleProspectRecord.OverrideProcessBuilder__c = true;
        insert sampleProspectRecord;
        
        //verify no error logs were created
        assertNoSyncErrorLogsCreated();
		
		//create tasks and events for the prospect
		for(Task t : sampleListOfTasks){
			t.WhatId = sampleProspectRecord.Id;
		}
		for(Event e : sampleListOfEvents){
			e.WhatId = sampleProspectRecord.Id;
		}
		insert sampleListOfTasks;
		insert sampleListOfEvents;
		
		//instatiate page
		ApexPages.StandardController sc = new ApexPages.standardController(sampleProspectRecord);
		CustomLeadConversionButtonController ctrler = new CustomLeadConversionButtonController(sc);
		
		//perform lead conversion
		ctrler.performLeadConversion();
		
		//query propsect
		sampleProspectRecord = [SELECT Id, Lead__c FROM Prospect__c WHERE Id =: sampleProspectRecord.Id];
		system.assertNotEquals(null, sampleProspectRecord.Lead__c);
		
		//query lead
		Lead convertedLead = [SELECT Id, ConvertedAccountId, ConvertedContactId, ConvertedOpportunityId, ConvertedDate FROM Lead WHERE Id =: sampleProspectRecord.Lead__c];
		
		//asserts
		system.assertNotEquals(null, convertedLead.ConvertedDate);
		system.assertNotEquals(null, convertedLead.ConvertedAccountId);
		system.assertNotEquals(null, convertedLead.ConvertedContactId);
		system.assertNotEquals(null, convertedLead.ConvertedOpportunityId);
		
		//query deal related to opportunity that was generated during conversion process
		Deal__c deal = [SELECT Id, (SELECT Id FROM Tasks), (SELECT Id FROM Events) FROM Deal__c WHERE Opportunity__c =: convertedLead.ConvertedOpportunityId];
		
		//assert activities were transferred from prospect to deal correctly
		system.assertEquals(sampleListOfTasks.size(), deal.Tasks.size());
		system.assertEquals(sampleListOfEvents.size(), deal.Events.size());
		
		Test.stopTest();
    }


/*Batch sync test*/
    static testMethod void test_BatchSyncLeadToProspect() {
    	
    	/*
    	//generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        sampleLeadRecord.OverrideProcessBuilder__c = true;
        insert sampleListOfLeads;
        
        //call batch
        database.executeBatch(new Batch_SyncLeadToProspect());
        
        //get list of lead ids
        Set<Id> leadIds = new Set<Id>();
        for(Lead l : sampleListOfLeads){
        	leadIds.add(l.Id);
        }
        
        //query records
        sampleListOfLeads = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Lead.getSobjectType()), 'Lead ', 'Id IN: leadIds'));
        Prospect__c[] syncedProspects = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Prospect__c.getsObjectType()), 'Prospect__c', 'Lead__c IN: leadIds'));
        system.assertEquals(sampleListOfLeads.size(), syncedProspects.size());
        
        Map<Id, Prospect__c> leadIdToProspect = new Map<Id, Prospect__c>();
        for(Prospect__c p : syncedProspects){
        	leadIdToProspect.put(p.Lead__c, p);
        }
        
        //retrieve fields for each object
        Map<String, Schema.sObjectField> leadFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(Lead.getsObjectType());
        Map<String, Schema.sObjectField> prospectFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(Prospect__c.getsObjectType());
        system.assert(leadFieldMap.size() > 0);
        system.assert(prospectFieldMap.size() > 0);
        
        //asserts
        for(Lead l : sampleListOfLeads){ //loop over records
        	for(String key : leadFieldMap.keySet()){ //loop over fields
	        	//loop over all fields and assert the deal field value matches the opportunity field value
	        	if(SynchronizationEngine.verifyIfFieldIsEditable(key, leadFieldMap, prospectFieldMap)){
	    			system.assertEquals(l.get(leadFieldMap.get(key)), leadIdToProspect.get(l.Id).get(prospectFieldMap.get(key)), key);
	        	}
	        	else{
	    			system.debug('field not present in field mapping: ' + key);
	    		}
	        }
        }
        
        Test.stopTest();
        */
    }
    
    static testMethod void test_BatchSyncOpportunityToDeal() {
    	
    	/*
    	//generate sample data
        generateSampleData();
        
        Test.startTest();
        
        //insert the sample data
        insert sampleListOfOpportunities;
        
        //call batch
        database.executeBatch(new Batch_SyncOpportunityToDeal());
        
        //get list of opportunity ids
        Set<Id> opportunityIds = new Set<Id>();
        for(Opportunity l : sampleListOfOpportunities){
        	opportunityIds.add(l.Id);
        }
        
        //query records
        sampleListOfOpportunities = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Opportunity.getSobjectType()), 'Opportunity', 'Id IN: opportunityIds'));
        Deal__c[] syncedDeals = database.query(buildQueryString(SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Deal__c.getsObjectType()), 'Deal__c', 'Opportunity__c IN: opportunityIds'));
        system.assertEquals(sampleListOfOpportunities.size(), syncedDeals.size());
        
        Map<Id, Deal__c> opportunityIdToDeal = new Map<Id, Deal__c>();
        for(Deal__c p : syncedDeals){
        	opportunityIdToDeal.put(p.Opportunity__c, p);
        }
        
        //retrieve fields for each object
        Map<String, Schema.sObjectField> opportunityFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(Opportunity.getsObjectType());
        Map<String, Schema.sObjectField> dealFieldMap = SynchronizationEngine.retrieveSchemaFieldMapAndRemoveUnderscoreCFromMapsKeySet(Deal__c.getsObjectType());
        system.assert(opportunityFieldMap.size() > 0);
        system.assert(dealFieldMap.size() > 0);
        
        //asserts
        for(Opportunity l : sampleListOfOpportunities){ //loop over records
        	for(String key : opportunityFieldMap.keySet()){ //loop over fields
	        	//loop over all fields and assert the deal field value matches the opportunity field value
	        	if(SynchronizationEngine.verifyIfFieldIsEditable(key, opportunityFieldMap, dealFieldMap)){
	    			system.assertEquals(l.get(opportunityFieldMap.get(key)), opportunityIdToDeal.get(l.Id).get(dealFieldMap.get(key)), key);
	        	}
	        	else{
	    			system.debug('field not present in field mapping: ' + key);
	    		}
	        }
        }
        
        Test.stopTest();
        */
    }
    
/*HELPER METHODS*/
    private static void generateSampleData(){
    	Id opportunityCustAppRecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName = 'CustApp' AND SobjectType = 'Opportunity'].Id;
    	Map<String, String> productNameToProductCode = new Map<String, String>{
    																			'1.1kw Solar System' => 'pr-100', 
    																		   	'2.1kw Solar System' => 'pr-101',
    																		   	'3.1kw Solar System' => 'pr-102',
    																		   	'4.1kw Solar System' => 'pr-103',
    																		   	'5.1kw Solar System' => 'pr-104',
    																		   	'6.1kw Solar System' => 'pr-105'};
    	
	/*THE DEFAULT DATA NECESSARY TO CREATE THE SAMPLE DATA USED FOR TESTING*/
		//PROFILE
		Id adminProfileId = [SELECT Id FROM Profile WHERE name = 'System Administrator'].Id;
		
		//USER
		sampleAdminUser = new User(Alias = 'admin', Email='adming123@testorg.com', 
						            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
						            LocaleSidKey='en_US', ProfileId = adminProfileId, 
						            TimeZoneSidKey='America/Los_Angeles', UserName='adming123@testorg.com');
		insert sampleAdminUser;
		
    	//PRODUCTS
    	Product2[] products = new Product2[]{};
    	for(String key : productNameToProductCode.keySet()){
    		products.add(new Product2(IsActive = true, Name = key, ProductCode = productNameToProductCode.get(key)));
    	}
    	insert products;
    	
    	//PRICEBOOK2
    	Id pricebookId = Test.getStandardPricebookId();
    	
    	//PRICEBOOK ENTRIES
    	PricebookEntry[] pricebookEntries = new PricebookEntry[]{};
    	for(Product2 p : products){
    		pricebookEntries.add(new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = p.Id, UnitPrice = 10000, IsActive = true));
    	}
    	insert pricebookEntries;
    	
    	//PARTS
    	Part__c[] parts = new Part__c[]{};
    	Integer qty = 1;
    	for(String key : productNameToProductCode.keySet()){
    		parts.add(new Part__c(Active__c = true, Name = key, part_code__c = productNameToProductCode.get(key), Default_Quantity__c = qty));
    		qty++;
    	}
    	insert parts;
    	
    	//ACCOUNTS
    	sampleAccountRecord = new Account(LastName = 'Account Name');
    	insert sampleAccountRecord;
    	Id municipalityRecTypeId = [SELECT Id FROM RecordType WHERE DeveloperName =: 'Municipality' AND sObjectType =: 'Account'].Id;
    	sampleMunicipalityAccountRecord = new Account(Name = 'Municipality account', RecordTypeId = municipalityRecTypeId);
    	insert sampleMunicipalityAccountRecord;
    	
    	//PROJECT
    	//insert opportunity to relate to he project
    	Opportunity projectOpportunity = new Opportunity(Name = 'opp name', StageName = 'Schedule Appointment', CloseDate = date.today(), AccountId = sampleAccountRecord.Id);
    	insert projectOpportunity;
    	Project__c project = new Project__c(Name = 'Project Name', Opportunity__c = projectOpportunity.Id, PVI_Placed_In_Service_Date__c = date.today(), PVI_Rails_and_Panels_Left_Warehouse_Date__c = date.today(), PVI_Electrical_Installed_Date__c = date.today(), PVI_Electrical_Left_Warehouse_Date__c = date.today(), PV_Net_Meter_Install_Verified_Date__c = date.today(), Final_3rd_Party_Inspection_Compete_Date__c = date.today(), PVI_Rails_Installed_Date__c = date.today(), PVI_Panels_Installed_Date__c = date.today(), Gross_System_Cost_in_Dollars__c = 22, Billing_Packet_Approved_Date__c = date.today(), PVI_Activation_Date__c = date.today());
    	insert project;
    	
    	//ISSUE
    	sampleIssueRecord = new Issue__c(AccountId__c = sampleAccountRecord.Id, PG_Product__c = project.Id, Origin__c = 'Internal', Case_Subject__c = 'Administrative', Case_Description__c = 'Other', Initial_Case_Comment__c = 'inital comment here');
    	insert sampleIssueRecord;
    	
    	//CUSTOM SETTINGS
    	Trigger_Setting__c ts = new Trigger_Setting__c();
    	ts.Sync_Deal_Trigger__c = true;
    	ts.Sync_Lead_Trigger__c = true;
    	ts.Sync_Opportunity_Trigger__c = true;
    	ts.Sync_Prospect_Trigger__c = true;
    	ts.Sync_System_Part_Trigger__c = true;
    	ts.Sync_Issue_Comment_Trigger__c = true;
    	insert ts;
    	
    /*THE SAMPLE TESTING DATA (Data inserted from within unit tests)*/
    	//LEAD
    	Lead deserializedLead = (Lead) JSON.deserialize(sampleLeadJSON, Lead.class);
    	sampleLeadRecord = deserializedLead.clone(false, false, false, true);
    	//LEADS
    	for(Integer i = 0; i < 10; i++){
    		Lead l = deserializedLead.clone(false, false, false, true);
    		l.LastName = 'Leadtest' + i;
    		
    		sampleListOfLeads.add(l);
    	}
    	
    	//PROSPECT
    	Prospect__c deserializedProspect = (Prospect__c) JSON.deserialize(sampleProspectJSON, Prospect__c.class);
    	sampleProspectRecord = deserializedProspect.clone(false, false, false, true);
    	
    	//OPPORTUNITY
    	Opportunity deserializedOpportunity = (Opportunity) JSON.deserialize(sampleOpportunityJSON, Opportunity.class);
    	sampleOpportunityRecord = deserializedOpportunity.clone(false, false, false, true);
    	sampleOpportunityRecord.RecordTypeId = opportunityCustAppRecTypeId;
    	sampleOpportunityRecord.AccountId = sampleAccountRecord.Id;
    	//OPPORTUNITIES
    	for(Integer i = 0; i < 10; i++){
    		Opportunity o = deserializedOpportunity.clone(false, false, false, true);
    		o.RecordTypeId = opportunityCustAppRecTypeId;
    		o.AccountId = sampleAccountRecord.Id;
    		o.Name = 'Opptest' + i;
    		
    		sampleListOfOpportunities.add(o);
    	}
    	
    	//DEAL
    	Deal__c deserializedDeal = (Deal__c) JSON.deserialize(sampleDealJSON, Deal__c.class);
    	sampleDealRecord = deserializedDeal.clone(false, false, false, true);
    	sampleDealRecord.AccountId__c = sampleAccountRecord.Id;
    	
    	//SYSTEM PARTS (IMPORTANT: The System Part records master-detail Deal field will need to be set within the unit test method after Deal has been inserted)
    	sampleListOfSystemParts = new System_Part__c[]{};
    	integer quantityIncrementer = 1;
    	for(Part__c pa : parts){
    		sampleListOfSystemParts.add(new System_Part__c(Part__c = pa.Id, Part_Code__c = pa.part_code__c, Quantity__c = quantityIncrementer));
    		quantityIncrementer++;
    	}
    	
    	//ISSUE COMMENTS
    	sampleIssueCommentRecord = new Issue_Comment__c(Comment__c = 'this is an issue comment. Fantastic!', Issue__c = sampleIssueRecord.Id);
    	
    	//TASKS - NOT ASSOCIATED TO A PARENT RECORD YET
    	for(integer i = 1; i < 4; i++){
    		sampleListOfTasks.add(new Task(Subject = 'Call', OwnerId = sampleAdminUser.Id));
    	}
    	
    	//EVENTS - NOT ASSOCIATED TO A PARENT RECORD YET
    	for(integer i = 1; i < 4; i++){
    		sampleListOfEvents.add(new Event(Subject = 'Appointment', Type = 'Other', StartDateTime = datetime.now(), EndDateTime = datetime.now(), OwnerId = sampleAdminUser.Id));
    	}
    }
    
    private static String buildQueryString(String fieldsToQuery, String objectAPIName, String whereClause){
    	return 'SELECT ' + fieldsToQuery + ' FROM ' + objectAPIName + ' WHERE ' + whereClause;
    }
    
    private static void assertNoSyncErrorLogsCreated(){
    	Sync_Error_Log__c[] logs = [SELECT Id, Error_Message__c, Failed_Record_Id__c, Stack_Trace__c FROM Sync_Error_Log__c];
    	
		system.assertEquals(0, logs.size(), logs);
    }
    
    static testMethod void test_temporaryByPassTest() {
    	SynchronizationEngine.temporaryByPassTest();
    }
    
}