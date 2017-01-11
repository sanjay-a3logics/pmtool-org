<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Change_Request_Send_Assignee_Email_on_Assign</fullName>
        <description>Change Request - Send Assignee Email on Assign</description>
        <protected>false</protected>
        <recipients>
            <field>Assignee__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Change_Request_Assignee_Notification_Email</template>
    </alerts>
    <alerts>
        <fullName>New_Change_Request_Email</fullName>
        <description>New Change Request Email</description>
        <protected>false</protected>
        <recipients>
            <recipient>sfischer@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>tly@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>xcabo@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/New_Change_Request_Template</template>
    </alerts>
    <alerts>
        <fullName>Notify_Susco</fullName>
        <description>Notify Susco That a CR Estimate is Needed</description>
        <protected>false</protected>
        <recipients>
            <recipient>sfdcsupport@susco.net</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Change_Request_Estimate_Needed</template>
    </alerts>
    <alerts>
        <fullName>Notify_Susco_That_a_CR_Has_Been_Approved</fullName>
        <description>Notify Susco That a CR Has Been Approved</description>
        <protected>false</protected>
        <recipients>
            <recipient>sfdcsupport@susco.net</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>xcabo@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Change_Request_Approved</template>
    </alerts>
    <alerts>
        <fullName>Sends_a_change_request_update_email_to_creator_of_Change_Request_record</fullName>
        <description>Change Request Updated</description>
        <protected>false</protected>
        <recipients>
            <type>creator</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Green_Grants_Email_Templates/Report_Change_Request_Update</template>
    </alerts>
    <fieldUpdates>
        <fullName>Change_Request_Status_Date</fullName>
        <field>Status_Date__c</field>
        <formula>today()</formula>
        <name>Change Request Status Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Deployed_Date_to_Today</fullName>
        <field>Deployed_Date__c</field>
        <formula>Today()</formula>
        <name>Set Deployed Date to Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Change Request Is Deployed</fullName>
        <actions>
            <name>Set_Deployed_Date_to_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Deployed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Request Status Date</fullName>
        <actions>
            <name>Change_Request_Status_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Marks the date of the last status change</description>
        <formula>ISCHANGED( Status__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Email Assignee on Assign</fullName>
        <actions>
            <name>Change_Request_Send_Assignee_Email_on_Assign</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(
NOT( ISBLANK(Assignee__c)),
NOT( Assignee__c =  PRIORVALUE(Assignee__c) )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>New Change Request</fullName>
        <actions>
            <name>New_Change_Request_Email</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Sends an email to Susco administrators when a new Change Request is created.</description>
        <formula>NOT(ISNULL( CreatedDate ))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Notify Change Request Record Creator of Status Update</fullName>
        <actions>
            <name>Sends_a_change_request_update_email_to_creator_of_Change_Request_record</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED(Status__c) &amp;&amp; ISCHANGED(LastModifiedDate)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Notify Susco A CR Estimate is Needed</fullName>
        <actions>
            <name>Notify_Susco</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Estimation</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Notify Susco A CR Has Been Approved</fullName>
        <actions>
            <name>Notify_Susco_That_a_CR_Has_Been_Approved</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Change_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Backlog</value>
        </criteriaItems>
        <criteriaItems>
            <field>Change_Request__c.Technology_Vendor__c</field>
            <operation>equals</operation>
            <value>Susco</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
