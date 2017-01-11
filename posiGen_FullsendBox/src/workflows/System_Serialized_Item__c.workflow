<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Populate_Item_Group_from_SI</fullName>
        <field>Item_Group_from_SI__c</field>
        <formula>TEXT(Serialized_Item__r.Item_Group__c)</formula>
        <name>Populate Item Group from SI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Populate Item Group from SI</fullName>
        <actions>
            <name>Populate_Item_Group_from_SI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
