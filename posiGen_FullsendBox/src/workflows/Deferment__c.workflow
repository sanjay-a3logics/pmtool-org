<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Deferment_Request_Rejected_Alert</fullName>
        <description>Deferment Request Rejected Alert</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Deferment_Rejected</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_final_approval_date</fullName>
        <field>Final_Approval_Date__c</field>
        <formula>today()</formula>
        <name>Update final approval date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_pre_approval_date</fullName>
        <field>Pre_Approval_Date__c</field>
        <formula>today()</formula>
        <name>Update pre-approval date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_submission_date</fullName>
        <field>Submission_Date__c</field>
        <formula>today()</formula>
        <name>Update submission date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
