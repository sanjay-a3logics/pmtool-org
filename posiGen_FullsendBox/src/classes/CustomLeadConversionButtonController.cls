public without sharing class CustomLeadConversionButtonController {
    /*
    	The purpose of this class is to perform the lead conversion process through custom code in order to allow platform users to convert leads.
    	
    	Notes:
    		-Need to add logic to prevent lead conversion from ocurring more than once on a single lead, thus generating dupe records.
    	
    	
    	1.) logic to prevent dupe lead conversions. using the isvonceted checkbox
    	2.) logic for transferring activities
    	
    		
    */
    
    public boolean redirectToDeal {get; set;}
    public Id dealId {get; set;}
    public String baseURL {get; set;}
    private Prospect__c prospect;

	public CustomLeadConversionButtonController(ApexPages.StandardController stdController){
		this.prospect = (Prospect__c)stdController.getRecord();
		
		prospect = [SELECT Id, Lead__c FROM Prospect__c WHERE Id =: prospect.Id];
		
		redirectToDeal = false;
		baseURL = URL.getSalesforceBaseUrl().toExternalForm();
	}
	
	public void performLeadConversion(){
		Deal__c[] queriedDeal = new Deal__c[]{};
		Savepoint sp = Database.setSavepoint();
		
		try{
			if(prospect.Lead__c != null){
				//query lead
				Lead l = [SELECT Id, IsConverted FROM Lead WHERE Id =: prospect.Lead__c];
				
				if(l.IsConverted != true){
					//create lead convert object and set the lead that will be converted
					Database.LeadConvert lc = new Database.LeadConvert();
					lc.setLeadId(l.id);
					
					//get the converted lead status and set the converted status on the leadconvert object
					LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true AND MasterLabel =: 'Qualified' limit 1];
					lc.setConvertedStatus(convertStatus.MasterLabel);
					
					//perform lead conversion
					Database.LeadConvertResult lcr = Database.convertLead(lc);
					system.assert(lcr.isSuccess());
					
					//query deal related to opportunity
					queriedDeal = [SELECT Id FROM Deal__c WHERE Opportunity__c =: lcr.getOpportunityId()];
					system.assertNotEquals(0, queriedDeal.size(), 'Deal failed to be created on insertion of Opportunity.');
					
					//transfer activites on prospect over to account and opportunity
					transferProspectActivitiesToContactAndOpportunityAfterLeadConversion(lcr.getContactId(), queriedDeal[0].Id);
					
					//redirect to deal
					redirectToDeal = true;
					dealId = queriedDeal[0].Id;
					
					/*//testing...show this stuff on page
					String accountUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/' + lcr.getAccountId();
					String oppUrl = URL.getSalesforceBaseUrl().toExternalForm() + '/' + lcr.getOpportunityId();
					String myMsg = 'Lead conversion complete. Link to Account: ' + accountUrl + '\r\n' + ' Link to Opportunity: ' + oppUrl;
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, myMsg));*/
				}
				else{
					ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Lead has already been converted.'));
				}
			}
			else{
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, 'Lead Conversion Failed. Prospect not linked to a lead.'));
			}
		}
		catch(Exception e){
			//rollback changes
			Database.rollback(sp);
			redirectToDeal = false;
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.FATAL, e.getMessage() + e.getStackTraceString()));
		}
	}
	
	private void transferProspectActivitiesToContactAndOpportunityAfterLeadConversion(Id contactId, Id dId){
		Task[] queriedTasks = new Task[]{};
		Event[] queriedEvents = new Event[]{};
		Task[] tasksToUpdate = new Task[]{};
		Event[] eventsToUpdate = new Event[]{};
		
		//query tasks
		queriedTasks = [SELECT Id, WhoId, WhatId FROM Task WHERE WhatId =: prospect.Id];
		
		//query events
		queriedEvents = [SELECT Id, WhoId, WhatId FROM Event WHERE WhatId =: prospect.Id];
		
		//loop over tasks
		for(Task t : queriedTasks){
			//set whatId to opp and whoid to contact
			t.WhoId = contactId;
			t.WhatId = dId;
			tasksToUpdate.add(t);
		}
		
		//loop over events
		for(Event e : queriedEvents){
			//set whatId to opp and whoid to contact
			e.WhoId = contactId;
			e.WhatId = dId;
			eventsToUpdate.add(e);
		}
		
		//update tasks and events
		update tasksToUpdate;
		update eventsToUpdate;
	}
}