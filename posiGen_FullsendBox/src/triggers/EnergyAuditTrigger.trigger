trigger EnergyAuditTrigger on Energy_Audit__c ( after update) {
    
    Set<String> fields = new Set<String>();
    fields.add('AirFilters_QTY__c');
    fields.add('Air_Attic_Scuttle_Hole_Insulation_EA_QTY__c');
    fields.add('AtticStairTent_QTY__c');
    fields.add('BathroomVent_QTY__c');
    fields.add('CapGasWallHeater_QTY__c');
    fields.add('Cellulose_ElectricHeatSF_QTY__c');
    fields.add('Cellulose_GasHeatSF_QTY__c');
    fields.add('Cellulose_HeatPumpHeatSF_QTY__c');
    fields.add('Cellulose_NoRebateSf_QTY__c');
    fields.add('Air_Close_Chase_and_Fir_Downs_SF_QTY__c');
    fields.add('CODetector_QTY__c');
    fields.add('DHWPipeInsulation_QTY__c');
    fields.add('DryerVentInstall_QTY__c');
    fields.add('DSS1_Seal_Air_Handler_QTY__c');
    fields.add('DSS1_Seal_Ducts_at_Junctions_QTY__c');
    fields.add('DSS1_Seal_Ducts_at_Plenum_QTY__c');
    fields.add('DSS1_Sealing_Return_Chase_QTY__c');
    fields.add('DSS1_Seal_Platform_Mech_Closet_QTY__c');
    fields.add('DSS1_Seal_Plenum_Return_QTY__c');
    fields.add('DSS1_Seal_Plenum_Supply_QTY__c');
    fields.add('DSS1_Strapping_Ducts_QTY__c');
    fields.add('DSS2_Seal_Air_Handler_QTY__c');
    fields.add('DSS2_Seal_Ducts_at_Junctions_QTY__c');
    fields.add('DSS2_Seal_Ducts_at_Plenum_QTY__c');
    fields.add('DSS2_Sealing_Return_Chase_QTY__c');
    fields.add('DSS2_Seal_Platform_Mech_Closet_QTY__c');
    fields.add('DSS2_Seal_Plenum_Return_QTY__c');
    fields.add('DSS2_Seal_Plenum_Supply_QTY__c');
    fields.add('DSS2_Strapping_Ducts_QTY__c');
    fields.add('DSS3_Seal_Air_Handler_QTY__c');
    fields.add('DSS3_Seal_Ducts_at_Junctions_QTY__c');
    fields.add('DSS3_Seal_Ducts_at_Plenum_QTY__c');
    fields.add('DSS3_Sealing_Return_Chase_QTY__c');
    fields.add('DSS3_Seal_Platform_Mech_Closet_QTY__c');
    fields.add('DSS3_Seal_Plenum_Return_QTY__c');
    fields.add('DSS3_Seal_Plenum_Supply_QTY__c');
    fields.add('DSS3_Strapping_Ducts_QTY__c');
    fields.add('ESHeatCoolWindowUnit_QTY__c');
    fields.add('ESWindowUnitCoolAir_QTY__c');
    fields.add('FaucetAerator_QTY__c');
    fields.add('FiberglassBattInsulationSF_QTY__c');
    fields.add('Air_Fireplace_Balloon_EA_QTY__c');
    fields.add('Air_Fireplace_Chase_Sealing_SF_QTY__c');
    fields.add('Air_Fire_Rated_Sealing_LF_QTY__c');
    fields.add('HighLowPipeInstall_QTY__c');
    fields.add('KneewallFiberglassSF_QTY__c');
    fields.add('KneewallFoamboardSF_QTY__c');
    fields.add('LEDCandelabraBulb_QTY__c');
    fields.add('LEDExteriorFloodlight_QTY__c');
    fields.add('LEDIntDimmable60w_QTY__c');
    fields.add('LEDIntNonDimmable60w_QTY__c');
    fields.add('LEDInteriorFloodlight_QTY__c');
    fields.add('LEDRecessedLightInsert_QTY__c');
    fields.add('LowFlowShowerhead_QTY__c');
    fields.add('MakeupAirInstall_QTY__c');
    fields.add('NestThermostatInstall_QTY__c');
    fields.add('OtherMeasures1_QTY__c');
    fields.add('OtherMeasures2_QTY__c');
    fields.add('Air_Recessed_Light_Box_EA_QTY__c');
    fields.add('Air_Sheetrock_Patch_SF_QTY__c');
    fields.add('SmartPowerStripInstall_QTY__c');
    fields.add('Air_Weatherstrip_Doors_QTY__c');
    fields.add('Air_Whole_House_Fan_Cover_EA_QTY__c');
    
    Map<String, Schema.SObjectField> M = Schema.SObjectType.Energy_Audit__c.fields.getMap();

    List<EE_Upgrade__c> eeUpgrades = new List<EE_Upgrade__c>();
    
    Map<String,EE_Upgrade__c> mapEEUpgrade = new Map<String,EE_Upgrade__c>();
    if (trigger.isUpdate) {
        for (EE_Upgrade__c ee: [select id, Energy_Audit__c, Field_API_Name__c  from  EE_Upgrade__c where Energy_Audit__c in: trigger.new]) {
            mapEEUpgrade.put(ee.Energy_Audit__c+'#'+ee.Field_API_Name__c,ee);
        }
    }
    for (Energy_Audit__c ea: trigger.new) {
        for (String field : fields) {
            if(trigger.newmap.get(ea.Id).get(field) != trigger.oldmap.get(ea.Id).get(field) ) { //ea.get(field) != null
                Schema.DescribeFieldResult obj= M.get( field ).getDescribe();
                string val = ea.get(field) +'';
                //string val = ea.get(field);
                system.debug('############'+ mapEEUpgrade + '*******' +    ea.Id+'#'+ field);
                if (mapEEUpgrade.containskey(ea.Id+'#'+ field)) {
                    eeUpgrades.add(new EE_Upgrade__c (id = mapEEUpgrade.get(ea.Id+'#'+ field).Id, Energy_Audit__c = ea.id, Field_Name__c = obj.getLabel(), Field_API_Name__c = field, Value__c = val));        
                }
                else {
                    eeUpgrades.add(new EE_Upgrade__c (Energy_Audit__c = ea.id, Field_Name__c = obj.getLabel(), Field_API_Name__c = field, Value__c = val));
                }
            }
        }
    }
    
    upsert eeUpgrades ;
}