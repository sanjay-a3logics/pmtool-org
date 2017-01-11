<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Electric_Reduction_Savings_Mirror</fullName>
        <field>Electric_Reduction_Savings_kWh_Mirror__c</field>
        <formula>Electric_Reduction_Savings_kWh__c</formula>
        <name>Electric Reduction Savings Mirror</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Energy_Audit_Recalculate_to_TRUE</fullName>
        <field>Recalculate__c</field>
        <literalValue>1</literalValue>
        <name>Energy Audit Recalculate to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Gas_Reduction_Mirror</fullName>
        <field>Gas_Reduction_Mirror__c</field>
        <formula>Gas_ReductionThermsEquivalent__c</formula>
        <name>Gas Reduction Mirror</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Insulation_Table_Value_Update</fullName>
        <field>Insulation_kWh_Table_Result__c</field>
        <formula>If(RRng__c&lt;1,CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,1.11, 
&quot;Central/elect resist&quot;,5.56, 
&quot;Central/Heat Pump&quot;,2.65, 
&quot;Electric Space&quot;,5.56, 
&quot;Gas space&quot;,1.11, 
&quot;Room AC W/elec heat&quot;,5.56, 
0),
If(AND(RRng__c&gt;=1,RRng__c&lt;4.5),CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.72, 
&quot;Central/elect resist&quot;,3.52, 
&quot;Central/Heat Pump&quot;,1.74, 
&quot;Electric Space&quot;,3.52, 
&quot;Gas space&quot;,0.72, 
&quot;Room AC W/elec heat&quot;,3.52, 
0),
If(AND(RRng__c&gt;=4.5,RRng__c&lt;8.5),CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.36, 
&quot;Central/elect resist&quot;,1.77, 
&quot;Central/Heat Pump&quot;,0.87, 
&quot;Electric Space&quot;,1.77, 
&quot;Gas space&quot;,0.36, 
&quot;Room AC W/elec heat&quot;,1.77,
0),
If(AND(RRng__c&gt;=8.5,RRng__c&lt;14.5),CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.19, 
&quot;Central/elect resist&quot;,0.93, 
&quot;Central/Heat Pump&quot;,0.45, 
&quot;Electric Space&quot;,0.93, 
&quot;Gas space&quot;,0.19, 
&quot;Room AC W/elec heat&quot;,0.93,
0),
If(AND(RRng__c&gt;=14.5,RRng__c&lt;=22),CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.08, 
&quot;Central/elect resist&quot;,0.39, 
&quot;Central/Heat Pump&quot;,0.19, 
&quot;Electric Space&quot;,0.39, 
&quot;Gas space&quot;,0.08, 
&quot;Room AC W/elec heat&quot;,0.39,
0),
0)))))</formula>
        <name>Insulation Table Value Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Insulation_Therms_Value</fullName>
        <field>Insulation_Therms_Value__c</field>
        <formula>If(RRng__c&lt;1,CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.042, 
&quot;Gas space&quot;,0.042, 
0),
If(AND(RRng__c&gt;=1,RRng__c&lt;4.5),CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.030, 
&quot;Gas space&quot;,0.030, 
0),
If(AND(RRng__c&gt;=4.5,RRng__c&lt;8.5),CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.012, 
&quot;Gas space&quot;,0.012, 
0),
If(AND(RRng__c&gt;=8.5,RRng__c&lt;14.5),CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.010, 
&quot;Gas space&quot;,0.010, 
0),
If(AND(RRng__c&gt;=14.5,RRng__c&lt;=22),CASE(TEXT(HVAC_S1_Heating_Type__c), 
&quot;Central /gas&quot;,0.005, 
&quot;Gas space&quot;,0.005, 
0),
0)))))</formula>
        <name>Insulation Therms Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Recalculate_to_false</fullName>
        <field>Recalculate__c</field>
        <literalValue>0</literalValue>
        <name>Recalculate to false</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>X59_minutes_ago</fullName>
        <field>Hacktime__c</field>
        <formula>NOW() - 0.04097222222</formula>
        <name>59 minutes ago</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Electric Reduction Savings Mirror</fullName>
        <actions>
            <name>Electric_Reduction_Savings_Mirror</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Electric_Reduction_Savings_kWh__c &lt;&gt; Electric_Reduction_Savings_kWh_Mirror__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Energy Audit Recalculate</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Energy_Audit__c.Recalculate__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Hack to finish calculations via workflow</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Recalculate_to_false</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Energy_Audit__c.Hacktime__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Gas Reduction Mirror</fullName>
        <actions>
            <name>Gas_Reduction_Mirror</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>Gas_Reduction_Mirror__c &lt;&gt; Gas_ReductionThermsEquivalent__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Insulation kWh Table Calculation</fullName>
        <actions>
            <name>Electric_Reduction_Savings_Mirror</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Energy_Audit_Recalculate_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Gas_Reduction_Mirror</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Insulation_Table_Value_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Insulation_Therms_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>X59_minutes_ago</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
