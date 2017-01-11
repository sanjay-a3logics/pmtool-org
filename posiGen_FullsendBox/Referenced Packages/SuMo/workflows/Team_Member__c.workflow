<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_end_to_now</fullName>
        <field>End_Date_Time__c</field>
        <formula>NOW()</formula>
        <name>Update end to now</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>Team__c</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_to_next_state_competitor</fullName>
        <field>Status__c</field>
        <name>Update to next state competitor</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>NextValue</operation>
        <protected>true</protected>
        <targetObject>Team__c</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Winning Score Achieved</fullName>
        <actions>
            <name>Update_end_to_now</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_to_next_state_competitor</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( Competition_Status__c = &apos;Running&apos;,Score__c &gt;=  Team__r.Winning_Score__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
