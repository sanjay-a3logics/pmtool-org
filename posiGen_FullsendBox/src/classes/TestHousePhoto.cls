@isTest
public class TestHousePhoto {

    public static testMethod void testImageTypes()
        {
            TestHouseUtilities tu = TestHouseUtilities.generateTest();
            
            ApexPages.StandardController sc;
            HousePhoto houseTest;
            
            Opportunity myOpp = tu.testOpp;
            
            List<String> types = new List<String>{'image/jpeg', 'image/pjpeg', 'image/png', 'image/x-png', 'image/gif'};
                
            Attachment tempAtt = new Attachment();
            
            Test.startTest();
            	for (String aType : types)
            	{
                    sc = new ApexPages.StandardController(myOpp);
                    houseTest = new HousePhoto(sc);
                    houseTest.newAttach.Name = 'House Photo';
                    houseTest.newAttach.Body = Blob.valueOf('String');
                    houseTest.newAttach.ContentType = aType;
                    houseTest.uploadAction();
                    
                    houseTest.newAttach.Body = Blob.valueOf('String');
                    
                    System.assert(houseTest.newAttach.name == 'House Photo', 'Name not equals');
                    System.assert(houseTest.newAttach.ContentType == aType, 'Types not equals');
                }
            
            	sc = new ApexPages.StandardController(myOpp);
            	houseTest = new HousePhoto( sc );
                houseTest.newAttach.Name = 'House Photo';
                houseTest.newAttach.Body = Blob.valueOf('String');
                houseTest.newAttach.ContentType = 'image/YYY';
                houseTest.uploadAction();
                System.assert( houseTest.error == 'The image must be .jpg, .gif or .png<br/>', 'Error in error message.' + houseTest.error);
    
                houseTest = new HousePhoto( sc );
                houseTest.uploadAction();
                
            Test.stopTest();
            }
    
    public static testMethod void testNoPicture(){
        TestHouseUtilities tu = TestHouseUtilities.generateTest();
        
        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController( tu.testOpp );
		HousePhoto cTest = new HousePhoto( sc );
        cTest.newAttach.Name = 'House Photo';
        cTest.newAttach.Body = Blob.valueOf('String');
        cTest.newAttach.ContentType = 'image/jpeg';
        cTest.uploadAction();

        Attachment attUploaded = [ SELECT name, parentId, body, ContentType FROM Attachment WHERE parentId =: sc.getId() AND name = 'House Photo'];
        System.assert( attUploaded != null, 'No attachment uploaded.' );
        System.assert( attUploaded.name == 'House Photo', 'Name not equals.' );
        System.assert( attUploaded.Body.toString() == Blob.valueOf('String').toString(), 'Bodys not equals.' );
        System.assert( attUploaded.ContentType == 'image/jpeg', 'Types not equals.' );

        
        // Replace string
        sc = new ApexPages.StandardController( tu.testOpp );
        cTest = new HousePhoto( sc );
        cTest.newAttach.Name = 'House Photo';
        cTest.newAttach.Body = Blob.valueOf('Other String For Replacement');
        cTest.newAttach.ContentType = 'image/png';
        cTest.uploadAction();
        
        attUploaded = [ SELECT name, parentId, body, ContentType FROM Attachment WHERE parentId =: sc.getId() AND name = 'House Photo'];
        System.assert( attUploaded != null, 'No attachment uploaded.' );
        System.assert( attUploaded.name == 'House Photo', 'Name not equals.' );
        System.assert( attUploaded.Body.toString() == Blob.valueOf('Other String For Replacement').toString(), 'Bodys not equals.' );
        System.assert( attUploaded.ContentType == 'image/png', 'Types not equals.' );
        
        
        Id stroringAttIdForRetreve = cTest.newAttach.id;
        cTest = new HousePhoto( sc );
        cTest.deleteAction();
        List<Attachment> attUploadedList = [ SELECT id FROM Attachment WHERE id =: stroringAttIdForRetreve ];

        System.assert( attUploadedList.size() == 0, 'Attachment not deleted !!!' );
        
        Test.stopTest();    
    }
    
        public static testMethod void testCancelAction(){
        TestHouseUtilities tu = TestHouseUtilities.generateTest();
        
        Test.startTest();
          ApexPages.StandardController sc = new ApexPages.StandardController( tu.testOpp );
          HousePhoto cTest = new HousePhoto( sc );
          cTest.cancel();         
          System.assert( cTest.cancel() != null, 'Some error occurs with PageReference Method is called' );
        Test.stopTest();
    }

}