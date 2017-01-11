<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Lockout_Project_Cancellation_Alert</fullName>
        <description>Lockout Project Cancellation Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>amashke@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>enewell@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>hgordon@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>wcater@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Lockout_Project_Cancellation</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_Lease_Code_Value_to_Suspended</fullName>
        <field>Lease_Code__c</field>
        <literalValue>Suspended</literalValue>
        <name>Change Lease Code Value to Suspended</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>First_Month_Lease_Delinquentq</fullName>
        <description>When a lease is delinquent on its first payment, change value from False to True</description>
        <field>First_Month_Delinquent__c</field>
        <literalValue>1</literalValue>
        <name>First Month Lease Delinquentq</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_First_Month_Delinquent_Field</fullName>
        <field>First_Month_Delinquent__c</field>
        <literalValue>0</literalValue>
        <name>Update First Month Delinquent Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_LD_Lease_Name_to_Contract_No</fullName>
        <field>Name</field>
        <formula>Contract_No__c</formula>
        <name>Update LD Lease Name to Contract_No</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>First Month Lease Delinquent</fullName>
        <actions>
            <name>First_Month_Lease_Delinquentq</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Days_Delinquent__c  &gt; 30 &amp;&amp;  ( Remaining_Pmts__c  =  Original_Pmts__c )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>First Month Payment Made</fullName>
        <actions>
            <name>Update_First_Month_Delinquent_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LD_Lease__c.Lst_Pmt_Mde_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Lockout Project Cancellation Alert</fullName>
        <actions>
            <name>Lockout_Project_Cancellation_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>LD_Lease__c.Disconnect_Status__c</field>
            <operation>equals</operation>
            <value>Disconnected</value>
        </criteriaItems>
        <criteriaItems>
            <field>LD_Lease__c.Days_Delinquent__c</field>
            <operation>lessOrEqual</operation>
            <value>60</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>On LD Lease Creation</fullName>
        <actions>
            <name>Update_LD_Lease_Name_to_Contract_No</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>On LD Lease Creation</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
