<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Array_Rating_for_Rollup</fullName>
        <description>Update_Array_Rating_for_Rollup</description>
        <field>Array_Rating_for_Rollup_kW__c</field>
        <formula>Array_Rating_kW__c</formula>
        <name>Update_Array_Rating_for_Rollup</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update_Array_Rating_for_Rollup</fullName>
        <actions>
            <name>Update_Array_Rating_for_Rollup</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
