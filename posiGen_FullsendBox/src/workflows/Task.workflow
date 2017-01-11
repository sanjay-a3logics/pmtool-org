<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
    <fieldUpdates>
        <fullName>Disposition_Update</fullName>
        <description>Copy Activity Type to Disposition</description>
        <field>Disposition__c</field>
        <formula>text(Type)</formula>
        <name>Disposition Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Log_Task_Creation_Time</fullName>
        <field>Task_Creation_Time__c</field>
        <formula>NOW()</formula>
        <name>Log Task Creation Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NVM_Dujuane_reassign_from_pool</fullName>
        <field>OwnerId</field>
        <lookupValue>dbrooks2@posigen.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>NVM - Dujuane reassign from pool</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NVM_James_reassign_from_pool</fullName>
        <field>OwnerId</field>
        <lookupValue>jtate@posigen.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>NVM - James reassign from pool</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NVM_Shannon_reassign_from_pool</fullName>
        <field>OwnerId</field>
        <lookupValue>sdouglas@greengrants.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>NVM - Shannon reassign from pool</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NVM_task_Collection</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Collection</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>NVM task - Collection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NVM_task_Concierge</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Concierge</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>NVM task - Concierge</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>NVM_task_Telemarketing</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Telemarketing</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>NVM task - Telemarketing</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Completion_Date_as_Today</fullName>
        <field>Completion_Date__c</field>
        <formula>today()</formula>
        <name>Set Completion Date as Today</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Call_Date_Time</fullName>
        <field xsi:nil="true"/>
        <formula>LastModifiedDate</formula>
        <name>Update Call Date/Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Autopopulate Completion Date</fullName>
        <actions>
            <name>Set_Completion_Date_as_Today</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Disposition Update</fullName>
        <actions>
            <name>Disposition_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Task.Type</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates Disposition field from Activity Type</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>LAyout File</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>equals</operation>
            <value>Notify Customer that: Layout Approval Request</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Log Task Creation Time</fullName>
        <actions>
            <name>Log_Task_Creation_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>NVM - Dujuane reassign from pool</fullName>
        <actions>
            <name>NVM_Dujuane_reassign_from_pool</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(LastModifiedBy.Username = &quot;dbrooks2@posigen.com&quot;,NOT( Owner:User.Username = LastModifiedBy.Username), CreatedBy.Username =&quot;jburse@posigen.com&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>NVM - James reassign from pool</fullName>
        <actions>
            <name>NVM_James_reassign_from_pool</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(LastModifiedBy.Username = &quot;jtate@posigen.com&quot;,NOT( Owner:User.Username = LastModifiedBy.Username), CreatedBy.Username =&quot;jburse@posigen.com&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>NVM - Shannon reassign from pool</fullName>
        <actions>
            <name>NVM_Shannon_reassign_from_pool</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(LastModifiedBy.Username = &quot;sdouglas@greengrants.com&quot;,NOT( Owner:User.Username = LastModifiedBy.Username), CreatedBy.Username =&quot;jburse@posigen.com&quot;)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>NVM task - Collection</fullName>
        <actions>
            <name>NVM_task_Collection</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( Owner:User.Profile.Name = &quot;Billing&quot;,
OR(   ISPICKVAL(CallType, &quot;Inbound&quot;) , ISPICKVAL(CallType, &quot;Outbound&quot;))
)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>NVM task - Concierge</fullName>
        <actions>
            <name>NVM_task_Concierge</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( Owner:User.Profile.Name = &quot;Concierge&quot;,
OR(   ISPICKVAL(CallType, &quot;Inbound&quot;) , ISPICKVAL(CallType, &quot;Outbound&quot;))
)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>NVM task - Telemarketing</fullName>
        <actions>
            <name>NVM_task_Telemarketing</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( 
OR(Owner:User.Profile.Name = &quot;Telemarketer&quot;,Owner:User.Profile.Name = &quot;Telemarketer Plus&quot;,Owner:User.Profile.Name = &quot;Telemarketing Manager&quot;
),
OR(   ISPICKVAL(CallType, &quot;Inbound&quot;) , ISPICKVAL(CallType, &quot;Outbound&quot;))
)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Populate Page 4 Received Date</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Task.Type</field>
            <operation>equals</operation>
            <value>Page 4 Collection</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Task%3A Appointment Kept Is Yes</fullName>
        <actions>
            <name>Update_Call_Date_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Task.Appointment_Kept__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Subject</field>
            <operation>equals</operation>
            <value>Appointment</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
