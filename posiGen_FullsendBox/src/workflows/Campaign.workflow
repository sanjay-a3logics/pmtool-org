<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Campaign_Name</fullName>
        <description>Update Campaign Name with Referree Name and Referrer Name</description>
        <field>Name</field>
        <formula>LEFT(SRT_Referee__r.FirstName &amp; &quot; &quot; &amp;  SRT_Referee__r.LastName   &amp; &quot; from &quot; &amp;  Referrer__r.FirstName &amp; &quot; &quot; &amp; Referrer__r.LastName, 79)</formula>
        <name>Update Campaign Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_SRT_Referral_Amount</fullName>
        <field>SRT_Referral_Amount__c</field>
        <formula>Parent_Campaign_Referral_Amount_for_SRT__c</formula>
        <name>Update SRT Referral Amount</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Campaign RT equals Referral and Every Time It Is Edited</fullName>
        <actions>
            <name>Update_Campaign_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.RecordTypeId</field>
            <operation>equals</operation>
            <value>Referral</value>
        </criteriaItems>
        <description>If Campaign RT equals Referral, then execute actions.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Campaign RT equals Referral and On Creation Only</fullName>
        <actions>
            <name>Update_SRT_Referral_Amount</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.RecordTypeId</field>
            <operation>equals</operation>
            <value>Referral</value>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.Parent_Campaign_Referral_Amount_for_SRT__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>If Campaign Record Type = Referral and Parent Campaign Referral Amount for SRT is not null, then execute.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
