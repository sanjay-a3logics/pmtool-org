<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>EA_State_Approval_Submission_SD</fullName>
        <field>EA_State_Approval_Submission_SD_Parallel__c</field>
        <formula>EA_State_Approval_Submission_SD__c</formula>
        <name>EA State Approval Submission SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EE_Audit</fullName>
        <field>EE_Audit_SD_Parallel__c</field>
        <formula>EE_Audit_SD__c</formula>
        <name>EE Audit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>EE_Audit_Parallel</fullName>
        <field>EE_Audit_ED_Parallel__c</field>
        <formula>EE_Audit_ED__c</formula>
        <name>EE Audit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Electrical_Install_SD</fullName>
        <field>Electrical_Install_SD_Parallel__c</field>
        <formula>Electrical_Install_SD__c</formula>
        <name>Electrical Install SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Feasibility_SD</fullName>
        <field>Feasibility_SD_Parallel__c</field>
        <formula>Feasibility_SD__c</formula>
        <name>Feasibility SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>IU_Approval_Net_Metering</fullName>
        <field>IU_Approval_Net_Metering_ED_Parallel__c</field>
        <formula>Initial_Utility_Approval_Net_Metering_ED__c</formula>
        <name>IU Approval/Net Metering</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Informed_Net_Meter_Installed_Dt_parell</fullName>
        <field>Informed_Net_Meter_Installed_Dt_parellel__c</field>
        <formula>IF( Project__r.RecordType.Name == &apos;PV Install&apos;, Project__r.Informed_Net_Meter_Installed_Date__c , null )</formula>
        <name>Informed Net Meter Installed Dt parell</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Initial_Utility_Approval_Net_Metering_SD</fullName>
        <field>Initial_Utility_Approval_Net_Metering_Pa__c</field>
        <formula>Initial_Utility_Approval_Net_Metering_SD__c</formula>
        <name>Initial Utility Approval/Net Metering SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Inspection_Comp_Wt_Lett_Dt_prll</fullName>
        <field>Inspection_Comp_Wt_Lett_Dt_prll__c</field>
        <formula>IF( Project__r.RecordType.Name == &apos;PV Install&apos;, Project__r.Inspection_Complete_With_Letter_Date__c , null )</formula>
        <name>Inspection Comp Wt Lett Dt prll</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Permitting_SD</fullName>
        <field>Permitting_SD_Parallel__c</field>
        <formula>Permitting_SD__c</formula>
        <name>Permitting SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>R_P_Install_SD</fullName>
        <field>R_P_Install_SD_Parallel__c</field>
        <formula>R_P_Install_SD__c</formula>
        <name>R&amp;P Install SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sales_Order_SD</fullName>
        <field>Sales_Order_SD_Parallel__c</field>
        <formula>Sales_Order_SD__c</formula>
        <name>Sales Order SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>State_Final_Submission_SD</fullName>
        <field>State_Initial_Submission_SD_Parallel__c</field>
        <formula>State_Final_Submission_SD__c</formula>
        <name>State Final Submission SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>State_Final_Submission_SD_parallel</fullName>
        <field>State_Final_Submission_SD_Parallel__c</field>
        <formula>State_Final_Submission_SD__c</formula>
        <name>State Final Submission SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>State_Initial_Submission_SD</fullName>
        <field>State_Initial_Submission_SD_Parallel__c</field>
        <formula>State_Initial_Submission_SD__c</formula>
        <name>State Initial Submission SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_1</fullName>
        <field>PM_Assignment_SDT__c</field>
        <formula>TODAY()</formula>
        <name>TEST 1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_10_Initial_Utility_Approval_Net_MED</fullName>
        <field>Initial_Utility_Approval_Net_MeteringEDT__c</field>
        <formula>Initial_Utility_Approval_Net_Metering_ED__c</formula>
        <name>TEST 10 Initial Utility Approval/Net MED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_10_Municipal_Inspection_ED</fullName>
        <field>Municipal_Inspection_EDT__c</field>
        <formula>Municipal_Inspection_ED__c</formula>
        <name>TEST 10 Municipal Inspection EDT</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_10_R_P_Install_ED</fullName>
        <field>R_P_Install_EDT__c</field>
        <formula>R_P_Install_ED__c</formula>
        <name>TEST 10 R&amp;P Install ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_10_State_Final_Submission_ED</fullName>
        <field>State_Final_Submission_EDT__c</field>
        <formula>State_Final_Submission_ED__c</formula>
        <name>TEST 10 State Final Submission ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_1_EE_AUDIT_SD</fullName>
        <field>EE_Audit_SDT__c</field>
        <formula>EE_Audit_SD__c</formula>
        <name>TEST 1 EE AUDIT SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_1_Electrical_Install_SD</fullName>
        <field>Electrical_Install_SDT__c</field>
        <formula>Electrical_Install_SD__c</formula>
        <name>TEST 1 Electrical Install SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_1_M2_SD</fullName>
        <field>M2_SDT__c</field>
        <formula>M2_SD__c</formula>
        <name>TEST 1 M2 SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_1_State_Initial_Submission_SD</fullName>
        <field>State_Initial_Submission_SDT__c</field>
        <formula>State_Initial_Submission_SD__c</formula>
        <name>TEST 1 State Initial Submission SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_2</fullName>
        <field>PM_Assignment_EDT__c</field>
        <formula>PM_Assignment_ED__c</formula>
        <name>TEST 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_2_EE_Audit_ED</fullName>
        <field>EE_Audit_EDT__c</field>
        <formula>EE_Audit_ED__c</formula>
        <name>TEST 2 EE Audit ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_2_Electrical_Install_ED</fullName>
        <field>Electrical_Install_EDT__c</field>
        <formula>Electrical_Install_ED__c</formula>
        <name>TEST 2 Electrical Install ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_2_M2_ED</fullName>
        <field>M2_EDT__c</field>
        <formula>M2_ED__c</formula>
        <name>TEST 2 M2 ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_2_State_Initial_Submission_ED</fullName>
        <field>State_Initial_Submission_EDT__c</field>
        <formula>State_Initial_Submission_ED__c</formula>
        <name>TEST 2 State Initial Submission ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_3_EA_State_Approval_Submission</fullName>
        <field>EA_State_Approval_Submission_SDT__c</field>
        <formula>EA_State_Approval_Submission_SD__c</formula>
        <name>TEST 3 EA State Approval Submission</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_3_Energy_Upgrade_SD</fullName>
        <field>Energy_Upgrade_SDT__c</field>
        <formula>Energy_Upgrade_SD__c</formula>
        <name>TEST 3 Energy Upgrade SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_3_PTO_Final_Utility_Approval_SD</fullName>
        <field>PTO_Final_Utility_Approval_SDT__c</field>
        <formula>PTO_Final_Utility_Approval_SD__c</formula>
        <name>TEST 3 PTO/Final Utility Approval SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_3_Permitting_SD</fullName>
        <field>Permitting_SDT__c</field>
        <formula>Permitting_SD__c</formula>
        <name>TEST 3 Permitting SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_4_EA_State_Approval_Submission_ED</fullName>
        <field>EA_State_Approval_Submission_EDT__c</field>
        <formula>EA_State_Approval_Submission_ED__c</formula>
        <name>TEST 4 EA State Approval Submission ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_4_Energy_Upgrade_ED</fullName>
        <field>Energy_Upgrade_EDT__c</field>
        <formula>Energy_Upgrade_ED__c</formula>
        <name>TEST 4 Energy Upgrade ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_4_PTO_Final_Utility_Approval_ED</fullName>
        <field>PTO_Final_Utility_Approval_EDT__c</field>
        <formula>PTO_Final_Utility_Approval_ED__c</formula>
        <name>TEST 4 PTO/Final Utility Approval ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_4_Permitting_ED</fullName>
        <field>Permitting_EDT__c</field>
        <formula>Permitting_ED__c</formula>
        <name>TEST 4 Permitting ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_5_Intro_Call_SD</fullName>
        <field>Intro_Call_SDT__c</field>
        <formula>Intro_Call_SD__c</formula>
        <name>TEST 5 Intro Call SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_5_M3_ED</fullName>
        <field>M3_EDT__c</field>
        <formula>M3_ED__c</formula>
        <name>TEST 5 M3 ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_5_M3_SD</fullName>
        <field>M3_SDT__c</field>
        <formula>M3_SD__c</formula>
        <name>TEST 5 M3 SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_5_Quality_Control_SD</fullName>
        <field>Quality_Control_SDT__c</field>
        <formula>Quality_Control_SD__c</formula>
        <name>TEST 5 Quality Control SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_5_Sales_Order_SD</fullName>
        <field>Sales_Order_SDT__c</field>
        <formula>Sales_Order_SD__c</formula>
        <name>TEST 5 Sales Order SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_6_Intro_Call_ED</fullName>
        <field>Intro_Call_EDT__c</field>
        <formula>Intro_Call_ED__c</formula>
        <name>TEST 6 Intro Call ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_6_Quality_Control_ED</fullName>
        <field>Quality_Control_EDT__c</field>
        <formula>Quality_Control_ED__c</formula>
        <name>TEST 6 Quality Control ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_6_Sales_Order_ED</fullName>
        <field>Sales_Order_EDT__c</field>
        <formula>Sales_Order_ED__c</formula>
        <name>TEST 6 Sales Order ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_7_Activation_SD</fullName>
        <field>Activation_SDT__c</field>
        <formula>Activation_SD__c</formula>
        <name>TEST 7 Activation SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_7_Feasibility_SD</fullName>
        <field>Feasibility_SDT__c</field>
        <formula>Feasibility_SD__c</formula>
        <name>TEST 7 Feasibility SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_7_M1_ITC_Funding_SD</fullName>
        <field>M1_ITC_Funding_SDT__c</field>
        <formula>M1_ITC_Funding_SD__c</formula>
        <name>TEST 7 M1/ITC Funding SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_7_Upgrade_Modeling_SD</fullName>
        <field>Upgrade_Modeling_SDT__c</field>
        <formula>Upgrade_Modeling_SD__c</formula>
        <name>TEST 7 Upgrade Modeling SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_8_Activation_ED</fullName>
        <field>Activation_EDT__c</field>
        <formula>Activation_ED__c</formula>
        <name>TEST 8 Activation ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_8_Feasibility_ED</fullName>
        <field>Feasibility_EDT__c</field>
        <formula>Feasibility_ED__c</formula>
        <name>TEST 8 Feasibility ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_8_M1_ITC_Funding_ED</fullName>
        <field>M1_ITC_Funding_EDT__c</field>
        <formula>M1_ITC_Funding_ED__c</formula>
        <name>TEST 8 M1/ITC Funding ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_8_Upgrade_Modeling_ED</fullName>
        <field>Upgrade_Modeling_EDT__c</field>
        <formula>Upgrade_Modeling_ED__c</formula>
        <name>TEST 8 Upgrade Modeling ED</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_9_Initial_Utility_Approval_Net_MeSD</fullName>
        <field>Initial_Utility_Approval_Net_MeteringSDT__c</field>
        <formula>Initial_Utility_Approval_Net_Metering_SD__c</formula>
        <name>TEST 9 Initial Utility Approval/Net MeSD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_9_Municipal_Inspection_SD</fullName>
        <field>Municipal_Inspection_SDT__c</field>
        <formula>Municipal_Inspection_SD__c</formula>
        <name>TEST 9 Municipal Inspection SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_9_R_P_Install_SD</fullName>
        <field>R_P_Install_SDT__c</field>
        <formula>R_P_Install_SD__c</formula>
        <name>TEST 9 R&amp;P Install SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_9_State_Final_Submission_SD</fullName>
        <field>State_Final_Submission_SDT__c</field>
        <formula>State_Final_Submission_SD__c</formula>
        <name>TEST 9 State Final Submission SD</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>TEST_Activation</fullName>
        <field>Activation_DT__c</field>
        <formula>Activation_Date__c</formula>
        <name>TEST Activation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_ED_Parallel</fullName>
        <field>Feasibility_ED_Parallel__c</field>
        <formula>Feasibility_ED__c</formula>
        <name>Update ED Parallel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Record_Type_Parallel_Workflow</fullName>
        <field>Record_Type_Parallel_Workflow__c</field>
        <formula>State__c</formula>
        <name>Update Record Type Parallel Workflow</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upgrade_Modeling_Aging</fullName>
        <field>Upgrade_Modeling_SD_Parallel__c</field>
        <formula>Upgrade_Modeling_SD__c</formula>
        <name>Upgrade Modeling Aging</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Utility_Final_Apprvl_Com_Dt_prll</fullName>
        <field>Utility_Final_Apprvl_Com_Dt_prll__c</field>
        <formula>IF( Project__r.RecordType.Name == &apos;PV Install&apos;, Project__r.Utility_Final_Approval_Completed_Date__c , null )</formula>
        <name>Utility Final Apprvl Com Dt prll</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Utility_Parallel</fullName>
        <field>Utility_Parallel__c</field>
        <formula>Utility__c</formula>
        <name>Utility Parallel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Activation Date update</fullName>
        <actions>
            <name>TEST_Activation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Activation field related dates update</fullName>
        <actions>
            <name>Informed_Net_Meter_Installed_Dt_parell</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Inspection_Comp_Wt_Lett_Dt_prll</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Utility_Final_Apprvl_Com_Dt_prll</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PM_Tool__c.Activation_NA_Override__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Parallel ED fields</fullName>
        <actions>
            <name>EE_Audit_Parallel</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>IU_Approval_Net_Metering</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_ED_Parallel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 ) OR 3</booleanFilter>
        <criteriaItems>
            <field>PM_Tool__c.Feasibility_ED__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.Initial_Utility_Approval_Net_Metering_ED__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.EE_Audit_ED__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Parallel SD fields</fullName>
        <actions>
            <name>EA_State_Approval_Submission_SD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Electrical_Install_SD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Feasibility_SD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Initial_Utility_Approval_Net_Metering_SD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Permitting_SD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>R_P_Install_SD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Sales_Order_SD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>State_Final_Submission_SD_parallel</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>State_Initial_Submission_SD</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Upgrade_Modeling_Aging</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 )OR (3 OR 4) OR (5 OR 6 ) OR (7 OR 8) OR (9 OR 10)</booleanFilter>
        <criteriaItems>
            <field>PM_Tool__c.EA_State_Approval_Submission_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.Feasibility_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.Initial_Utility_Approval_Net_Metering_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.State_Initial_Submission_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.Permitting_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.Sales_Order_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.Upgrade_Modeling_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.R_P_Install_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.Electrical_Install_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>PM_Tool__c.State_Final_Submission_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Parallel SD fields 1</fullName>
        <actions>
            <name>EE_Audit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PM_Tool__c.EE_Audit_SD__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Record type Parallel</fullName>
        <actions>
            <name>Update_Record_Type_Parallel_Workflow</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>PM_Tool__c.Record_Type_Parallel__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Utility Parallel</fullName>
        <actions>
            <name>Utility_Parallel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
