trigger UpdateOppFromPVInstall on Project__c (after update) {
    Trigger_Setting__c ts= Trigger_Setting__c.getInstance();
    if(!ts.Project_Trigger__c){     
        Map<Id,Recordtype> mapRecordtype = new Map<Id,Recordtype>([select id, name from recordtype where sobjecttype = 'Project__c']);
        Map<Id,String> mapProjectOpportunity = new Map<Id,String>();
        for(Project__c p: Trigger.New) {
            if (mapRecordtype.get(p.recordtypeId).name == 'PV Install'||mapRecordtype.get(p.recordtypeId).name == 'PV Feasibility') {
                mapProjectOpportunity.put(p.id,p.Opportunity__c);
            }
        
        }
        
        if (mapProjectOpportunity.size() > 0) {
            List<Project__c> projsWithSavings = [SELECT Id, PVI_Placed_In_Service_Date__c,
                         PVI_Rails_and_Panels_Left_Warehouse_Date__c, 
                         PVI_Electrical_Installed_Date__c, 
                         PVI_Electrical_Left_Warehouse_Date__c,
                         PV_Net_Meter_Install_Verified_Date__c,
                         Final_3rd_Party_Inspection_Compete_Date__c,
                         PVI_Rails_Installed_Date__c,
                         PVI_Panels_Installed_Date__c,
                         Gross_System_Cost_In_Dollars__c,
                         Billing_Packet_Approved_Date__c,
                         PVI_Activation_Date__c,
                         Opportunity__c, Opportunity__r.Id 
                         FROM Project__c WHERE (Project__c.Record_Type_Name__c
                         LIKE '%PV%Install%' OR Project__c.Record_Type_Name__c LIKE '%PV%Feasibility%') 
                         AND Opportunity__c IN :mapProjectOpportunity.values() order by createddate desc limit 1];
                         
             if (projsWithSavings.size() > 0) {
                for(Project__c prj: Trigger.New) {
                    if (mapProjectOpportunity.containskey(projsWithSavings[0].id)){
                       List<Opportunity> oppsToUpdate = new List<Opportunity>{};  
                         for(Project__c p: projsWithSavings)
                          {    
                                    Opportunity o = p.Opportunity__r;
                                    
                                    
                                        o.PVI_Placed_In_Service_Date__c = p.PVI_Placed_In_Service_Date__c;
                                    
                                    
                                        o.PVI_Rails_and_Panels_Left_WH_Date__c = p.PVI_Rails_and_Panels_Left_Warehouse_Date__c;
                                    
                                        o.PVI_Electrical_Installed_Date__c = p.PVI_Electrical_Installed_Date__c;
                                    
                                    
                                        o.PVI_Electric_Left_WH_Date__c = p.PVI_Electrical_Left_Warehouse_Date__c;
                                    
                                    
                                        o.PVI_Net_Meter_Install_Date__c = p.PV_Net_Meter_Install_Verified_Date__c;
                                   
                                    
                                        o.Final_3rd_Party_Inspection_Compete_Date__c = p.Final_3rd_Party_Inspection_Compete_Date__c;
                                    
                                    
                                        o.PVI_Rails_Installed_Date__c = p.PVI_Rails_Installed_Date__c;
                                    
                                    
                                        o.PVI_Panels_Installed_Date__c = p.PVI_Panels_Installed_Date__c;
                                    
                                        o.Gross_System_Cost_in_Dollars__c = p.Gross_System_Cost_in_Dollars__c;
                                    
                                        o.Billing_Packet_Approved_Date__c = p.Billing_Packet_Approved_Date__c;
                                    
                                        o.PVI_Activation_Date__c = p.PVI_Activation_Date__c;
                                    
                                        oppsToUpdate.add(o);
                                }
                             update oppsToUpdate;
                        }
                    
                  }         
             }
        }
        
    
    }
    
    
}