<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Promotion_Deactivation</fullName>
        <description>Unchecks the Promotion Active Checkbox.  Sharing rules are dependent on that box.</description>
        <field>Active__c</field>
        <literalValue>0</literalValue>
        <name>Promotion Deactivation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Promotion Deactivation</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Promotion__c.Active__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Promotion_Deactivation</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Promotion__c.Date_End__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
