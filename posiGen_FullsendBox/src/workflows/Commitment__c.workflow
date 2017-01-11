<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Commitment_Status_To_Broken</fullName>
        <field>Commitment_Status__c</field>
        <literalValue>Broken</literalValue>
        <name>Update Commitment Status To Broken</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Commitment_Status_To_Kept</fullName>
        <field>Commitment_Status__c</field>
        <literalValue>Kept</literalValue>
        <name>Update Commitment Status To Kept</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_To_Commitment_Broken</fullName>
        <field>Commitment_Kept__c</field>
        <literalValue>0</literalValue>
        <name>Update To Commitment Broken</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Commitment Broken</fullName>
        <actions>
            <name>Update_Commitment_Status_To_Broken</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_To_Commitment_Broken</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Payment_Received__c  &lt;&gt; TRUE &amp;&amp; Committed_Date__c &lt; Today()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Commitment Kept</fullName>
        <actions>
            <name>Update_Commitment_Status_To_Kept</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Payment_Received__c  = TRUE &amp;&amp;  Committed_Date__c  &gt;= Today()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
