<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>SL_Update_Part_Code</fullName>
        <field>Part_Code__c</field>
        <formula>Part__r.part_code__c</formula>
        <name>SL_Update Part Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SL_Update_Part_Quantity</fullName>
        <field>Quantity__c</field>
        <formula>Part__r.Default_Quantity__c</formula>
        <name>SL_Update Part Quantity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>SL%5F%5FUpdate System Part Quantity and Code</fullName>
        <actions>
            <name>SL_Update_Part_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SL_Update_Part_Quantity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
