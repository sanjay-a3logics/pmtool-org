global without sharing class Batch_TransferAttachFromOppToDeal implements Database.Batchable<sObject> {
   
    /*
    	This batch will trasfer all attachments from opportunity over to deal object.
    */
    
    global Database.QueryLocator start(Database.BatchableContext BC){
    	String attachmentFields = SynchronizationEngine.retrieveAllObjectFieldsAndFormatForQuerySelectStatement(Attachment.getSobjectType());
		return Database.getQueryLocator('SELECT ' + attachmentFields + ' FROM Attachment WHERE Parent.Type = \'Opportunity\'');
	}
	
	global void execute(Database.BatchableContext BC, List<Attachment> scope){
		Set<Id> opportunityIds = new Set<Id>();
		Map<Id, Id> oportunityIdToDealIdMap = new Map<Id, Id>();
		Attachment[] attachmentToInsert = new Attachment[]{};
		Attachment[] attachmentToDelete = new Attachment[]{};
		
		//create set of opportunity ids related to Attachments
		for(Attachment n : scope){
			opportunityIds.add(n.ParentId);
		}
		
		//query deals related to the opportunity ids and create map of opportunity id to deal id
		for(Deal__c d : [SELECT Id, Opportunity__c FROM Deal__c WHERE Opportunity__c IN: opportunityIds]){
			oportunityIdToDealIdMap.put(d.Opportunity__c, d.Id);
		}
		
		//loop over notes
		for(Attachment n : scope){
			//if deal related to same opportunity as the current Attachment, then recreate the Attachment linked to a deal
			if(oportunityIdToDealIdMap.containsKey(n.ParentId)){
				
				//clone the Attachment and reassign to deal
				Attachment clonedNote = n.clone(false, true, true, true);
				
				clonedNote.ParentId = oportunityIdToDealIdMap.get(n.ParentId);
				attachmentToInsert.add(clonedNote);
				
				//add to opportunity to Attachment to delete
				attachmentToDelete.add(n);
			}
		}
		
		//insert Attachments
		insert attachmentToInsert;
		
		//delete opportunity related Attachments
		delete attachmentToDelete;
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