<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Hire_Alert</fullName>
        <description>Hire Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>sfischer@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Hire</template>
    </alerts>
    <fieldUpdates>
        <fullName>New_Hire_DOA_Date</fullName>
        <field>DOA_Date__c</field>
        <formula>today()</formula>
        <name>New Hire DOA Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>DOA Date</fullName>
        <actions>
            <name>New_Hire_DOA_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>New_Hire__c.DOA__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>New Hire</fullName>
        <actions>
            <name>Hire_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
