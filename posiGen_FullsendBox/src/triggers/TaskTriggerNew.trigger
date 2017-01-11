trigger TaskTriggerNew on Task (after insert, after update, after delete) {

Trigger_Setting__c ts = Trigger_Setting__c.getInstance();

Schema.DescribeSObjectResult r = Deal__c.sObjectType.getDescribe();                 
String dealPrefix = r.getKeyPrefix();


 if(ts.Task_Trigger__c==true){ 
    
    
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete) {
        
        List<String> recordIds = new List<String>();
        for(Task t : (trigger.isDelete? trigger.old : Trigger.new)){
            
            if (t.whatid != null && String.valueOf(t.whatid).substring(0,3)=='006' || 
                String.valueOf(t.whatid).substring(0,3)==dealPrefix) {
                if(t.Type == 'Intro' || t.Type == 'PV Completion/EU Scheduling Call' || 
                t.Type == 'Feasibility Result Call' || t.Type == 'Closing Call'){
                    recordIds.add(t.whatId);
                }
            
            }
            
                
        }
        
        if (recordIds.size() > 0) {
            
            List<Task> tasks = [select id, type, whatId from task t where Successful__c = true and (t.Type = 'Intro' or t.Type = 'PV Completion/EU Scheduling Call' or 
                t.Type = 'Feasibility Result Call' or t.Type = 'Closing Call') and whatId =: recordIds] ;
            
            Map<String, List<Task>> mapTasks = new Map<String, LIst<Task>>();
            for (Task t : tasks) {
                if (!mapTasks.containskey(t.whatId)) {
                    mapTasks.put(t.whatId, new List<task>());
                }
                maptasks.get(t.whatId).add(t);
            }
           
            
            if (recordIds.get(0).startswith('006')){
                List<Opportunity> opps = [select id, Touch_Milestones__c from Opportunity where id in: recordIds];
                for (Opportunity rec: opps) {
                    
                    Set<String> types = new Set<String>();
                    if (maptasks.containskey(rec.id)) {
                        for (task t : maptasks.get(rec.id)) {
                            
                            if (t.type == 'Intro') {
                                t.type = 'Intro Call';
                            }
                            if (!types.contains(t.type)) {
                                types.add(t.type);
                            }
                            
                        }
                    }
                    
                    string stype = '';
                    for (String s : types) {
                        if (stype == '') {
                            stype = s;
                        }
                        else {
                            stype += ';'+s;
                        }
                    }
                    rec.Touch_Milestones__c = stype;
                }
                update opps;
            }
            else {
                List<deal__c> deals = [select id,First_Intro_Call_Made__c,First_Closing_Call_Made__c, Touch_Milestones__c from Deal__c where id in: recordIds];
                for (Deal__c rec: deals) {
                    Set<String> types = new Set<String>();
                    if (maptasks.containskey(rec.id)) {
                        for (task t : maptasks.get(rec.id)) {
                            
                            if (t.type == 'Intro') {
                                t.type = 'Intro Call';
                                rec.First_Intro_Call_Made__c = true;
                            }
                            
                            if (t.type == 'Closing Call') {
                                rec.First_Closing_Call_Made__c = true;
                            }
                            if (!types.contains(t.type)) {
                                types.add(t.type);
                            }
                            
                        }
                    }
                    string stype = '';
                    for (String s : types) {
                        if (stype == '') {
                            stype = s;
                        }
                        else {
                            stype += ';'+s;
                        }
                    }
                    rec.Touch_Milestones__c = stype;
                }
                update deals;
                
            }
        }
        
        
        
        /*
        
        Map<String,Task> mapSuccesfulTasks = new Map<String,Task>();
        Map<String,Task> mapUnSuccesfulTasks = new Map<String,Task>();   
                
        //Map<String,string> mapTaskOpp = new Map<String,string>();
        Set<String> oppIds = new Set<String>();
        Map<String,string> mapOpp = new Map<String,string>();
        if(!Trigger.isDelete){
            for(Task t : Trigger.new){
            
                if (t.whatid != null && String.valueOf(t.whatid).substring(0,3)=='006' || String.valueOf(t.whatid).substring(0,3)==dealPrefix) {
                
                    if (Trigger.isInsert) {
                        if (t.Successful__c) {
                            if (String.valueOf(t.whatid).substring(0,3)=='006' || String.valueOf(t.whatid).substring(0,3)==dealPrefix) {
                                if(t.Type == 'Intro' || t.Type == 'PV Completion/EU Scheduling Call' || t.Type == 'Feasibility Result Call' || t.Type == 'Closing Call'){
                                    mapSuccesfulTasks.put(t.id,t);
                                }
                            }
                        }
                    }
                    else {
                        
                       oppIds.add(t.whatid);
                       
                    }
                }
            }
        }
        
        
        Map<String, List<Task>> mapOppTasks = new Map<String, List<Task>>();
        if (trigger.isUpdate || trigger.isDelete) {
           
            if (trigger.isUpdate){
                for ( Task t : [select id,Successful__c,Type, whatId  from task where whatid in:oppIds
                and Successful__c = true and ( Type = 'Intro' or Type = 'PV Completion/EU Scheduling Call' or Type = 'Feasibility Result Call' or Type = 'Closing Call')]) {
                    if (t.whatid != null && String.valueOf(t.whatid).substring(0,3)=='006' || String.valueOf(t.whatid).substring(0,3)== dealPrefix ) {
                        if (!mapOppTasks.containskey(t.whatId) ){
                                mapOppTasks.put(t.whatId, new List<Task>());
                            }
                        mapOppTasks.get(t.whatId).add(t);    
                        
                        mapSuccesfulTasks.put(t.id,t);
                    }    
                }
            }
            else{
            
                for(Task t : Trigger.old){
                    if (t.whatid != null && String.valueOf(t.whatid).substring(0,3)=='006' 
                    || String.valueOf(t.whatid).substring(0,3)==dealPrefix ) {
                    
                        if(t.Successful__c == true && ( t.Type == 'Intro' || t.Type == 'PV Completion/EU Scheduling Call' || t.Type == 'Feasibility Result Call' || t.Type == 'Closing Call')){
                            mapSuccesfulTasks.put(t.id,t);
                        }
                    }
                }
            }
            
        }
        
        if(Trigger.isInsert){
            for(Task t : Trigger.new){
                mapSuccesfulTasks.put(t.id,t);      
                //system.assert(false, 'tes111t');            
            }
        }
        
        
        List<Opportunity> oppListInsert = new List<Opportunity>();
        for (Task t: mapSuccesfulTasks.values()) {
            mapOpp.put(t.whatid, t.type);
        }
        */
        
        /*
        
        for(Opportunity opp : [select id,name,Touch_Milestones__c from Opportunity where Id in : mapOpp.KeySet() ]){
            string tm = '';  
            if (trigger.isUpdate) {        
            
                for (Task t : mapOppTasks.get(opp.Id)) {
                    
                    
                    if (t.type  == 'Intro') {
                            tm += 'Intro Call' +';' ;
                    }
                    if (t.type == 'Feasibility Result Call') {
                           tm +=  'Feasibility Result Call' +';' ;
                    }
                    if (t.type == 'PV Completion/EU Scheduling Call') {
                            tm +=  'PV Completion/EU Scheduling Call' +';' ;
                    }
                    if (t.type == 'Closing Call') {
                            tm +=  'Closing Call' +';' ;
                    }
                }
                
                string strTm =''; 
                for (String s: tm.split(';')) {
                    if (!strTm.contains(s)) {
                        strTm += s +';';
                    }
                }
            
                opp.Touch_Milestones__c = strTm ;
                
            }
            else if(Trigger.isInsert){    
               //system.assert(false, 'test');
                if (mapOpp.get(opp.id) == 'Intro') {
                    if (opp.Touch_Milestones__c != null) {
                        if (!opp.Touch_Milestones__c.contains('Intro Call'))
                            opp.Touch_Milestones__c = 'Intro Call';
                    }
                    else {
                        opp.Touch_Milestones__c = 'Intro Call';
                    }
                    
                    opp.First_Intro_Call_Made__c = true;
                }
                else if (mapOpp.get(opp.id) == 'Feasibility Result Call') {
                    if (opp.Touch_Milestones__c != null) { 
                        if (!opp.Touch_Milestones__c.contains('Feasibility Result Call'))
                            opp.Touch_Milestones__c = 'Feasibility Result Call';
                    }
                    else {
                         opp.Touch_Milestones__c = 'Feasibility Result Call';
                    }
                }
                if (mapOpp.get(opp.id) == 'PV Completion/EU Scheduling Call') {
                    if(opp.Touch_Milestones__c != null) { 
                        if (!opp.Touch_Milestones__c.contains('PV Completion/EU Scheduling Call'))
                            opp.Touch_Milestones__c = 'PV Completion/EU Scheduling Call';
                    }
                    else {
                        opp.Touch_Milestones__c = 'PV Completion/EU Scheduling Call';
                    }
                }
                if (mapOpp.get(opp.id) == 'Closing Call') {
                    
                    if(opp.Touch_Milestones__c != null) { 
                        if (!opp.Touch_Milestones__c.contains('Closing Call'))
                            opp.Touch_Milestones__c = 'Closing Call';
                    }
                    else { 
                          
                        opp.Touch_Milestones__c = 'Closing Call';
                    }
                }
           }
           
           if (trigger.isDelete) {
                
                String tmToDelete = '';
                for (Task t : Trigger.old) {
                    
                    if (t.type  == 'Intro') {
                            tmToDelete += 'Intro Call';
                    }
                    if (t.type == 'Feasibility Result Call') {
                           tmToDelete +=  'Feasibility Result Call';
                    }
                    if (t.type == 'PV Completion/EU Scheduling Call') {
                            tmToDelete +=  'PV Completion/EU Scheduling Call';
                    }
                    if (t.type == 'Closing Call') {
                            tmToDelete +=  'Closing Call';
                    }
                    
                    opp.Touch_Milestones__c =  opp.Touch_Milestones__c.remove(tmToDelete);

                }
                
              
                
             }
            
            if(Trigger.isInsert){
                
                if (mapOpp.get(opp.id) == 'Intro') {
                    opp.First_Intro_Call_Made__c = true;
                }
                if (mapOpp.get(opp.id) == 'Closing Call') {
                    opp.First_Closing_Call_Made__c = true;
                }
                
            } 

            
            oppListInsert.add(opp);
        }
        
        if(oppListInsert.size() > 0){
            update oppListInsert;
        }
        */
    }
    
 }

}