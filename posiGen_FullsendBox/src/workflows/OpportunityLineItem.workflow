<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Change_Qty_to_2</fullName>
        <field>Quantity</field>
        <formula>2</formula>
        <name>Change Qty to 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quantity_for_Optimizer_is_22</fullName>
        <field>Quantity</field>
        <formula>22</formula>
        <name>Quantity for Optimizer is 22</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quantity_for_Optimizer_is_24</fullName>
        <field>Quantity</field>
        <formula>24</formula>
        <name>Quantity for Optimizer is 24</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quantity_for_Panels_is_22</fullName>
        <field>Quantity</field>
        <formula>22</formula>
        <name>Quantity for Panels is 22</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quantity_for_Panels_is_23</fullName>
        <field>Quantity</field>
        <formula>23</formula>
        <name>Quantity for Panels is 23</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quantity_for_Rails_is_12</fullName>
        <field>Quantity</field>
        <formula>12</formula>
        <name>Quantity for Rails is 12</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quantity_for_Rails_is_13</fullName>
        <field>Quantity</field>
        <formula>13</formula>
        <name>Quantity for Rails is 13</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Quantity_for_Splice_Connector_is_8</fullName>
        <field>Quantity</field>
        <formula>8</formula>
        <name>Quantity for Splice Connector is 8</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Cable_Clip_Qty_to_50</fullName>
        <field>Quantity</field>
        <formula>50</formula>
        <name>Update Cable Clip Qty to 50</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_L_Foot_Assembly_Quantity</fullName>
        <field>Quantity</field>
        <formula>40</formula>
        <name>Update L-Foot Assembly Quantity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Qty_to_0</fullName>
        <field>Quantity</field>
        <formula>0</formula>
        <name>Update Qty to 0</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Qty_to_12</fullName>
        <field>Quantity</field>
        <formula>12</formula>
        <name>Update Qty to 12</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Qty_to_4</fullName>
        <field>Quantity</field>
        <formula>4</formula>
        <name>Update Qty to 4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Qty_to_48</fullName>
        <field>Quantity</field>
        <formula>48</formula>
        <name>Update Qty to 48</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Qty_to_5</fullName>
        <field>Quantity</field>
        <formula>5</formula>
        <name>Update Qty to 5</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Quantity_to_24_for_Panels</fullName>
        <field>Quantity</field>
        <formula>24</formula>
        <name>Update Quantity to 24 for Panels</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Product is Cable Clip</fullName>
        <actions>
            <name>Update_Cable_Clip_Qty_to_50</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Cable Clip</value>
        </criteriaItems>
        <description>Sets the quantity of the cable clip to 50</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Hyundai 250W Black Panel</fullName>
        <actions>
            <name>Update_Quantity_to_24_for_Panels</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Hyundai 250W Blk</value>
        </criteriaItems>
        <description>Sets the quantity of the Hyundai panels to 24.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Hyundai 250W Poly Panel</fullName>
        <actions>
            <name>Update_Quantity_to_24_for_Panels</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Hyundai 250W</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is L-foot Assembly</fullName>
        <actions>
            <name>Update_L_Foot_Assembly_Quantity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Lfoot</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Lfoot Eco</fullName>
        <actions>
            <name>Update_Qty_to_48</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>LFoot Eco</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is MC4</fullName>
        <actions>
            <name>Update_Qty_to_4</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>MC4 Female</value>
        </criteriaItems>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>MC4 Male</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Mitsubishi 265W Panels</fullName>
        <actions>
            <name>Quantity_for_Panels_is_23</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Mitsu 265W</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Mitsubishi 270W Panels</fullName>
        <actions>
            <name>Quantity_for_Panels_is_22</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Mitsu 270W</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Mounting Rails and Hyundai</fullName>
        <actions>
            <name>Quantity_for_Rails_is_12</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Rail</value>
        </criteriaItems>
        <criteriaItems>
            <field>PricebookEntry.Pricebook2Id</field>
            <operation>contains</operation>
            <value>Hyundai</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Mounting Rails and Mitsubishi</fullName>
        <actions>
            <name>Quantity_for_Rails_is_13</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Rail</value>
        </criteriaItems>
        <criteriaItems>
            <field>PricebookEntry.Pricebook2Id</field>
            <operation>contains</operation>
            <value>Mitsubishi</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Optimizer and Hyundai</fullName>
        <actions>
            <name>Quantity_for_Optimizer_is_24</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>SE Optimizer</value>
        </criteriaItems>
        <criteriaItems>
            <field>PricebookEntry.Pricebook2Id</field>
            <operation>contains</operation>
            <value>Hyundai</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Optimizer and Mitsubishi</fullName>
        <actions>
            <name>Quantity_for_Optimizer_is_22</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>SE Optimizer</value>
        </criteriaItems>
        <criteriaItems>
            <field>PricebookEntry.Pricebook2Id</field>
            <operation>contains</operation>
            <value>Hyundai,Silfab</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Rail 168</fullName>
        <actions>
            <name>Update_Qty_to_12</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Rail 168</value>
        </criteriaItems>
        <description>Set Rail 168 quantity to 12</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Splice Connector</fullName>
        <actions>
            <name>Quantity_for_Splice_Connector_is_8</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Splice Connector</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Product is Water Tight Seal</fullName>
        <actions>
            <name>Update_Qty_to_5</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>Water Tight Seal</value>
        </criteriaItems>
        <description>Sets the quantity of the water tight seal to 5</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Set Product Qty to 2</fullName>
        <actions>
            <name>Change_Qty_to_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3 OR 4) AND 5</booleanFilter>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>REN106</value>
        </criteriaItems>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>REN107</value>
        </criteriaItems>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>2G Box</value>
        </criteriaItems>
        <criteriaItems>
            <field>OpportunityLineItem.ProductCode</field>
            <operation>equals</operation>
            <value>2G Blank</value>
        </criteriaItems>
        <criteriaItems>
            <field>PricebookEntry.Pricebook2Id</field>
            <operation>contains</operation>
            <value>Renusol</value>
        </criteriaItems>
        <description>Set product quantity to 2 for 2G Blank, 2G Box, REN107, and REN106</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
