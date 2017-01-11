<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Reward_Status_To_Failed</fullName>
        <field>Reward_Status__c</field>
        <literalValue>Failed</literalValue>
        <name>Set Reward Status To Failed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Time Limit Set</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Reward__c.Time_Limit_Date_Time__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
