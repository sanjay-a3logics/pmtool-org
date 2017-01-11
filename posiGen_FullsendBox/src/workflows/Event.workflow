<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <fieldUpdates>
        <fullName>Log_Appt_Creation_Time</fullName>
        <field>Appt_Creation_Time__c</field>
        <formula>NOW()</formula>
        <name>Log Appt Creation Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Original_Appt_Type_to_be_Appt_Type</fullName>
        <field>Original_Appointment_Type__c</field>
        <formula>TEXT(Type)</formula>
        <name>Set Original Appt Type to be Appt Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Activity_Call_Time</fullName>
        <field xsi:nil="true"/>
        <formula>NOW()</formula>
        <name>Update Activity Call Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_with_Appt_Details</fullName>
        <description>Every time a sales appointment is made, update event description with Opp name, owner and Link.</description>
        <field>Description</field>
        <name>Update with Appt Details</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email Michael Mann on Sales Appointment Scheduled Today</fullName>
        <actions>
            <name>Appoinment_Scheduled_Today</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>equals</operation>
            <value>Sales Appointment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.StartDateTime</field>
            <operation>equals</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Customer_Time_Zone__c</field>
            <operation>equals</operation>
            <value>Central</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Last Sales Appt Update</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>equals</operation>
            <value>Sales Appointment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Log Appt Creation Time</fullName>
        <actions>
            <name>Log_Appt_Creation_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>equals</operation>
            <value>Sales Appointment</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Sales Appointment Event Type is Created</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>equals</operation>
            <value>Sales Appointment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Assigned_to_Division__c</field>
            <operation>equals</operation>
            <value>Shreveport</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Sales Appt Information Update</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>equals</operation>
            <value>Sales Appointment</value>
        </criteriaItems>
        <description>Notification to update Sales Appointment information</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <offsetFromField>Event.StartDateTime</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Set Original Event Type when blank</fullName>
        <actions>
            <name>Set_Original_Appt_Type_to_be_Appt_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Event.Original_Appointment_Type__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task Alli Tindall when Sales Appointment Scheduled</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>equals</operation>
            <value>Sales Appointment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Assigned_to_Division__c</field>
            <operation>equals</operation>
            <value>Baton Rouge,Lafayette</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Customer_Time_Zone__c</field>
            <operation>equals</operation>
            <value>Central</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Task Juliet Peevy when Sales Appointment Scheduled</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>equals</operation>
            <value>Sales Appointment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Assigned_to_Division__c</field>
            <operation>equals</operation>
            <value>Shreveport</value>
        </criteriaItems>
        <criteriaItems>
            <field>Event.Customer_Time_Zone__c</field>
            <operation>equals</operation>
            <value>Central</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Event Descriptions</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Event.Type</field>
            <operation>equals</operation>
            <value>Sales Appointment</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>Appoinment_Scheduled_Today</fullName>
        <assignedTo>mmann@posigen.com</assignedTo>
        <assignedToType>user</assignedToType>
        <description>An appointment has been made today with the Lead record parented to this task.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>true</notifyAssignee>
        <offsetFromField>Event.Appointment_Set_Date__c</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Appoinment Scheduled Today</subject>
    </tasks>
</Workflow>
