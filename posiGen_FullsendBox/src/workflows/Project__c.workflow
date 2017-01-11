<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Billing_packet_resubmitted_Alert</fullName>
        <description>Billing packet resubmitted Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>jjasper@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mtruong@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pvidal@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Billing_Packet_Resubmission_Alert</template>
    </alerts>
    <alerts>
        <fullName>Billing_packet_submitted_Alert</fullName>
        <description>Billing packet submitted Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>jjasper@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mtruong@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pvidal@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Billing_Packet_Alert</template>
    </alerts>
    <alerts>
        <fullName>EE_Assessment_Rejection_Notice</fullName>
        <description>EE Assessment Rejection Notice</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/EE_Rejection_Notice</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_For_New_Posigen_Internal_Assessment</fullName>
        <description>Email Alert For New Posigen Internal Assessment</description>
        <protected>false</protected>
        <recipients>
            <recipient>xcabo@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Project_Assigned_to_Posigen_Internal</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_on_System_Install_at_100</fullName>
        <description>Email Alert on System Install at 100%</description>
        <protected>false</protected>
        <recipients>
            <recipient>adrianz@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PV_Install_100</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_to_Sunlight_For_New_Assessment</fullName>
        <description>Email Alert to Sunlight For New Assessment</description>
        <protected>false</protected>
        <recipients>
            <recipient>zak@sunlightsolar.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <recipients>
            <recipient>SunlightSolarEnergyIncPartnerManager</recipient>
            <type>portalRole</type>
        </recipients>
        <recipients>
            <recipient>SunlightSolarEnergyIncPartnerUser</recipient>
            <type>portalRole</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Notications_to_Partners/PV_Assessment_Requested</template>
    </alerts>
    <alerts>
        <fullName>Email_to_BLG_PosiGen_Internal_for_PV_Projects</fullName>
        <description>Email to BLG/PosiGen Internal for PV Projects</description>
        <protected>false</protected>
        <recipients>
            <recipient>btrainor@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cpitre@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Notications_to_Partners/PV_Assessment_Requested</template>
    </alerts>
    <alerts>
        <fullName>FIeld_Verification_Completed_Alert</fullName>
        <description>FIeld Verification Completed Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>kdhevelyn@gmail.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <recipients>
            <recipient>amarrero@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Field_Verification_Completed</template>
    </alerts>
    <alerts>
        <fullName>FIeld_Verification_Completed_Alert_NYCT</fullName>
        <description>FIeld Verification Completed Alert (NYCT)</description>
        <protected>false</protected>
        <recipients>
            <recipient>cmcshane@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>marndt@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrivera@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tdugas@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Field_Verification_Completed</template>
    </alerts>
    <alerts>
        <fullName>FIeld_Verification_Needed_ALert</fullName>
        <description>Field Verification Needed Alert (LA)</description>
        <protected>false</protected>
        <recipients>
            <recipient>aauthement@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>amarrero@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bbrenner@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Field_Verification_Needed</template>
    </alerts>
    <alerts>
        <fullName>FIeld_Verification_Needed_ALert_NY</fullName>
        <description>Field Verification Needed Alert (NYCT)</description>
        <protected>false</protected>
        <recipients>
            <recipient>cmcshane@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>marndt@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mneyhart@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Field_Verification_Needed</template>
    </alerts>
    <alerts>
        <fullName>Install_Return_Alert</fullName>
        <ccEmails>customercare@posigen.com</ccEmails>
        <description>Install Return Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>CT_Project_Management</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>NY_Project_Management</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PM_Lead_Ops_Manager_CT</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PM_Lead_Ops_Manager_LA</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PM_Lead_Ops_Manager_NY</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>Project_Management</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>advorak@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cgordon@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cmerritt@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbaldassaro@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jsmith@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kmitchell@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mneyhart@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mtruong@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>pvidal@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rhisel@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Install_Return_Alert</template>
    </alerts>
    <alerts>
        <fullName>Notification_When_PV_removal_is_requested</fullName>
        <description>Notification when PV removal is requested</description>
        <protected>false</protected>
        <recipients>
            <recipient>aauthement@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gwoodall@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mtruong@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Removal_Request</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_Lockout_is_completed</fullName>
        <description>Notification when Lockout is completed</description>
        <protected>false</protected>
        <recipients>
            <recipient>amashke@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PV_Removal_Lockout_Completed</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_Lockout_is_requested</fullName>
        <description>Notification when Lockout is requested</description>
        <protected>false</protected>
        <recipients>
            <recipient>adrianz@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Removal_Request</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_PVI_Electrical_Is_Installed</fullName>
        <description>Notification when PVI Electrical Is Installed</description>
        <protected>false</protected>
        <recipients>
            <recipient>advorak@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmann@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>psummers@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rlandry@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PVI_Electrical_Install_Completed</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_PV_removal_is_completed</fullName>
        <description>Notification when PV removal is completed</description>
        <protected>false</protected>
        <recipients>
            <recipient>bhirsch@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cemerson@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hgordon@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbaldassaro@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rhisel@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PV_Removal_Lockout_Completed</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_refurbished_system_has_been_reviewed</fullName>
        <description>Notification when refurbished system has been reviewed</description>
        <protected>false</protected>
        <recipients>
            <recipient>bhirsch@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cemerson@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cfitzgerald@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jbaldassaro@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmann@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rhisel@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Refurbished_System_Has_Been_Reviewed</template>
    </alerts>
    <alerts>
        <fullName>Notification_when_system_has_been_refurbished</fullName>
        <description>Notification when system has been refurbished</description>
        <protected>false</protected>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/System_Has_Been_Refurbished</template>
    </alerts>
    <alerts>
        <fullName>Notify_BKE_of_rejected_billing_packet</fullName>
        <description>Notify BKE of rejected billing packet</description>
        <protected>false</protected>
        <recipients>
            <recipient>mark@bke.la</recipient>
            <type>partnerUser</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Billing_Packet_Rejection_Notice</template>
    </alerts>
    <alerts>
        <fullName>Notify_CC_When_Final_Demand_Letter_is_Sent</fullName>
        <ccEmails>customercare@posigen.com</ccEmails>
        <description>Notify CC When Final Demand Letter is Sent</description>
        <protected>false</protected>
        <recipients>
            <recipient>bhirsch@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>xcabo@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Final_Demand_Letter_Sent</template>
    </alerts>
    <alerts>
        <fullName>Notify_James_Pujol_and_Sue</fullName>
        <description>Notify James Pujol and Sue Clawson</description>
        <protected>false</protected>
        <recipients>
            <recipient>bhirsch@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sclawson@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Mutual_Release_Hold_Harmless_Agreement_Approved</template>
    </alerts>
    <alerts>
        <fullName>Notify_KDH_of_rejected_billing_packet</fullName>
        <description>Notify KDH of rejected billing packet</description>
        <protected>false</protected>
        <recipients>
            <recipient>kdhevelyn@gmail.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Billing_Packet_Rejection_Notice</template>
    </alerts>
    <alerts>
        <fullName>Notify_NY_SC_after_assessment_goes_to_DC</fullName>
        <ccEmails>rreynolds@apexsolarpower.com</ccEmails>
        <description>Notify NY SC after assessment goes to DC</description>
        <protected>false</protected>
        <recipients>
            <recipient>fleo@apexsolarpower.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PV_Assessment_Goes_To_Doc_Review</template>
    </alerts>
    <alerts>
        <fullName>Notify_SC_a_Project_Has_Been_Created_for_Them</fullName>
        <description>Notify SC a Project Has Been Created for Them</description>
        <protected>false</protected>
        <recipients>
            <field>SC_Email_to_Notify_Project_Created_Text__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Notications_to_Partners/PV_Assessment_Requested</template>
    </alerts>
    <alerts>
        <fullName>Notify_SC_an_EE_Project_has_been_created_for_them</fullName>
        <description>Notify SC an EE Project has been created for them</description>
        <protected>false</protected>
        <recipients>
            <field>SC_Email_to_Notify_Project_Created_Text__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Notications_to_Partners/EE_Project_Created_for_Subcontractors</template>
    </alerts>
    <alerts>
        <fullName>Notify_Sales_and_DC_About_Smaller_System_Feasibility</fullName>
        <ccEmails>doccontrol@posigen.com</ccEmails>
        <description>Notify Sales and DC About Smaller System Feasibility (LA)</description>
        <protected>false</protected>
        <recipients>
            <recipient>amarrero@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>gblanchard@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmann@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rhisel@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_PV_Assessment_With_Smaller_System</template>
    </alerts>
    <alerts>
        <fullName>Notify_Sales_and_DC_About_Smaller_System_Feasibility_CT_NY</fullName>
        <ccEmails>doccontrol@posigen.com</ccEmails>
        <description>Notify Sales and DC About Smaller System Feasibility (CT/NY)</description>
        <protected>false</protected>
        <recipients>
            <recipient>dlockwood@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mneyhart@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_PV_Assessment_With_Smaller_System</template>
    </alerts>
    <alerts>
        <fullName>Notify_Veteran_of_rejected_billing_packet</fullName>
        <description>Notify Veteran of rejected billing packet</description>
        <protected>false</protected>
        <recipients>
            <recipient>bryan.lichtenstein@veterancontractors.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Billing_Packet_Rejection_Notice</template>
    </alerts>
    <alerts>
        <fullName>Removal_Lockout_Project_Cancellation_Alert</fullName>
        <description>Removal/Lockout Project Cancellation Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>adrianz@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mcasey@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/PV_Removal_Lockout_Cancelled</template>
    </alerts>
    <fieldUpdates>
        <fullName>Billing_Packet_Rejection_Flag</fullName>
        <field>Billing_Packet_Rejected__c</field>
        <literalValue>1</literalValue>
        <name>Billing Packet Rejection Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Cannot_upgrade</fullName>
        <description>If result is cannot upgrade, change status to complete - cancel</description>
        <field>Status__c</field>
        <literalValue>Complete - Cancel</literalValue>
        <name>Cannot upgrade</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>ChangeResult_To_Can_Upgrade</fullName>
        <field>Result__c</field>
        <literalValue>Can Upgrade</literalValue>
        <name>Change Result To Can Upgrade</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Billing_Packet_Status_To_Submitte</fullName>
        <field>Billing_Packet_Status__c</field>
        <literalValue>Submitted</literalValue>
        <name>Change Billing Packet Status To Submitte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_EEResult_To_Can_Upgrade</fullName>
        <field>Result__c</field>
        <literalValue>Can Upgrade</literalValue>
        <name>Change Result To Can Upgrade</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Result_To_Can_Upgrade</fullName>
        <field>Result__c</field>
        <literalValue>Can Upgrade</literalValue>
        <name>Change Result To Can Upgrade</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_stage_to_resubmit</fullName>
        <description>Changes stage to Resubmit</description>
        <field>Stage__c</field>
        <literalValue>Resubmit</literalValue>
        <name>Change stage to resubmit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Move_stage_back</fullName>
        <description>Moves status back once the EE scheduled date has been deleted</description>
        <field>Stage__c</field>
        <literalValue>Schedule</literalValue>
        <name>Move stage back</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Model_Energy_Data_Entered_Date</fullName>
        <field>Modeled_Energy_Data_Entered_Date__c</field>
        <formula>today()</formula>
        <name>Populate Model Energy Data Entered Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Modeled_Energy_Data_Entered_By</fullName>
        <field>Modeled_Energy_Data_Entered_By__c</field>
        <formula>$User.FirstName  &amp; &quot; &quot; &amp; $User.LastName</formula>
        <name>Populate Modeled Energy Data Entered By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Removal_Requested_Date</fullName>
        <field>Removal_Requested_Date__c</field>
        <formula>today ()</formula>
        <name>Populate Removal Requested Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Billing_Packet_Approv_Date_to_Today</fullName>
        <field>Billing_Packet_Approved_Date__c</field>
        <formula>Now()</formula>
        <name>Set Billing Packet Approv. Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Electrical_Scheduled_Date_To_Today</fullName>
        <field>PVI_Electrical_Scheduled_Date__c</field>
        <formula>today()</formula>
        <name>Set Electrical Scheduled Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Entered_Stage_Date_to_Today</fullName>
        <field>Entered_Current_Stage_Date__c</field>
        <formula>Today()</formula>
        <name>Set Entered Stage Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Field_Verif_Requested_Date_to_Today</fullName>
        <field>Field_Verification_Requested_Date__c</field>
        <formula>Today()</formula>
        <name>Set Field Verif. Requested Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Initial_Rejected_Date_to_Today</fullName>
        <field>EE_Rejected_Date__c</field>
        <formula>Today()</formula>
        <name>Set Initial Rejected Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Initial_Submitted_Date_To_Today</fullName>
        <field>EE_Initial_Submission_Date__c</field>
        <formula>IF( isblank(EE_Initial_Submission_Date__c) ,Today(),  EE_Initial_Submission_Date__c)</formula>
        <name>Set Initial Submitted Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Install_100_Complete_Date_To_Today</fullName>
        <field>Install_100_Complete_Date__c</field>
        <formula>Now()</formula>
        <name>Set Install 100% Complete Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_R_P_Completed_Date_To_Today</fullName>
        <field>PVI_Rails_Installed_Date__c</field>
        <formula>today()</formula>
        <name>Set R&amp;P Completed Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_R_P_Scheduled_Date_To_Today</fullName>
        <field>PVI_Rails_Scheduled_Date__c</field>
        <formula>today()</formula>
        <name>Set R&amp;P Scheduled Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EA_Approved_Date_To_Today</fullName>
        <field>EE_Approved_Date__c</field>
        <formula>Today()</formula>
        <name>Update EA Approved Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EA_Assigned_Date_to_Today</fullName>
        <field>EE_Assigned_Date__c</field>
        <formula>Today()</formula>
        <name>Update EA Assigned Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EE_Project_Stage_to_Complete</fullName>
        <field>Stage__c</field>
        <literalValue>Complete</literalValue>
        <name>Update EE Project Stage to Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EE_Project_Stage_to_Resubmit_EE_A</fullName>
        <description>Update EE Project Stage to Resubmit EE Assessment</description>
        <field>Stage__c</field>
        <literalValue>Resubmit</literalValue>
        <name>Update EE Project Stage to Resubmit EE A</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EE_Project_Stage_to_Submit_Rebate</fullName>
        <description>Update EE Project Stage to Submit Rebate</description>
        <field>Stage__c</field>
        <literalValue>Submit Rebate</literalValue>
        <name>Update EE Project Stage to Submit Rebate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EE_Status_to_Complete</fullName>
        <description>Update EE Status to Complete</description>
        <field>Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Update EE Status to Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EE_stage_to_review</fullName>
        <description>Update EE stage to review upon submission</description>
        <field>Stage__c</field>
        <literalValue>Review</literalValue>
        <name>Update EE stage to review</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stage_to_Perform</fullName>
        <field>Stage__c</field>
        <literalValue>Perform</literalValue>
        <name>Update Stage to Perform</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Stage_to_Submit</fullName>
        <field>Stage__c</field>
        <literalValue>Submit</literalValue>
        <name>Update Stage to Submit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Static_Email_to_Notify_SCs</fullName>
        <description>Update Static Email on Project with the formula one derived from the SC Account.</description>
        <field>SC_Email_to_Notify_Project_Created_Text__c</field>
        <formula>SC_Email_to_Notify_of_new_Project__c</formula>
        <name>Update Static Email to Notify SCs</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Completed</fullName>
        <description>Updates the Status of the PV Assessment Project to Completed.</description>
        <field>Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Update Status to Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Subcontractor_Name_Text_Field</fullName>
        <description>Updates the Subcontractor_Name__c field on the project. This is part of a workaround due to formula fields not being able to be used in sharing rules.</description>
        <field>Subcontractor_Name__c</field>
        <formula>Subcontractor__r.Name</formula>
        <name>Update Subcontractor Name Text Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_date_Verified_Net_Meter</fullName>
        <description>If Net Meter Status = Verified Installed, Move Net Meter Install Verified Date to Today.</description>
        <field>PV_Net_Meter_Install_Verified_Date__c</field>
        <formula>Now()</formula>
        <name>Update date Verified Net Meter</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>A New EE Project has been created</fullName>
        <actions>
            <name>Notify_SC_an_EE_Project_has_been_created_for_them</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>EE Assessment,EE Upgrade</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Subcontractor_Name__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Workflow to notify sub of an ee creation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>A New PV Assessment Project Has Been Assigned to Posigen Internal</fullName>
        <actions>
            <name>Email_Alert_For_New_Posigen_Internal_Assessment</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Project__c.Subcontractor_Name__c</field>
            <operation>contains</operation>
            <value>Posigen</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>PV Feasibility</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>A New PV Assessment Project Has Been Created for Sunlight Solar</fullName>
        <actions>
            <name>Email_Alert_to_Sunlight_For_New_Assessment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>A New PV Assessment Project Has Been Created for Solar Sunlight</description>
        <formula>Subcontractor__r.Name  =  &quot;Sunlight Solar Energy, Inc.&quot;   &amp;&amp;   RecordType.Name  = &quot;PV Feasibility&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>A New PV Project Has Been Created</fullName>
        <actions>
            <name>Notify_SC_a_Project_Has_Been_Created_for_Them</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Static_Email_to_Notify_SCs</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>PV Feasibility,PV Install,SHW Install,SHW Feasibility,PV Removal</value>
        </criteriaItems>
        <description>A New PV Project Has Been Created (Install or Assessment)</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Alert When Electrical Installed For Cash Sales</fullName>
        <actions>
            <name>Notification_when_PVI_Electrical_Is_Installed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Opp_Transaction_Type__c</field>
            <operation>equals</operation>
            <value>Cash</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.PVI_Electrical_Installed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Billing Packet Approved</fullName>
        <actions>
            <name>Set_Billing_Packet_Approv_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Billing_Packet_Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <description>If billing packet status = Approved, change Approved Date to Today</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Billing Packet Rejection Flag</fullName>
        <actions>
            <name>Billing_Packet_Rejection_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Billing_Packet_Status__c</field>
            <operation>equals</operation>
            <value>Missing Docs</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Billing packet resubmitted check</fullName>
        <actions>
            <name>Billing_packet_resubmitted_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Billing_Packet_Resubmitted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Email alert for the accounting dep regarding the billing packet resubmitted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Billing packet submitted check</fullName>
        <actions>
            <name>Billing_packet_submitted_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Billing_packet_submitted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>For the email alert for the accounting dep regarding the billing packet</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Cannot upgrade</fullName>
        <actions>
            <name>Cannot_upgrade</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Result__c</field>
            <operation>equals</operation>
            <value>Cannot Upgrade</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.EE_Approved_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>If result is cannot upgrade and the project is approved, move to complete-cancel</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Billing Packet Status To Submitted</fullName>
        <actions>
            <name>Change_Billing_Packet_Status_To_Submitte</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Billing_packet_submitted__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When installer checks the box &quot;Billing Packet Submitted&quot; the billing packet status will change to Submitted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>EE Completed Date Populated</fullName>
        <actions>
            <name>Update_Stage_to_Submit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.EE_Completed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Update stage to submit</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>EE Schedule Date Populated</fullName>
        <actions>
            <name>Update_Stage_to_Perform</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.EE_Scheduled_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.EE_Completed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Update stage to Perform</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Field Verification Completed Alert %28CTNY%29</fullName>
        <actions>
            <name>FIeld_Verification_Completed_Alert_NYCT</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Field_Verification_Completed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.State__c</field>
            <operation>equals</operation>
            <value>CT,NY</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Field Verification Completed Alert %28LA%29</fullName>
        <actions>
            <name>FIeld_Verification_Completed_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Field_Verification_Completed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.State__c</field>
            <operation>equals</operation>
            <value>LA</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Field Verification Needed Alert %28LA%29</fullName>
        <actions>
            <name>FIeld_Verification_Needed_ALert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2</booleanFilter>
        <criteriaItems>
            <field>Project__c.Field_Verification_Needed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.State__c</field>
            <operation>equals</operation>
            <value>LA</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Field_Verification_Required__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Field Verification Needed Alert %28NYCT%29</fullName>
        <actions>
            <name>FIeld_Verification_Needed_ALert_NY</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2</booleanFilter>
        <criteriaItems>
            <field>Project__c.Field_Verification_Needed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.State__c</field>
            <operation>equals</operation>
            <value>NY,CT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Field_Verification_Required__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Field Verification Requested Date</fullName>
        <actions>
            <name>Set_Field_Verif_Requested_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Project__c.Field_Verification_Needed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Field_Verification_Required__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Final Demand Letter Sent</fullName>
        <actions>
            <name>Notify_CC_When_Final_Demand_Letter_is_Sent</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Final_Demand_Letter_Sent_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lockout Project Completed</fullName>
        <actions>
            <name>Notification_when_Lockout_is_completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Completed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lockout Project Created</fullName>
        <actions>
            <name>Notification_when_Lockout_is_requested</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Ordered_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Make system available for redeployment</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Project__c.System_Refurbished_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Mark Lockout Project As Completed</fullName>
        <actions>
            <name>Update_Status_to_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Completed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Marked Completed On Date Filled</fullName>
        <actions>
            <name>Update_Status_to_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Marked_Completed_On_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Record_Type_Name__c</field>
            <operation>equals</operation>
            <value>PV Feasibility</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Move stage back</fullName>
        <actions>
            <name>Move_stage_back</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.EE_Scheduled_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.OwnerId</field>
            <operation>notContain</operation>
            <value>Karen</value>
        </criteriaItems>
        <description>Moves stage back when EE scheduled date is deleted</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification When Hold Harmless Agreement Approved</fullName>
        <actions>
            <name>Notify_James_Pujol_and_Sue</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Agreement_Approved_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify BKE of billing packet rejection</fullName>
        <actions>
            <name>Notify_BKE_of_rejected_billing_packet</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Billing_Packet_Status__c</field>
            <operation>equals</operation>
            <value>Missing Docs</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Subcontractor_Name__c</field>
            <operation>contains</operation>
            <value>BK</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify KDH of billing packet rejection</fullName>
        <actions>
            <name>Notify_KDH_of_rejected_billing_packet</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Billing_Packet_Status__c</field>
            <operation>equals</operation>
            <value>Missing Docs</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Subcontractor_Name__c</field>
            <operation>equals</operation>
            <value>KDH,K D Homes Builder LLC</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify NY SC after assessment goes to DC</fullName>
        <actions>
            <name>Notify_NY_SC_after_assessment_goes_to_DC</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Result__c</field>
            <operation>equals</operation>
            <value>Feasible- (Doc Review)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Subcontractor_Name__c</field>
            <operation>contains</operation>
            <value>APEX</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Sales and DC About Smaller System Feasibility %28LA%29</fullName>
        <actions>
            <name>Notify_Sales_and_DC_About_Smaller_System_Feasibility</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Result__c</field>
            <operation>equals</operation>
            <value>Feasible (Smaller System)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.State__c</field>
            <operation>equals</operation>
            <value>LA</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Sales and DC About Smaller System Feasibility %28NY%2FCT%29</fullName>
        <actions>
            <name>Notify_Sales_and_DC_About_Smaller_System_Feasibility_CT_NY</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Result__c</field>
            <operation>equals</operation>
            <value>Feasible (Smaller System)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.State__c</field>
            <operation>equals</operation>
            <value>NY,CT</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Veteran of billing packet rejection</fullName>
        <actions>
            <name>Notify_Veteran_of_rejected_billing_packet</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Billing_Packet_Status__c</field>
            <operation>equals</operation>
            <value>Missing Docs</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Subcontractor_Name__c</field>
            <operation>contains</operation>
            <value>Veteran</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PV Install 100</fullName>
        <actions>
            <name>Email_Alert_on_System_Install_at_100</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Set_Install_100_Complete_Date_To_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Check_box_if_system_install_is_100__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>If the box is checked an Email alert will fire</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PV Install Projects with BLG and PosiGen Internal</fullName>
        <actions>
            <name>Email_to_BLG_PosiGen_Internal_for_PV_Projects</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>(Subcontractor__r.Name  = &quot;BLG Solar Solutions&quot;  ||  Subcontractor__r.Name = &quot;PosiGen Internal&quot;)  &amp;&amp;   RecordType.Name  = &quot;PV Install&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PV Install Return Alert</fullName>
        <actions>
            <name>Install_Return_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Install_Return_Reason__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Install_Return_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PV Removal Completed</fullName>
        <actions>
            <name>Notification_when_PV_removal_is_completed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.R_P_Removal_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PV Removal Request</fullName>
        <actions>
            <name>Notification_When_PV_removal_is_requested</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Populate_Removal_Requested_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Agreement_Signed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Modeled Energy Data Entered By</fullName>
        <actions>
            <name>Populate_Model_Energy_Data_Entered_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Modeled_Energy_Data_Entered_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.January_Modeled_Energy__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Removal%2FLockout Project Cancellation Alert</fullName>
        <actions>
            <name>Removal_Lockout_Project_Cancellation_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>PV Removal,Lockout</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Status__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Initial Rejected Date</fullName>
        <actions>
            <name>Set_Initial_Rejected_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Stage__c</field>
            <operation>equals</operation>
            <value>Resubmit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.EE_Rejected_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Set Initial Rejected Date to today</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Initial Submitted Date</fullName>
        <actions>
            <name>Set_Initial_Submitted_Date_To_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 3) AND 2</booleanFilter>
        <criteriaItems>
            <field>Project__c.Stage__c</field>
            <operation>equals</operation>
            <value>Review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.EE_Initial_Submission_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Stage__c</field>
            <operation>equals</operation>
            <value>Review</value>
        </criteriaItems>
        <description>Set Initial Submitted Date to today</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Stage Changed</fullName>
        <actions>
            <name>Set_Entered_Stage_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Start the stage timer date to see how long the project has been in each stage</description>
        <formula>PRIORVALUE(Stage__c)  &lt;&gt; TEXT(Stage__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Stage Set to Scheduled EE</fullName>
        <actions>
            <name>Update_EA_Assigned_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Stage__c</field>
            <operation>equals</operation>
            <value>Schedule</value>
        </criteriaItems>
        <description>Update EA assigned date to today</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>System Ready For Review Alert</fullName>
        <actions>
            <name>Notification_when_system_has_been_refurbished</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.System_Refurbished_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>System Refurbished Review Alert</fullName>
        <actions>
            <name>Notification_when_refurbished_system_has_been_reviewed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Refurbished_System_Review_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.System_Refurbished_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Net Meter Install Verified Date</fullName>
        <actions>
            <name>Update_date_Verified_Net_Meter</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Net_Meter_Status__c</field>
            <operation>equals</operation>
            <value>Verified Installed</value>
        </criteriaItems>
        <description>Will automated the date on the pick list value Net Meter Install Verified Date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Subcontractor Name Field on Subcontractor Assignment</fullName>
        <actions>
            <name>Update_Subcontractor_Name_Text_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Subcontractor_Name__c  &lt;&gt;  Subcontractor__r.Name</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
