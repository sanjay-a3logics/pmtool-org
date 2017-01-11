<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Installation_Complete</fullName>
        <ccEmails>rpogue@greengrants.com</ccEmails>
        <description>Installation Complete</description>
        <protected>false</protected>
        <recipients>
            <recipient>Operations</recipient>
            <type>roleSubordinates</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Installation_Complete</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_Subcontractor_for_Case_Notifications</fullName>
        <description>Send Email to Subcontractor for Case Notifications</description>
        <protected>false</protected>
        <recipients>
            <field>Send_Case_Notifications_To__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Veteran_QC_Service_Calls</template>
    </alerts>
    <fieldUpdates>
        <fullName>Birthdate_Update</fullName>
        <field>PersonBirthdate</field>
        <formula>Lead_Birthdate__c</formula>
        <name>Birthdate Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flag_Transferred_Account</fullName>
        <field>Previous_System_Owner__c</field>
        <literalValue>1</literalValue>
        <name>Flag Transferred Account</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Birthdate Update</fullName>
        <actions>
            <name>Birthdate_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Lead_Birthdate__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Flag Transferred Accounts</fullName>
        <actions>
            <name>Flag_Transferred_Account</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Transferred_Opportunity__c  &lt;&gt; NULL</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
