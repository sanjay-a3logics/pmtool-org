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
        <fullName>EE_E_I_Consulting_email_alert</fullName>
        <ccEmails>roger@maxvalueins.com</ccEmails>
        <description>EE E&amp;I Consulting email alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>kareno@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/EE_Contractor_Request</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Fontenot</fullName>
        <description>Email to Fontenot</description>
        <protected>false</protected>
        <recipients>
            <recipient>fontenot-insulation@cox.net</recipient>
            <type>partnerUser</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/EE_Contractor_Request</template>
    </alerts>
    <alerts>
        <fullName>KDH_2nd_request_for_service</fullName>
        <description>KDH 2nd request for service</description>
        <protected>false</protected>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dhunter@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kdhalyx1@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/X2nd_Request_for_Service</template>
    </alerts>
    <alerts>
        <fullName>KDH_QC_Service_Call</fullName>
        <description>KDH QC Service Call</description>
        <protected>false</protected>
        <recipients>
            <recipient>kdhalyx@gmail.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sdouglas@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Mr_Green_EE_Contractor</fullName>
        <ccEmails>terry@mrgreenj.com</ccEmails>
        <ccEmails>dholtman@posigen.com</ccEmails>
        <ccEmails>amanriquez@posigen.com</ccEmails>
        <description>Mr. Green - EE Contractor</description>
        <protected>false</protected>
        <recipients>
            <recipient>dustie.greenjeans@gmail.com</recipient>
            <type>partnerUser</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/EE_Contractor_Request</template>
    </alerts>
    <alerts>
        <fullName>New_Voice_Media_Case_Alert</fullName>
        <description>New Voice Media Case Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/NVM_Case</template>
    </alerts>
    <alerts>
        <fullName>Notify_Customer_Care</fullName>
        <ccEmails>customercare@posigen.com</ccEmails>
        <description>Notify Customer Care When Case Is Assigned to Them</description>
        <protected>false</protected>
        <recipients>
            <recipient>xcabo@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Case_Assigned_to_Assigned_Group</template>
    </alerts>
    <alerts>
        <fullName>Notify_Posigen_Internal</fullName>
        <description>Notify Posigen Internal When Case Assigned</description>
        <protected>false</protected>
        <recipients>
            <recipient>rhisel@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Case_Assigned_to_Assigned_Group</template>
    </alerts>
    <alerts>
        <fullName>Rejection_Notice_to_Installer</fullName>
        <description>Rejection Notice to Installer</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Ops_Rejection_Notice</template>
    </alerts>
    <alerts>
        <fullName>Request_for_Contractor</fullName>
        <description>Request for Contractor</description>
        <protected>false</protected>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Request_to_Close</fullName>
        <description>Request to Close</description>
        <protected>false</protected>
        <recipients>
            <recipient>bhirsch@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORTCaseescalationnotificationSAMPLE</template>
    </alerts>
    <alerts>
        <fullName>Resend_to_Contractor</fullName>
        <description>Resend to Contractor</description>
        <protected>false</protected>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kdhalyx1@gmail.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/X2nd_Request_for_Service</template>
    </alerts>
    <alerts>
        <fullName>Retro_Fitz_Email_Alert</fullName>
        <ccEmails>ashley@retro-fitz.com</ccEmails>
        <ccEmails>roger@maxvalueins.com</ccEmails>
        <description>Retro Fitz Email Alert</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/EE_Contractor_Request</template>
    </alerts>
    <alerts>
        <fullName>SHW_Service_Call</fullName>
        <ccEmails>melissa@carimisolar.com</ccEmails>
        <description>SHW Service Call</description>
        <protected>false</protected>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>joel@carimisolar.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sdouglas@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/SHW_Service_Call</template>
    </alerts>
    <alerts>
        <fullName>Service_Call_Alerts_for_BLG_and_PosiGen_Iinternal</fullName>
        <description>Service Call Alerts for BLG and PosiGen Internal</description>
        <protected>false</protected>
        <recipients>
            <recipient>btrainor@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>rhisel@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Service_Case_Closing_Rejected</fullName>
        <description>Service Case Closing Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>LastModifiedById</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Ops_Rejection_Notice</template>
    </alerts>
    <alerts>
        <fullName>Veteran_Contractors_2nd_request_for_service</fullName>
        <description>Veteran Contractors 2nd request for service</description>
        <protected>false</protected>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>bryan.lictenstein@veterancontractors.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dhunter@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>testuser7@susco.net</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/X2nd_Request_for_Service</template>
    </alerts>
    <alerts>
        <fullName>Veteran_QC_Service_Call</fullName>
        <ccEmails>drew.walsh@veterancontractors.com</ccEmails>
        <description>Veteran QC Service Call</description>
        <protected>false</protected>
        <recipients>
            <recipient>awyatt@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>dholley@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sdouglas@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Veteran_QC_Service_Calls</template>
    </alerts>
    <alerts>
        <fullName>Veterans_Contractors_Service_Call</fullName>
        <ccEmails>qc@veterancontractors.com</ccEmails>
        <description>Veterans Contractors Service Call</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Veteran_QC_Service_Calls</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_Status</fullName>
        <description>Change status back to Request For Contractor</description>
        <field>Status</field>
        <literalValue>Request for Contractor</literalValue>
        <name>Change Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Status_to</fullName>
        <description>Change case status to Check Meter Provisioning</description>
        <field>Status</field>
        <literalValue>Check Meter Provisioning</literalValue>
        <name>Change Case Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mobile_sms</fullName>
        <field>Case_Mobile__c</field>
        <formula>Mobile_Number__c</formula>
        <name>Mobile sms</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Case_mobile_number</fullName>
        <field>Mobile_Number__c</field>
        <formula>Account.PersonMobilePhone</formula>
        <name>Set Case mobile number</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Subcontractor_Name_for_Sharing</fullName>
        <description>Set Subcontractor Name for Sharing to the look up value from Assigned_To_Subcontractor__r</description>
        <field>Subcontractor_Name_for_Sharing_Rule__c</field>
        <formula>Assigned_To_Subcontractor__r.Name</formula>
        <name>Set Subcontractor Name for Sharing</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Change</fullName>
        <description>Status change to Request Manager Review</description>
        <field>Status</field>
        <literalValue>Request Manager Review</literalValue>
        <name>Status Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Date_Sent_to_Contractor</fullName>
        <field>Date_Sent_to_Service_Contractor__c</field>
        <formula>TODAY()</formula>
        <name>Update Date Sent to Contractor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Send_Case_Notification_To_Field</fullName>
        <description>This updates the field on the Case from the Account.</description>
        <field>Send_Case_Notifications_To__c</field>
        <formula>Case_Notification_Placeholder_Field__c</formula>
        <name>Update Send Case Notification To Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>EE E%26I Consulting</fullName>
        <actions>
            <name>EE_E_I_Consulting_email_alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Assigned_Group__c</field>
            <operation>equals</operation>
            <value>E &amp; I Consultants</value>
        </criteriaItems>
        <description>EE Contractor Email Alert</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Enviro Green</fullName>
        <active>true</active>
        <description>Email Alert to Consultant</description>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;EnviroGreen&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Is Sub Name for Sharing equal to lookup value</fullName>
        <actions>
            <name>Set_Subcontractor_Name_for_Sharing</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>NOT(Assigned_To_Subcontractor__r.Name =  Subcontractor_Name_for_Sharing_Rule__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>KDH 2nd Request</fullName>
        <actions>
            <name>KDH_2nd_request_for_service</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>KDH 2nd Request for customer service repair</description>
        <formula>AND(Resend_To_Contractor2__c,  or(Assigned_To_Subcontractor__r.Name = &quot;KDH&quot;,
Assigned_To_Subcontractor__r.Name = &quot;K D Homes Builder LLC&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>KDH Service Call</fullName>
        <actions>
            <name>KDH_QC_Service_Call</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>KDH request for service to solar panel system</description>
        <formula>OR(Assigned_To_Subcontractor__r.Name = &quot;KDH&quot;,
Assigned_To_Subcontractor__r.Name = &quot;K D Homes Builder LLC&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Mr%2E Green Jean</fullName>
        <actions>
            <name>Mr_Green_EE_Contractor</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email Alert to Consultant</description>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;Mr. Green Jeans&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Case Created</fullName>
        <actions>
            <name>Case_Alert_Sent_from_Send_Case_Notifications_To_Email_Field</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Send_Case_Notification_To_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification When Case Assigned to Customer Care</fullName>
        <actions>
            <name>Notify_Customer_Care</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Assigned_Group__c</field>
            <operation>equals</operation>
            <value>Customer Care</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>EE,PV,SF2,Thermal</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notification When Case Assigned to Posigen Internal</fullName>
        <actions>
            <name>Notify_Posigen_Internal</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Assigned_Group__c</field>
            <operation>equals</operation>
            <value>Posigen Internal</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Master Cases</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Fontenot</fullName>
        <actions>
            <name>Email_to_Fontenot</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Assigned_To_Subcontractor__c  &lt;&gt; &quot;Fontenot Insulation&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request for Contractor</fullName>
        <actions>
            <name>Request_for_Contractor</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Request_for_Contractor__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>CSR request for contractor.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request to Close Case</fullName>
        <actions>
            <name>Request_to_Close</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Request to Close</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Request to Send to Contractor</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Resend to Contractor</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Retro Fitz Contractors Alert</fullName>
        <actions>
            <name>Retro_Fitz_Email_Alert</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Date_Sent_to_Contractor</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;Retro Fitz&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>SHW Service Calls</fullName>
        <actions>
            <name>SHW_Service_Call</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Solar Hot Water Service Call</description>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;Carimi Contractors&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Service Calls for BLG %26 PosiGen Internal</fullName>
        <actions>
            <name>Service_Call_Alerts_for_BLG_and_PosiGen_Iinternal</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;BLG Solar Solutions&quot;  ||  Assigned_To_Subcontractor__r.Name = &quot;PosiGen Internal&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Phone %23s</fullName>
        <actions>
            <name>Set_Case_mobile_number</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns values from the account to the cases respective phone numbers</description>
        <formula>OR(
Account.Phone &lt;&gt; NULL)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update case mobile number</fullName>
        <actions>
            <name>Mobile_sms</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule will update the case mobile number. which would be used whenever we are sending out a sms from case</description>
        <formula>True</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Veteran 2nd Request</fullName>
        <actions>
            <name>Veteran_Contractors_2nd_request_for_service</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Veteran Contractors 2nd Request for customer service repair</description>
        <formula>AND(Resend_To_Contractor2__c,  Assigned_To_Subcontractor__r.Name = &quot;Veteran Contractors&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Veteran QC Service Call</fullName>
        <actions>
            <name>Veterans_Contractors_Service_Call</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Veteran request for service</description>
        <formula>Assigned_To_Subcontractor__r.Name = &quot;Veteran Contractors&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
