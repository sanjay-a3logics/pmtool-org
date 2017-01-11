public class TestHouseUtilities {
    
    public Account 		testAccount 		{get; set;}
    public Opportunity	testOpp				{get; set;}
    public Attachment 	testAttachment		{get; set;}
    
    public void generateOpp()
    {
        Intacct_Entity__c testIntacctEntity = new Intacct_Entity__c(Name = 'PG of LA');
        insert testIntacctEntity;
        
        Intacct_Entity__c testIntacctEntity2 = new Intacct_Entity__c(Name = 'PG of CT');
        insert testIntacctEntity2;
        
        Intacct_Entity__c testIntacctEntity3 = new Intacct_Entity__c(Name = 'PG of NY');
        insert testIntacctEntity3; 
        
        this.testAccount = new Account();
        this.testAccount.LastName = 'Test';
        
        insert this.testAccount;
        
        this.testOpp = new Opportunity();
        this.testOpp.Name = 'Test Opp';
        this.testOpp.AccountId = testAccount.Id;
        this.testOpp.StageName = 'Schedule Appointment';
        this.testOpp.CloseDate = Date.newInstance(2015,2,3);
        
        insert this.testOpp;
        
        this.testAttachment = new Attachment();
        this.testAttachment.Body = Blob.valueOf('String');
    }

    public static TestHouseUtilities generateTest()
    {
        TestHouseUtilities e = new TestHouseUtilities();
        e.generateOpp();
        return e;
    }
}