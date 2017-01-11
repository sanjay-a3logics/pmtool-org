<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_Metaire_Admin_of_Packet_Rejection</fullName>
        <description>Alert Metaire Admin of Packet Rejection</description>
        <protected>false</protected>
        <recipients>
            <recipient>mmann@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Packet_Rejected_by_DC</template>
    </alerts>
    <alerts>
        <fullName>Alert_Sales_Rep_of_Packet_Rejection</fullName>
        <description>Alert Sales Rep of Packet Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Packet_Rejected_by_DC</template>
    </alerts>
    <alerts>
        <fullName>Congratulations_Your_packet_has_been_approved_Job_well_done</fullName>
        <description>Congratulations! Your packet has been approved. Job well done.</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Sales_Email_Templates/Congratulations_Your_packet_has_been_approved_Job_well_done</template>
    </alerts>
    <alerts>
        <fullName>Customer_Placed_on_Hold</fullName>
        <description>Customer Placed on Hold</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kdhalyx1@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kdhevelyn1@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mbond@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mgonick@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Customer_On_Hold</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_Contract_Revision_Expiration</fullName>
        <description>Email Alert - Contract Revision Expiration</description>
        <protected>false</protected>
        <recipients>
            <recipient>cburnham@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jschouest@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mrivera@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>SF2_Sales_Email_Templates/Contract_Revision_Stage_Expired</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_Contract_Revision_Expired</fullName>
        <description>Email Alert - Contract Revision Expired</description>
        <protected>false</protected>
        <recipients>
            <recipient>cburnham@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jschouest@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>SF2_Sales_Email_Templates/Contract_Revision_Stage_Expired</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_Notify_Sales_Admin_and</fullName>
        <description>Email Alert - Notify Sales Admin and</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>mmann@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Sales_Email_Templates/Contract_Revision</template>
    </alerts>
    <alerts>
        <fullName>Email_Alert_TM_Changed_on_Opportunity</fullName>
        <description>Email Alert TM Changed on Opportunity</description>
        <protected>false</protected>
        <recipients>
            <recipient>kgreen@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Sales_Email_Templates/TM_Changed_on_Opp</template>
    </alerts>
    <alerts>
        <fullName>Install_Customer_Cancellation</fullName>
        <description>Customer Cancellation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>amarrero@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>ben@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dshowalter@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kbovia@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mbond@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rpogue@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Customer_Cancellation</template>
    </alerts>
    <alerts>
        <fullName>Notify_CL_when_revised_contract_is_approved</fullName>
        <description>Notify CL when revised contract is approved</description>
        <protected>false</protected>
        <recipients>
            <field>Project_Manager__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Revised_Contract_Approved</template>
    </alerts>
    <alerts>
        <fullName>Notify_EE_CT</fullName>
        <description>Notify EE CT About Rebate Submission</description>
        <protected>false</protected>
        <recipients>
            <recipient>alindsay@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/EE_Rebate_Program_Notification</template>
    </alerts>
    <alerts>
        <fullName>Opportunity_ready_to_cash</fullName>
        <description>Opportunity ready to cash</description>
        <protected>false</protected>
        <recipients>
            <recipient>cemerson@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rbaldassaro@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>SF2_Sales_Email_Templates/Opp_ready_to_cash</template>
    </alerts>
    <alerts>
        <fullName>Opps_with_Ownership_Issues</fullName>
        <description>Opps with Ownership Issues</description>
        <protected>false</protected>
        <recipients>
            <recipient>Sales_Admin</recipient>
            <type>role</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>SF2_Sales_Email_Templates/Ownership_Issue</template>
    </alerts>
    <alerts>
        <fullName>Packet_Approval_Notification</fullName>
        <description>Packet Approval Notification</description>
        <protected>false</protected>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Installation_Complete</template>
    </alerts>
    <alerts>
        <fullName>SHW_Assessment_Request</fullName>
        <ccEmails>melissa@carimisolar.com</ccEmails>
        <description>SHW Assessment Request</description>
        <protected>false</protected>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>joel@carimisolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mbond@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mgonick@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rpogue@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/SHW_Assessment_Request</template>
    </alerts>
    <alerts>
        <fullName>Veterans_Customer_Placed_on_Hold</fullName>
        <description>Veterans Customer Placed on Hold</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mbond@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>testuser7@susco.net</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>testuser8@susco.net</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Customer_On_Hold</template>
    </alerts>
    <alerts>
        <fullName>Yesterdays_Assessments</fullName>
        <description>Install_Yesterdays Assessments</description>
        <protected>false</protected>
        <recipients>
            <recipient>harry.blake@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sfdcsupport@susco.net</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORTSelfServiceNewUserLoginInformationSAMPLE</template>
    </alerts>
    <fieldUpdates>
        <fullName>Automate_Install_complete_Feasible_Stage</fullName>
        <field>Feasible_Stage__c</field>
        <literalValue>Install Completed</literalValue>
        <name>Automate Install complete Feasible Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contract_Approved_By</fullName>
        <field>Contract_Approved_By__c</field>
        <formula>$User.FirstName &amp; &quot; &quot; &amp;  $User.LastName</formula>
        <name>Contract Approved By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Feasible_Stage_Packet_Approved_Update</fullName>
        <field>Feasible_Stage__c</field>
        <literalValue>Packet Approved</literalValue>
        <name>Feasible Stage Packet Approved Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Install_Complete_Date_Automation</fullName>
        <description>Feasible Stage Install Complete will auto populate once the date complete has been selected</description>
        <field>Feasible_Stage__c</field>
        <literalValue>Install Completed</literalValue>
        <name>Install Complete Date Automation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Install_Complete_date_update</fullName>
        <field>Feasible_Stage__c</field>
        <literalValue>Install Completed</literalValue>
        <name>Install Complete date update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Install_Release_date_update</fullName>
        <field>Feasible_Stage__c</field>
        <literalValue>Install Released</literalValue>
        <name>Install Release date update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Install_Released_update</fullName>
        <description>Install Release will automatically update the once the Feasible Stage is changed to Install Released</description>
        <field>Install_Released__c</field>
        <formula>Today()</formula>
        <name>Install Released update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Install_Status_Update</fullName>
        <description>Field update to change the Install Status field to Completed once Install Complete field is populated</description>
        <field>Install_Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Install Status Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>NextValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Client_Signed_Date</fullName>
        <field>Last_Client_Signed_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Client Signed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Closed_Lost_Date</fullName>
        <field>Last_Closed_Lost_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Closed/Lost Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Closed_Won_Date</fullName>
        <field>Last_Closed_Won_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Closed Won Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Contract_Revision_Date</fullName>
        <field>Last_Contract_Revision_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Contract Revision Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Contracts_Approved_Date</fullName>
        <field>Last_Contracts_Approved_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Contracts Approved Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Contracts_Rejected_by_DC_Date</fullName>
        <field>Last_Contracts_Rejected_by_DC_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Contracts Rejected by DC Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Contracts_Rejected_by_UW_Date</fullName>
        <field>Last_Contracts_Rejected_by_UW_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Contracts Rejected by UW Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Contracts_Submitted_to_DC_Date</fullName>
        <field>Last_Contracts_Submitted_to_DC_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Contracts Submitted to DC Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Contracts_Submitted_to_UW_Date</fullName>
        <field>Last_Contracts_Submitted_to_UW_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Contracts Submitted to UW Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Feasibility_Analysis_Date</fullName>
        <field>Last_Feasibility_Analysis_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Feasibility Analysis Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Input_Documents_Date</fullName>
        <field>Last_Input_Documents_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Input Documents Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Layout_Approval_Date</fullName>
        <field>Last_Layout_Approval_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Layout Approval Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Release_to_Installer_Date</fullName>
        <field>Last_Release_to_Installer_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Release to Installer Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Reschedule_Appointment_Date</fullName>
        <field>Last_Reschedule_Appointment_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Reschedule Appointment Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Sales_Appt_Update</fullName>
        <field>Last_Sales_Appt_Update__c</field>
        <formula>NOW()</formula>
        <name>Last Sales Appt Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Schedule_Appointment_Date</fullName>
        <field>Last_Schedule_Appointment_Date__c</field>
        <formula>NOW()</formula>
        <name>Last Schedule Appointment Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mark_Closed_Lost</fullName>
        <field>Closed_Lost__c</field>
        <literalValue>1</literalValue>
        <name>Mark Closed/Lost</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Packed_Approved_Date</fullName>
        <field>Contracts_Approved_Date__c</field>
        <formula>Today()</formula>
        <name>Packed Approved Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Packet_Review_Status_Approved</fullName>
        <field>Packet_Review_Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Packet Review Status Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Packet_Review_Status_In_Process</fullName>
        <field>Packet_Review_Status__c</field>
        <literalValue>In Process</literalValue>
        <name>Packet Review Status In Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Packet_Review_Status_Not_Approved</fullName>
        <field>Packet_Review_Status__c</field>
        <literalValue>Not Approved</literalValue>
        <name>Packet Review Status Not Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Place_in_Service</fullName>
        <description>Update the Placed in Service field to change once the Install Complete is date is entered.</description>
        <field>Install_Completed__c</field>
        <formula>Today()</formula>
        <name>Place in Service</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Contract_Approved_Date_To_Today</fullName>
        <field>Contracts_Approved_Date__c</field>
        <formula>Today()</formula>
        <name>Set Contract Approved Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Contract_Initial_Submission_Date</fullName>
        <field>Contracts_Initially_Submitted_to_DC_Date__c</field>
        <formula>Today()</formula>
        <name>Set Contract Initial Submission Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Contract_RejectedByDC_Date_To_Today</fullName>
        <field>Contracts_Rejected_By_DC_Date__c</field>
        <formula>Today()</formula>
        <name>Set Contract RejectedByDC Date To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Contracts_Signed_Date</fullName>
        <field>Contracts_Signed_Date__c</field>
        <formula>Today()</formula>
        <name>Set Contracts Signed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Date_Released_to_Installer</fullName>
        <description>Sets Opportunity field &quot;Date Released to Installer&quot; to the current date.</description>
        <field>Date_Released_to_Installer__c</field>
        <formula>TODAY()</formula>
        <name>Set Date Released to Installer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Intacct_Customer_ID_value_To_Opp_ID</fullName>
        <field>IntacctID__c</field>
        <formula>Numeric_ID__c</formula>
        <name>Set Intacct Customer ID value To Opp ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Stage_Change_to_Closed_Won</fullName>
        <field>StageName</field>
        <literalValue>Closed Won</literalValue>
        <name>Stage Change to Closed Won</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Copy_of_Pipeline_Stage</fullName>
        <description>Updates Copy of Pipeline Stage with Pipeline Stage</description>
        <field>Copy_of_Pipeline_Stage__c</field>
        <formula>Pipeline_Stage__c</formula>
        <name>Update Copy of Pipeline Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Feasible_Stage_Install_Release</fullName>
        <field>Feasible_Stage__c</field>
        <literalValue>Install Released</literalValue>
        <name>Update Feasible Stage Install Release</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Install_Complete</fullName>
        <field>Feasible_Stage__c</field>
        <literalValue>Install Completed</literalValue>
        <name>Update Install Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Install_Complete_Date</fullName>
        <field>Install_Completed__c</field>
        <formula>Today()</formula>
        <name>Update Install Complete Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Install_Schedule_date</fullName>
        <description>Automatically change the Install Schedule date once the Feasible Stage, Install Schedule is selected</description>
        <field>Install_Scheduled__c</field>
        <formula>Today()</formula>
        <name>Update Install Schedule date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opp_Stage_to_Reschedule_Appt</fullName>
        <field>StageName</field>
        <literalValue>Reschedule Appointment</literalValue>
        <name>Update Opp Stage to Reschedule Appt</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_PV_Installer_Name</fullName>
        <field>PV_Installer_Name__c</field>
        <formula>PV_Installer__r.Name</formula>
        <name>Update PV Installer Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Template_Num_for_EE_Assessment</fullName>
        <field>TemplateNumberForProject__c</field>
        <formula>3</formula>
        <name>Update Template Num for EE Assessment</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Template_Num_for_EE_Upgrade</fullName>
        <field>TemplateNumberForProject__c</field>
        <formula>4</formula>
        <name>Update Template Num for EE Upgrade</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Updater_PV_Assessor_Name</fullName>
        <field>PV_Assessor_Name__c</field>
        <formula>PV_Assessor__r.Name</formula>
        <name>Updater PV Assessor Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Make_Project_from_Template</fullName>
        <apiVersion>29.0</apiVersion>
        <endpointUrl>http://pgsalesforce.cloudapp.net/SuscoSalesForceSQLAPI/api/ProjectCreate</endpointUrl>
        <fields>Create_Project_SP_Name__c</fields>
        <fields>Id</fields>
        <fields>LastModifiedById</fields>
        <fields>TemplateNumberForProject__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>sfdcsupport@susco.net</integrationUser>
        <name>Make Project from Template</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Alert Sales Admins and Sales Reps of Resign</fullName>
        <actions>
            <name>Email_Alert_Notify_Sales_Admin_and</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contract Revision</value>
        </criteriaItems>
        <description>Notification sent to sales rep and sales admins when an opportunity is changed to the &quot;Contract Revision&quot; Stage by Doc Control.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_Alert_Contract_Revision_Expired</name>
                <type>Alert</type>
            </actions>
            <timeLength>10</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Client has Unique Ownership Situation</fullName>
        <actions>
            <name>Opps_with_Ownership_Issues</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2</booleanFilter>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Input Documents</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Client_has_a_unique_ownership_situation__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>For sales admins.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Contract approved by DC</fullName>
        <actions>
            <name>Congratulations_Your_packet_has_been_approved_Job_well_done</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Contract_Approved_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contracts Approved</value>
        </criteriaItems>
        <description>Contract approved by DC</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Create EE Assessment when Stage Changes</fullName>
        <actions>
            <name>Update_Template_Num_for_EE_Assessment</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Make_Project_from_Template</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.EE_Stage__c</field>
            <operation>equals</operation>
            <value>EE Assessment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Create EE Upgrade when Stage Changes</fullName>
        <actions>
            <name>Update_Template_Num_for_EE_Upgrade</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Make_Project_from_Template</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.EE_Stage__c</field>
            <operation>equals</operation>
            <value>EE Upgrade</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Customer Cancellation</fullName>
        <actions>
            <name>Install_Customer_Cancellation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Feasible_Stage__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>Customer Canceled Installation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Customer on Hold</fullName>
        <actions>
            <name>Customer_Placed_on_Hold</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Please_Contact_Customer</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Install_Status__c</field>
            <operation>equals</operation>
            <value>On Hold</value>
        </criteriaItems>
        <description>Customer has requested to be placed on hold until futher notification</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Feasible Stage Install Complete date</fullName>
        <actions>
            <name>Install_Complete_Date_Automation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Install_Completed__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Automatically update the Install Complete date once the Feasible Stage is changed to Install Complete also this update will update the Placed in Service date fields</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>For Pipeline Stage Update</fullName>
        <actions>
            <name>Update_Copy_of_Pipeline_Stage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Used for copying the Pipeline Stage to Copy of Pipeline Stage to create the Exception formulas</description>
        <formula>1=1</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Install Release Date update</fullName>
        <actions>
            <name>Install_Release_date_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Install_Released__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Client Signed Date</fullName>
        <actions>
            <name>Last_Client_Signed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Client Signed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Closed Won Date</fullName>
        <actions>
            <name>Last_Closed_Won_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Closed%2FLost Date</fullName>
        <actions>
            <name>Last_Closed_Lost_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Not Qualified,Lost - Not Feasible,Lost - Layout Rejected,Lost - Cancelled After Install Started,Lost,Closed/Lost</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Contract Revision Date</fullName>
        <actions>
            <name>Last_Contract_Revision_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contract Revision</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Contracts Approved Date</fullName>
        <actions>
            <name>Last_Contracts_Approved_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contracts Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Contracts Rejected by DC Date</fullName>
        <actions>
            <name>Last_Contracts_Rejected_by_DC_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contracts Rejected by DC</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Contracts Submitted to DC Date</fullName>
        <actions>
            <name>Last_Contracts_Submitted_to_DC_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contracts Submitted to DC</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Feasibility Analysis Date</fullName>
        <actions>
            <name>Last_Feasibility_Analysis_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Feasibility Analysis</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Input Documents Date</fullName>
        <actions>
            <name>Last_Input_Documents_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Input Documents</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Layout Approval Date</fullName>
        <actions>
            <name>Last_Layout_Approval_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Layout Approval</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Release to Installer Date</fullName>
        <actions>
            <name>Last_Release_to_Installer_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Release to Installer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Reschedule Appointment Date</fullName>
        <actions>
            <name>Last_Reschedule_Appointment_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Reschedule Appointment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Last Schedule Appointment Date</fullName>
        <actions>
            <name>Last_Schedule_Appointment_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Schedule Appointment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Mark Closed%2FLost</fullName>
        <actions>
            <name>Mark_Closed_Lost</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Not Qualified,Lost - Not Feasible,Lost - Layout Rejected,Lost - Cancelled After Install Started,Lost,Closed/Lost</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify  Sales Admin of Packet Rejection</fullName>
        <actions>
            <name>Alert_Metaire_Admin_of_Packet_Rejection</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
    ISPICKVAL(StageName, &apos;Contracts Rejected by DC&apos;),

 OR(
      Property__r.City__c  = &apos;Metairie&apos;,
       Account_City__c  = &apos;Metairie&apos;
   ) 
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify CL when revised contract is approved</fullName>
        <actions>
            <name>Notify_CL_when_revised_contract_is_approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Revised_Contract_Approved_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify EE CT About Rebate Submission</fullName>
        <actions>
            <name>Notify_EE_CT</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Rebate_Submission_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Account_State__c</field>
            <operation>equals</operation>
            <value>Connecticut</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Sales Rep of Packet Rejection</fullName>
        <actions>
            <name>Alert_Sales_Rep_of_Packet_Rejection</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISPICKVAL(StageName, &apos;Contracts Rejected by DC&apos;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opp Stage is Layout Approval</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Layout Approval</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Opportunity TM Changed</fullName>
        <actions>
            <name>Email_Alert_TM_Changed_on_Opportunity</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Every time the telemarketer on an opportunity is changed.</description>
        <formula>AND(NOT(ISBLANK( Telemarketer__c )), ISCHANGED( Telemarketer__c ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>PVI Electrical Installation Date Entered</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.PVI_Electrical_Installed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>PVI Rails and PVI Panels Dates Filled In</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.PVI_Panels_Installed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.PVI_Rails_Installed_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SHW Assessment</fullName>
        <actions>
            <name>SHW_Assessment_Request</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Solar_Hot_Water_Assessor__c</field>
            <operation>equals</operation>
            <value>Carimi Solar</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Contract Approved Date When Stage Changes</fullName>
        <actions>
            <name>Set_Contract_Approved_Date_To_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contracts Approved</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Contracts Rejected By DC Date Based on Stage</fullName>
        <actions>
            <name>Set_Contract_RejectedByDC_Date_To_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contracts Rejected by DC</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Contracts Signed Date</fullName>
        <actions>
            <name>Set_Contracts_Signed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Contracts_Signed_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Client Signed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Date Released to Installer</fullName>
        <actions>
            <name>Set_Date_Released_to_Installer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <description>Gives a value to &quot;Date Released to Installer&quot; Opportunity Field when Opportunity Status is set to &quot;Closed Won&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Initial Contract Submitted Date</fullName>
        <actions>
            <name>Set_Contract_Initial_Submission_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Contracts_Initially_Submitted_to_DC_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contracts Submitted to DC,Redeploy Submitted to DC</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Intacct Customer ID value To Opp ID</fullName>
        <actions>
            <name>Set_Intacct_Customer_ID_value_To_Opp_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Feasibility Analysis</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Stage Change to Closed Won</fullName>
        <actions>
            <name>Stage_Change_to_Closed_Won</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.PVI_Placed_In_Service_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Opp stage from Release to Installer to Closed Won once PiS date is entered in the PV Install project</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update PV Assessor Name</fullName>
        <actions>
            <name>Updater_PV_Assessor_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
 PV_Assessor__r.Name &lt;&gt;  PV_Assessor_Name__c  

)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update PV Installer Name</fullName>
        <actions>
            <name>Update_PV_Installer_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
PV_Installer__r.Name &lt;&gt; PV_Installer_Name__c 

)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Please_Contact_Customer</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>1</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Please Contact Customer</subject>
    </tasks>
</Workflow>
