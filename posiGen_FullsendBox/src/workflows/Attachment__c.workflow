<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Invoice_Submission_Alert_CT</fullName>
        <description>Invoice Submission Alert (CT)</description>
        <protected>false</protected>
        <recipients>
            <recipient>cmcshane@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mneyhart@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Installer_Invoice_Submitted</template>
    </alerts>
    <alerts>
        <fullName>Invoice_Submission_Alert_NY</fullName>
        <description>Invoice Submission Alert (NY)</description>
        <protected>false</protected>
        <recipients>
            <recipient>marndt@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mneyhart@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Installer_Invoice_Submitted</template>
    </alerts>
    <rules>
        <fullName>Invoice Submission Alert %28CT%29</fullName>
        <actions>
            <name>Invoice_Submission_Alert_CT</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Attachment__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Attachment__c.State__c</field>
            <operation>equals</operation>
            <value>CT</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attachment__c.Type__c</field>
            <operation>equals</operation>
            <value>03CTNY- PV Assessment Invoice,03CTNY- PV Install Invoice,03CTNY- Design/Engineering Invoice,Invoice,PV Assessment Invoice,PV Install Invoice,PV Service Invoice</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Invoice Submission Alert %28NY%29</fullName>
        <actions>
            <name>Invoice_Submission_Alert_NY</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Attachment__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Attachment__c.State__c</field>
            <operation>equals</operation>
            <value>NY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Attachment__c.Type__c</field>
            <operation>equals</operation>
            <value>03CTNY- PV Assessment Invoice,03CTNY- PV Install Invoice,03CTNY- Design/Engineering Invoice,Invoice,PV Assessment Invoice,PV Install Invoice,PV Retainage Invoice,PV Service Invoice</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
