<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Packet_Rejection_Notificaiton</fullName>
        <description>Packet Rejection Notificaiton</description>
        <protected>false</protected>
        <recipients>
            <field>Opp_Owner__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Sales_Admin__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Auto_Emails/Packet_Rejection</template>
    </alerts>
</Workflow>
