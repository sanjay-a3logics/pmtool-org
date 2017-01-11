<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Case_Alert_Sent_from_Send_Case_Notifications_To_Email_Field</fullName>
        <description>Case Alert Sent from Send Case Notifications To Email Field</description>
        <protected>false</protected>
        <recipients>
            <field>Send_Case_Notifications_To__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Issue_Case_Alert_Sent_from_Send_Case_Notifications_To_Email_Field</fullName>
        <description>Issue - Case Alert Sent from Send Case Notifications To Email Field</description>
        <protected>false</protected>
        <recipients>
            <field>Send_Case_Notifications_To__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Issue_EE_E_I_Consulting_email_alert</fullName>
        <ccEmails>roger@maxvalueins.com</ccEmails>
        <description>Issue - EE E&amp;I Consulting email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>kareno@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_EE_Contractor_Request</template>
    </alerts>
    <alerts>
        <fullName>Issue_KDH_2nd_request_for_service</fullName>
        <description>Issue - KDH 2nd request for service</description>
        <protected>false</protected>
        <recipients>
            <recipient>kdhalyx@gmail.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_X2nd_Request_for_Service</template>
    </alerts>
    <alerts>
        <fullName>Issue_KDH_QC_Service_Call</fullName>
        <description>Issue - KDH QC Service Call</description>
        <protected>false</protected>
        <recipients>
            <recipient>kdhalyx@gmail.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <recipients>
            <recipient>sdouglas@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Issue_Notify_Customer_Care_When_Case_Is_Assigned_to_Them</fullName>
        <ccEmails>customercare@posigen.com</ccEmails>
        <description>Issue - Notify Customer Care When Case Is Assigned to Them</description>
        <protected>false</protected>
        <recipients>
            <recipient>xcabo@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_Case_Assigned_to_Assigned_Group</template>
    </alerts>
    <alerts>
        <fullName>Issue_Notify_Posigen_Internal_When_Case_Assigned</fullName>
        <description>Issue - Notify Posigen Internal When Case Assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>rhisel@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_Case_Assigned_to_Assigned_Group</template>
    </alerts>
    <alerts>
        <fullName>Issue_Request_for_Contractor</fullName>
        <ccEmails>xcabo@posigen.com</ccEmails>
        <description>Issue - Request for Contractor</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Issue_Request_to_Close</fullName>
        <description>Issue Request to Close</description>
        <protected>false</protected>
        <recipients>
            <recipient>xcabo@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORTIssueeescalationnotificationSAMPLE</template>
    </alerts>
    <alerts>
        <fullName>Issue_Retro_Fitz_Email_Alert</fullName>
        <ccEmails>ashley@retro-fitz.com</ccEmails>
        <ccEmails>roger@maxvalueins.com</ccEmails>
        <description>Issue - Retro Fitz Email Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_EE_Contractor_Request</template>
    </alerts>
    <alerts>
        <fullName>Issue_SHW_Service_Call</fullName>
        <ccEmails>melissa@carimisolar.com</ccEmails>
        <description>Issue-SHW Service Call</description>
        <protected>false</protected>
        <recipients>
            <recipient>sdouglas@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/SHW_Service_Call</template>
    </alerts>
    <alerts>
        <fullName>Issue_Service_Call_Alerts_for_BLG_and_PosiGen_Internal</fullName>
        <description>Issue - Service Call Alerts for BLG and PosiGen Internal</description>
        <protected>false</protected>
        <recipients>
            <recipient>rhisel@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Issue_Veteran_Contractors_2nd_request_for_service</fullName>
        <ccEmails>xcabo@posigen.com</ccEmails>
        <description>Issue - Veteran Contractors 2nd request for service</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_X2nd_Request_for_Service</template>
    </alerts>
    <alerts>
        <fullName>Issue_Veterans_Contractors_Service_Call</fullName>
        <ccEmails>qc@veterancontractors.com</ccEmails>
        <description>Issue - Veterans Contractors Service Call</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Issue_Veteran_QC_Service_Calls</template>
    </alerts>
    <fieldUpdates>
        <fullName>Issue_Mobile_sms</fullName>
        <field>Case_Mobile__c</field>
        <formula>Mobile_Number__c</formula>
        <name>Issue - Mobile sms</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Issue_Set_Case_mobile_number</fullName>
        <field>Mobile_Number__c</field>
        <formula>AccountId__r.PersonContact.MobilePhone</formula>
        <name>Issue - Set Case mobile number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Issue_Set_Subcontractor_Name_for_Shari</fullName>
        <field>Subcontractor_Name_for_Sharing_Rule__c</field>
        <formula>Assigned_To_Subcontractor__r.Name</formula>
        <name>Issue - Set Subcontractor Name for Shari</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Issue_Update_Date_Sent_to_Contractor</fullName>
        <field>Date_Sent_to_Service_Contractor__c</field>
        <formula>TODAY()</formula>
        <name>Issue - Update Date Sent to Contractor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Issue_Update_Send_Case_Notification_To</fullName>
        <description>This updates the field on the Case from the Account.</description>
        <field>Send_Case_Notifications_To__c</field>
        <formula>Case_Notification_Placeholder_Field__c</formula>
        <name>Issue - Update Send Case Notification To</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Date_Time_Closed</fullName>
        <field>ClosedDate__c</field>
        <formula>now()</formula>
        <name>Populate Date/Time Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Date_Time_Opened</fullName>
        <field>CreatedDate__c</field>
        <formula>now()</formula>
        <name>Populate Date/Time Opened</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Issue - EE E%26I Consulting</fullName>
        <actions>
            <name>Issue_EE_E_I_Consulting_email_alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue__c.Assigned_Group__c</field>
            <operation>equals</operation>
            <value>E &amp; I Consultants</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Is Sub Name for Sharing equal to lookup value</fullName>
        <actions>
            <name>Issue_Set_Subcontractor_Name_for_Shari</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(Assigned_To_Subcontractor__r.Name =  Subcontractor_Name_for_Sharing_Rule__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Issue - KDH 2nd Request</fullName>
        <actions>
            <name>Issue_KDH_2nd_request_for_service</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>KDH 2nd Request for customer service repair</description>
        <formula>AND(Resend_To_Contractor2__c,  or(Assigned_To_Subcontractor__r.Name = &quot;KDH&quot;, Assigned_To_Subcontractor__r.Name = &quot;K D Homes Builder LLC&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - KDH Service Call</fullName>
        <actions>
            <name>Issue_KDH_QC_Service_Call</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>OR(Assigned_To_Subcontractor__r.Name = &quot;KDH&quot;, Assigned_To_Subcontractor__r.Name = &quot;K D Homes Builder LLC&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Notification When Case Assigned to Customer Care</fullName>
        <actions>
            <name>Issue_Notify_Customer_Care_When_Case_Is_Assigned_to_Them</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue__c.Assigned_Group__c</field>
            <operation>equals</operation>
            <value>Customer Care</value>
        </criteriaItems>
        <criteriaItems>
            <field>Issue__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>EE,PV,SF2,Thermal</value>
        </criteriaItems>
        <description>\Notify Customer Care When Case Is Assigned to Them</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Notification When Case Assigned to Posigen Internal</fullName>
        <actions>
            <name>Issue_Notify_Posigen_Internal_When_Case_Assigned</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue__c.Assigned_Group__c</field>
            <operation>equals</operation>
            <value>Posigen Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Issue__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Master Cases</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Request for Contractor</fullName>
        <actions>
            <name>Issue_Request_for_Contractor</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue__c.Request_for_Contractor__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>CSR request for contractor.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Request to Close Case</fullName>
        <actions>
            <name>Issue_Request_to_Close</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Issue__c.Status__c</field>
            <operation>equals</operation>
            <value>Request to Close</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Retro Fitz Contractors Alert</fullName>
        <actions>
            <name>Issue_Retro_Fitz_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Issue_Update_Date_Sent_to_Contractor</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;Retro Fitz&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Service Calls for BLG %26 PosiGen Internal</fullName>
        <actions>
            <name>Issue_Service_Call_Alerts_for_BLG_and_PosiGen_Internal</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;BLG Solar Solutions&quot;  ||  Assigned_To_Subcontractor__r.Name = &quot;PosiGen Internal&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Update case mobile number</fullName>
        <actions>
            <name>Issue_Mobile_sms</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule will update the case mobile number. which would be used whenever we are sending out a sms from case</description>
        <formula>true</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Veteran 2nd Request</fullName>
        <actions>
            <name>Issue_Veteran_Contractors_2nd_request_for_service</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Veteran Contractors 2nd Request for customer service repair</description>
        <formula>AND(Resend_To_Contractor2__c,  Assigned_To_Subcontractor__r.Name = &quot;Veteran Contractors&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - Veteran QC Service Call</fullName>
        <actions>
            <name>Issue_Veterans_Contractors_Service_Call</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Veteran request for service</description>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;Veteran Contractors&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue - pdate Case Phone %23s</fullName>
        <actions>
            <name>Issue_Set_Case_mobile_number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns values from the account to the cases respective phone numbers</description>
        <formula>OR( AccountId__r.Phone  &lt;&gt; NULL)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Issue -New Case Created</fullName>
        <actions>
            <name>Issue_Case_Alert_Sent_from_Send_Case_Notifications_To_Email_Field</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Issue_Update_Send_Case_Notification_To</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Populate_Date_Time_Opened</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>true</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Issue SHW Service Calls</fullName>
        <actions>
            <name>Issue_SHW_Service_Call</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>SHW Service Call</description>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;Carimi Contractors&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populated Date%2FTime Closed</fullName>
        <actions>
            <name>Populate_Date_Time_Closed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Issue__c.Status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
