<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Payout_Batch_has_been_queued_for_creation</fullName>
        <description>Payout Batch has been queued for creation</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Payout_Batch_has_been_queued_for_creation</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Payout_Batch_Processed_Date</fullName>
        <field>ActualPayOutDate__c</field>
        <formula>NOW()</formula>
        <name>Update Payout Batch Processed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>APBP Date is populated</fullName>
        <actions>
            <name>Payout_Batch_has_been_queued_for_creation</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>APBP Date = Actual Payout Batch Processed Date</description>
        <formula>ISPICKVAL(PRIORVALUE(Status__c),&quot;Submitted to Process&quot;)  &amp;&amp; ISPICKVAL(Status__c,&quot;Processed&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>When Status is equal to Processed</fullName>
        <actions>
            <name>Update_Payout_Batch_Processed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Payout_Batch__c.Status__c</field>
            <operation>equals</operation>
            <value>Processed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
