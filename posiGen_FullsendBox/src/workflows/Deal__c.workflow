<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Congratulations_Your_packet_has_been_approved_Job_well_done_Deal</fullName>
        <description>Congratulations! Your packet has been approved. Job well done - Deal</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Sales_Email_Templates/Congratulations_Your_packet_has_been_approved_Job_well_done</template>
    </alerts>
    <alerts>
        <fullName>Deal_Contract_Revision</fullName>
        <description>Deal Contract Revision</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Sales_Admin_Packet__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Sales_Email_Templates/Contract_Revision</template>
    </alerts>
    <alerts>
        <fullName>Deal_Contract_Revision_Expired</fullName>
        <description>Deal Contract Revision Expired</description>
        <protected>false</protected>
        <recipients>
            <recipient>cburnham@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jschouest@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Sales_Email_Templates/Contract_Revision_Stage_Expired</template>
    </alerts>
    <alerts>
        <fullName>Deal_Contracts_Rejection</fullName>
        <description>Deal Contracts Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Sales_Admin_Packet__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Salesperson__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Packet_Rejected_by_DC</template>
    </alerts>
    <alerts>
        <fullName>Deals_with_Ownership_Issues</fullName>
        <description>Deals with Ownership Issues</description>
        <protected>false</protected>
        <recipients>
            <recipient>Sales_Admin</recipient>
            <type>role</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>SF2_Sales_Email_Templates/Ownership_Issue</template>
    </alerts>
    <fieldUpdates>
        <fullName>Deal_Pipeline_Stage</fullName>
        <field>Pipeline_Stage__c</field>
        <formula>Opportunity__r.Pipeline_Stage__c</formula>
        <name>Deal Pipeline Stage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>OppNumericID</fullName>
        <field>Opp_Numeric_IDx__c</field>
        <formula>Opportunity__r.Opp_Numeric_ID__c</formula>
        <name>OppNumericID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Deal Pipeline Stage Update</fullName>
        <actions>
            <name>Deal_Pipeline_Stage</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>OppNumericID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Or(
 Opportunity__r.Opp_Numeric_ID__c &lt;&gt; Opp_Numeric_IDx__c,
Opportunity__r.Pipeline_Stage__c &lt;&gt; Pipeline_Stage__c

)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
