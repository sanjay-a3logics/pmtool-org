<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_UC_Name_to_be_Outline_Num_and_Title</fullName>
        <field>Name</field>
        <formula>Outline_Number__c + &apos;: &apos; +  Title__c</formula>
        <name>Set UC Name to be Outline Num and Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update UC Name with Outline and Title</fullName>
        <actions>
            <name>Set_UC_Name_to_be_Outline_Num_and_Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
