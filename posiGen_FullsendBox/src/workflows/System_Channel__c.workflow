<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change_Active_Status_Date_Value_to_Today</fullName>
        <field>Active_Status_Date__c</field>
        <formula>Today()</formula>
        <name>Change Active Status Date Value to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Inactive_Status_Date_Value_To_Today</fullName>
        <field>Inactive_Status_Date__c</field>
        <formula>Today()</formula>
        <name>Set Inactive Status Date Value To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Reg_Read_Status_Date_Value_To_Today</fullName>
        <field>Register_Read_Status_Date__c</field>
        <formula>Today()</formula>
        <name>Set Reg. Read Status Date Value To Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Fill Active Status Date</fullName>
        <actions>
            <name>Change_Active_Status_Date_Value_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>System_Channel__c.Status__c</field>
            <operation>equals</operation>
            <value>Active</value>
        </criteriaItems>
        <description>Set the date to Today when Status=Active</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Fill Inactive Status Date</fullName>
        <actions>
            <name>Set_Inactive_Status_Date_Value_To_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>System_Channel__c.Status__c</field>
            <operation>equals</operation>
            <value>Inactive</value>
        </criteriaItems>
        <description>Set the date to Today when Status=Inactive</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Fill Register Read Status Date</fullName>
        <actions>
            <name>Set_Reg_Read_Status_Date_Value_To_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>System_Channel__c.Status__c</field>
            <operation>equals</operation>
            <value>Register Read</value>
        </criteriaItems>
        <description>Set the date to Today when Status=Register Read</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
