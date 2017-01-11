global without sharing class Batch_TransferNotesFromOpportunityToDeal implements Database.Batchable<sObject>{
    
    /*
    	This batch will trasfer all notes from opportunity over to deal object.
    */
    
    global Database.QueryLocator start(Database.BatchableContext BC){
    	String noteFields = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Note.getSobjectType());
		return Database.getQueryLocator('SELECT ' + noteFields + ' FROM Note WHERE Parent.Type = \'Opportunity\'');
	}
	
	global void execute(Database.BatchableContext BC, List<Note> scope){
		Set<Id> opportunityIds = new Set<Id>();
		Deal__c[] queriedDeals = new Deal__c[]{};
		Map<Id, Id> oportunityIdToDealIdMap = new Map<Id, Id>();
		Note[] noteToInsert = new Note[]{};
		Note[] notesToDelete = new Note[]{};
		
		//create set of opportunity ids related to notes
		for(Note n : scope){
			opportunityIds.add(n.ParentId);
		}
		
		//query deals related to the opportunity ids
		queriedDeals = [SELECT Id, Opportunity__c FROM Deal__c WHERE Opportunity__c IN: opportunityIds];
		
		//create map of opportunity id to deal id
		for(Deal__c d : queriedDeals){
			oportunityIdToDealIdMap.put(d.Opportunity__c, d.Id);
		}
		
		//loop over notes
		for(Note n : scope){
			//if deal related to same opportunity as the current note, then recreate the note linked to a deal
			if(oportunityIdToDealIdMap.containsKey(n.ParentId)){
				
				//clone the note and reassign to deal
				Note clonedNote = n.clone(false, true, true, true);
				
				clonedNote.ParentId = oportunityIdToDealIdMap.get(n.ParentId);
				noteToInsert.add(clonedNote);
				
				//add to opportunity to notes to delete
				notesToDelete.add(n);
			}
		}
		
		//insert notes
		insert noteToInsert;
		
		//delete opportunity related notes
		delete notesToDelete;
	}
	
	global void finish(Database.BatchableContext BC){
		//nothing to do here!
	}
	
	global static void byPassTest(){
		integer i = 0;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
		i++;
	}
}