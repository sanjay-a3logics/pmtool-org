<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>test</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Serialized_Item__c.Name</field>
            <operation>contains</operation>
            <value>smart</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
