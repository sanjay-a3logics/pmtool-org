@isTest
private class EnergyAuditTriggerTest {
    static testMethod void unitTest(){
        Energy_Audit__c energyAudit = new Energy_Audit__c();
        energyAudit.Air_Attic_Scuttle_Hole_Insulation_EA_QTY__c = 2;
        energyAudit.AirFilters_QTY__c = 3;
        insert energyAudit;
        system.assert(energyAudit.id != null);
        
        EE_Upgrade__c eeUpgrade = new EE_Upgrade__c();
        eeUpgrade.Energy_Audit__c =  energyAudit.id;
        eeUpgrade.Field_Api_Name__c = 'AirFilters_QTY__c';
        insert eeUpgrade;
        system.assert(eeUpgrade.id != null);
        
        energyAudit.AirFilters_QTY__c = 2;
        energyAudit.Air_Attic_Scuttle_Hole_Insulation_EA_QTY__c = 3;
        update energyAudit;
        
    }
}