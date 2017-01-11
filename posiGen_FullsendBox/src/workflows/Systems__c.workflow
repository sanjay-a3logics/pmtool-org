<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>System_Reservation_Alert</fullName>
        <description>System Reservation Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>cburnham@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cfitzgerald@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jschouest@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mmann@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/System_Has_Been_Reserved</template>
    </alerts>
    <alerts>
        <fullName>System_Reservation_Ended_Alert</fullName>
        <description>System Reservation Ended Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>cburnham@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>cmerritt@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>fweathersby@greengrants.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>jschouest@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>kmitchell@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>nicholasv@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/System_Reservation_Ended</template>
    </alerts>
    <fieldUpdates>
        <fullName>Cancel_System_Reservation</fullName>
        <field>Reserve_This_System__c</field>
        <literalValue>0</literalValue>
        <name>Cancel System Reservation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Install_Project_Text</fullName>
        <field>Project_Text__c</field>
        <formula>Install_Project_Created_On__r.Name</formula>
        <name>Install Project Text</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reservation_Date</fullName>
        <field>Reservation_Date__c</field>
        <formula>Today()</formula>
        <name>Reservation Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reserved_By</fullName>
        <field>Reserved_By__c</field>
        <formula>$User.FirstName  &amp; &quot; &quot; &amp; $User.LastName</formula>
        <name>Reserved By</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Cancel System Reservation</fullName>
        <active>false</active>
        <formula>Reserve_This_System__c  = TRUE</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>System_Reservation_Ended_Alert</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Cancel_System_Reservation</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Project Text</fullName>
        <actions>
            <name>Install_Project_Text</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Install_Project_Created_On__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>System Reservation</fullName>
        <actions>
            <name>Reservation_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Reserved_By</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Systems__c.Reserve_This_System__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Autopopulate the Reserved By and Reservation Date fields</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>System Reservation Alert</fullName>
        <actions>
            <name>System_Reservation_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Systems__c.Reserve_This_System__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
