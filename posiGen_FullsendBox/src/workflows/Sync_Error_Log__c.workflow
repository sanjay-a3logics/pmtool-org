<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>New_Sync_Error_Alert</fullName>
        <description>New Sync Error Alert</description>
        <protected>false</protected>
        <recipients>
            <recipient>posigensupport@salesforcesuperheroes.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sfischer@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>xcabo@posigen.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Sync_Engine_Error_Log</template>
    </alerts>
    <rules>
        <fullName>New Sync Error Alert</fullName>
        <actions>
            <name>New_Sync_Error_Alert</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
