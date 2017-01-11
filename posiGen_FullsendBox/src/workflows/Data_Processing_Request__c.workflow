<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>DPRHasChangedStatus</fullName>
        <description>Sends email alert to DPR record owner when status has changed</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Your_DPR_Has_Changed_Status</template>
    </alerts>
    <rules>
        <fullName>DPR Completed</fullName>
        <actions>
            <name>DPRHasChangedStatus</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Data_Processing_Request__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Process Complete</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>DPR Started</fullName>
        <actions>
            <name>DPRHasChangedStatus</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Data_Processing_Request__c.Request_Status__c</field>
            <operation>equals</operation>
            <value>Submitted to Process</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
