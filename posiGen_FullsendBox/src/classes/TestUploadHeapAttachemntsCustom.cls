@isTest
public class TestUploadHeapAttachemntsCustom{
     static testMethod void myTest() {
 
                    Account acc =new Account();
                    acc.name = 'irfan khan';
                    insert acc;
                    System.assert(acc.id!=null); 
                               
                    Opportunity opp = new Opportunity();
                    opp.name = 'Test opp';
                    opp.accountId = acc.id;
                    opp.CloseDate = date.today();
                    opp.stageName = 'Closed won';
                    insert opp;
                    System.assert(opp.id!=null); 
                    
                               
                    
                    Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Funding-Vendor');
                    insert sc1;
                    system.assert(sc1.id!=null);           
                  
                    Project__c project = new Project__c(Opportunity__c=opp.id);
                    insert project;
                    system.assert(project.id!=null);
                    
                     Attachment__c ca= new Attachment__c();
                     ca.Project__c=project.id;
                     insert ca;
                     System.assert(ca.id!=null);
                  
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                   
                    Blob b = Blob.valueOf('Test Data');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ca.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Heap size Exceed '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = ' ';
                    bxerr.Type__c = 'Custom Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;

         String strId = attachment.id+','+bxerr.id; 
         UploadHeapAttachemntsCustom uha = new UploadHeapAttachemntsCustom();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
         UploadHeapAttachemntsCustom.uploadattachments(strId);
         UploadHeapAttachemntsCustom.dummyCode();
         Test.stopTest();
         
             
     }
     static testMethod void myTest2() {
 
                    Account acc =new Account();
                    acc.name = 'irfan khan';
                    insert acc;
                    System.assert(acc.id!=null); 
                               
                    Opportunity opp = new Opportunity();
                    opp.name = 'Test opp';
                    opp.accountId = acc.id;
                    opp.CloseDate = date.today();
                    opp.stageName = 'Closed won';
                    insert opp;
                    System.assert(opp.id!=null);            
                    
                    Project__c project = new Project__c(Opportunity__c=opp.id);
                    insert project;
                    system.assert(project.id!=null);
                    
                     Attachment__c ca= new Attachment__c();
                     ca.Project__c=project.id;
                     insert ca;
                     System.assert(ca.id!=null);
                
                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Funding-Vendor');
                    insert sc;
                    system.assert(sc.id!=null); 
                    
                    Blob b = Blob.valueOf('NewTest==========');
                      
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ca.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Heap size Exceed '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = ' ';
                    bxerr.Type__c = 'Custom Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
         String strId = attachment.id+','+bxerr.id;          
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock1());
         UploadHeapAttachemntsCustom.uploadattachments(attachment.id);
         Test.stopTest();
             
     }
      static testMethod void myTest3() {
 
                    Account acc =new Account();
                    acc.name = 'irfan khan';
                    insert acc;
                    System.assert(acc.id!=null); 
                               
                    Opportunity opp = new Opportunity();
                    opp.name = 'Test opp';
                    opp.accountId = acc.id;
                    opp.CloseDate = date.today();
                    opp.stageName = 'Closed won';
                    insert opp;
                    System.assert(opp.id!=null);            
                    
                    
                    Project__c project = new Project__c(Opportunity__c=opp.id);
                    insert project;
                    system.assert(project.id!=null);
                    
                     Attachment__c ca= new Attachment__c();
                     ca.Project__c=project.id;
                     insert ca;
                     System.assert(ca.id!=null);
                
                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Funding-Vendor');
                    insert sc;
                    system.assert(sc.id!=null); 
                    
                    Blob b = Blob.valueOf('NewTest==========');
                      
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ca.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Heap size Exceed '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = ' ';
                    bxerr.Type__c = 'Custom Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
         String strId = attachment.id+','+bxerr.id;           
         Test.startTest();
         //Test.setMock(HttpCalloutMock.class, new TestFileUploadMock1());
         UploadHeapAttachemntsCustom.uploadattachments(strId);
         Test.stopTest();
             
     }
}