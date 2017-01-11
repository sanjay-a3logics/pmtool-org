<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Array_Rating</fullName>
        <field>Array_Rating_kW__c</field>
        <formula>Planned_Number_of_Modules__c * Panel_Model__r.Rating__c/1000</formula>
        <name>Update Array Rating</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>On Array Create or Update</fullName>
        <actions>
            <name>Update_Array_Rating</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
