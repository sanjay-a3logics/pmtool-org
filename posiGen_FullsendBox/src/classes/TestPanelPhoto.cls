@isTest
public class TestPanelPhoto {

    public static testMethod void testImageTypes()
        {
            TestHouseUtilities tu = TestHouseUtilities.generateTest();
            
            ApexPages.StandardController sc;
            PanelPhoto panelTest;
            
            Opportunity myOpp = tu.testOpp;
            
            List<String> types = new List<String>{'image/jpeg', 'image/pjpeg', 'image/png', 'image/x-png', 'image/gif'};
                
            Attachment tempAtt = new Attachment();
            
            Test.startTest();
            	for (String aType : types)
            	{
                    sc = new ApexPages.StandardController(myOpp);
                    panelTest = new PanelPhoto(sc);
                    panelTest.newAttach.Name = 'Panel Photo';
                    panelTest.newAttach.Body = Blob.valueOf('String');
                    panelTest.newAttach.ContentType = aType;
                    panelTest.uploadAction();
                    
                    panelTest.newAttach.Body = Blob.valueOf('String');
                    
                    System.assert(panelTest.newAttach.name == 'Panel Photo', 'Name not equals');
                    System.assert(panelTest.newAttach.ContentType == aType, 'Types not equals');
                }
            
            	sc = new ApexPages.StandardController(myOpp);
            	panelTest = new PanelPhoto( sc );
                panelTest.newAttach.Name = 'Panel Photo';
                panelTest.newAttach.Body = Blob.valueOf('String');
                panelTest.newAttach.ContentType = 'image/YYY';
                panelTest.uploadAction();
                System.assert( panelTest.error == 'The image must be .jpg, .gif or .png<br/>', 'Error in error message.' + panelTest.error);
    
                panelTest = new PanelPhoto( sc );
                panelTest.uploadAction();
                
            Test.stopTest();
            }
    
    public static testMethod void testNoPicture(){
        TestHouseUtilities tu = TestHouseUtilities.generateTest();
        
        Test.startTest();
        ApexPages.StandardController sc = new ApexPages.StandardController( tu.testOpp );
		PanelPhoto cTest = new PanelPhoto( sc );
        cTest.newAttach.Name = 'Panel Photo';
        cTest.newAttach.Body = Blob.valueOf('String');
        cTest.newAttach.ContentType = 'image/jpeg';
        cTest.uploadAction();

        Attachment attUploaded = [ SELECT name, parentId, body, ContentType FROM Attachment WHERE parentId =: sc.getId() AND name = 'Panel Photo'];
        System.assert( attUploaded != null, 'No attachment uploaded.' );
        System.assert( attUploaded.name == 'Panel Photo', 'Name not equals.' );
        System.assert( attUploaded.Body.toString() == Blob.valueOf('String').toString(), 'Bodys not equals.' );
        System.assert( attUploaded.ContentType == 'image/jpeg', 'Types not equals.' );

        
        // Replace string
        sc = new ApexPages.StandardController( tu.testOpp );
        cTest = new PanelPhoto( sc );
        cTest.newAttach.Name = 'Panel Photo';
        cTest.newAttach.Body = Blob.valueOf('Other String For Replacement');
        cTest.newAttach.ContentType = 'image/png';
        cTest.uploadAction();
        
        attUploaded = [ SELECT name, parentId, body, ContentType FROM Attachment WHERE parentId =: sc.getId() AND name = 'Panel Photo'];
        System.assert( attUploaded != null, 'No attachment uploaded.' );
        System.assert( attUploaded.name == 'Panel Photo', 'Name not equals.' );
        System.assert( attUploaded.Body.toString() == Blob.valueOf('Other String For Replacement').toString(), 'Bodys not equals.' );
        System.assert( attUploaded.ContentType == 'image/png', 'Types not equals.' );
        
        
        Id stroringAttIdForRetreve = cTest.newAttach.id;
        cTest = new PanelPhoto( sc );
        cTest.deleteAction();
        List<Attachment> attUploadedList = [ SELECT id FROM Attachment WHERE id =: stroringAttIdForRetreve ];

        System.assert( attUploadedList.size() == 0, 'Attachment not deleted !!!' );
        
        Test.stopTest();    
    }
    
        public static testMethod void testCancelAction(){
        TestHouseUtilities tu = TestHouseUtilities.generateTest();
        
        Test.startTest();
          ApexPages.StandardController sc = new ApexPages.StandardController( tu.testOpp );
          PanelPhoto cTest = new PanelPhoto( sc );
          cTest.cancel();         
          System.assert( cTest.cancel() != null, 'Some error occurs with PageReference Method is called' );
        Test.stopTest();
    }

}