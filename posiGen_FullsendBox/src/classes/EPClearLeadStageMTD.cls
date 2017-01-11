global class EPClearLeadStageMTD implements Database.Batchable<sObject>, Schedulable {
	String query;
	
	/** Database Batchable Methods that need to be implemented **/
	//START METHOD
	global Database.queryLocator start(Database.BatchableContext bc){
		return Database.getQueryLocator(query);
	}
	
	//EXECUTE METHOD
	global void execute(Database.BatchableContext bc, List<Lead> scope) {
         for(Lead l : scope){ 
           l.OPEN_MTD__C = 0; 
           l.APPLICATION_MTD__C = 0; 
           l.SIGNED_MTD__C = 0; 
           l.SUBMITTED_MTD__C = 0; 
           l.APPROVED_MTD__C = 0; 
           l.Assess_Req_MTD__c = 0;
           l.Assessed_Feas_MTD__c = 0;
           l.Closed_MTD__c = 0; 
       } 
        update scope;
	}

	//FINISH METHOD
	global void finish(Database.BatchableContext bc){
		System.debug(LoggingLevel.INFO,'\n\n***** The EPClearLeadStageMTD Batchable class is completed. *****\n\n');
	}
	
	global void execute(SchedulableContext sc){
		String soql = 'SELECT ID, OPEN_MTD__C, APPLICATION_MTD__C, SIGNED_MTD__C, SUBMITTED_MTD__C, APPROVED_MTD__C, Assess_Req_MTD__c, Assessed_Feas_MTD__c, Closed_MTD__c FROM LEAD WHERE (OPEN_MTD__C = 1 OR APPLICATION_MTD__C = 1 OR SIGNED_MTD__C = 1 OR SUBMITTED_MTD__C = 1  OR APPROVED_MTD__C = 1 OR Assess_Req_MTD__c = 1 OR Assessed_Feas_MTD__c = 1 OR Closed_MTD__c = 1) and isConverted=false';
		EPClearLeadStageMTD epClearLS_MTD = new EPClearLeadStageMTD();
		epClearLS_MTD.query = soql;
		Id batchId = Database.executeBatch(epClearLS_MTD);
	}
    
        @isTest(SeeAllData=true)
	static public void testCodeCoverage() {
		Test.startTest();
		//generate leads
		CreateTestUser();
        
		String soql = 'SELECT ID, OPEN_MTD__C, APPLICATION_MTD__C, SIGNED_MTD__C, SUBMITTED_MTD__C, APPROVED_MTD__C, Assess_Req_MTD__c, Assessed_Feas_MTD__c, Closed_MTD__c FROM LEAD WHERE (OPEN_MTD__C = 1 OR APPLICATION_MTD__C = 1 OR SIGNED_MTD__C = 1 OR SUBMITTED_MTD__C = 1  OR APPROVED_MTD__C = 1 OR Assess_Req_MTD__c = 1 OR Assessed_Feas_MTD__c = 1 OR Closed_MTD__c = 1) and isConverted=false LIMIT 200';
		EPClearLeadStageMTD epClearLS_MTD = new EPClearLeadStageMTD();
		epClearLS_MTD.query = soql;
		Id batchId = Database.executeBatch(epClearLS_MTD);
		
		Test.stopTest();
	}
	
	static private void CreateTestUser(){
		List<Lead> testLeads = new List<Lead>();
		for(Integer i = 0; i<200; i++){
			Lead a = new Lead(FirstName='Test',LastName='Test',Street='Mystreet',City='myCity',State='North Carolina',Country='United States',PostalCode='28202',IsConverted=FALSE,Company='Test'+i,Status = 'Open',OPEN_MTD__C = 1,Email='test'+Datetime.now().format('MM-dd-yyyy-hhmmss')+'@test.com');
			testLeads.add(a);
		}
		insert testLeads;
	}
}