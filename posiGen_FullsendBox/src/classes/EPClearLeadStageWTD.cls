global class EPClearLeadStageWTD implements Database.Batchable<sObject>, Schedulable {
	String query;
	
	/** Database Batchable Methods that need to be implemented **/
	//START METHOD
	global Database.queryLocator start(Database.BatchableContext bc){
		return Database.getQueryLocator(query);
	}
	
	//EXECUTE METHOD
	global void execute(Database.BatchableContext bc, List<Lead> scope) {
         for(Lead l : scope){ 
           l.OPEN_WTD__C = 0; 
           l.APPLICATION_WTD__C = 0; 
           l.SIGNED_WTD__C = 0; 
           l.SUBMITTED_WTD__C = 0; 
           l.APPROVED_WTD__C = 0;
           l.Assess_Req_WTD__c = 0;
           l.Assessed_Feas_WTD__c = 0;
           l.Closed_WTD__c = 0; 
       } 
        update scope;
	}

	//FINISH METHOD
	global void finish(Database.BatchableContext bc){
		System.debug(LoggingLevel.INFO,'\n\n***** The EPClearLeadStageWTD Batchable class is completed. *****\n\n');
	}
	
	global void execute(SchedulableContext sc){
		String soql = 'SELECT ID, OPEN_WTD__C, APPLICATION_WTD__C, SIGNED_WTD__C, SUBMITTED_WTD__C, APPROVED_WTD__C, Assess_Req_WTD__c, Assessed_Feas_WTD__c, Closed_WTD__c FROM LEAD WHERE (OPEN_WTD__C = 1 OR APPLICATION_WTD__C = 1 OR SIGNED_WTD__C = 1 OR SUBMITTED_WTD__C = 1  OR APPROVED_WTD__C = 1  OR Assess_Req_WTD__c = 1 OR Assessed_Feas_WTD__c = 1 OR Closed_WTD__c = 1) AND ISCONVERTED=FALSE';
		EPClearLeadStageWTD epClearLS_WTD = new EPClearLeadStageWTD();
		epClearLS_WTD.query = soql;
		Id batchId = Database.executeBatch(epClearLS_WTD);
	}
    
        @isTest(SeeAllData=true)
	static public void testCodeCoverage() {
		Test.startTest();
		//generate leads
		CreateTestUser();
        
		String soql = 'SELECT ID, OPEN_WTD__C, APPLICATION_WTD__C, SIGNED_WTD__C, SUBMITTED_WTD__C, APPROVED_WTD__C, Assess_Req_WTD__c, Assessed_Feas_WTD__c, Closed_WTD__c FROM LEAD WHERE (OPEN_WTD__C = 1 OR APPLICATION_WTD__C = 1 OR SIGNED_WTD__C = 1 OR SUBMITTED_WTD__C = 1  OR APPROVED_WTD__C = 1  OR Assess_Req_WTD__c = 1 OR Assessed_Feas_WTD__c = 1 OR Closed_WTD__c = 1) AND ISCONVERTED=FALSE LIMIT 200';
		EPClearLeadStageWTD epClearLS_WTD = new EPClearLeadStageWTD();
		epClearLS_WTD.query = soql;
		Id batchId = Database.executeBatch(epClearLS_WTD);
		
		Test.stopTest();
	}
	
		//only called from testCodeCoverage
		static private void CreateTestUser(){
		List<Lead> testLeads = new List<Lead>();
		for(Integer i = 0; i<200; i++){
			Lead a = new Lead(FirstName='Test',LastName='Test',Street='Mystreet',City='myCity',State='North Carolina',Country='United States',PostalCode='28202',IsConverted=FALSE,Company='Test'+i,Status = 'Open',OPEN_MTD__C = 1,Email='test'+Datetime.now().format('MM-dd-yyyy-hhmmss')+'@test.com');
			testLeads.add(a);
		}
		insert testLeads;
	}
}