@isTest
public class TestAttachmentUploaderScheduler {
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
                    
                    Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
                    insert sc1;
                    system.assert(sc1.id!=null);           
                    
                    dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,dsfs__Opportunity__c=opp.id,dsfs__Subject__c='Application');
                    insert dds;
                    system.assert(dds.id!=null);
                
                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                   
                    Blob b = Blob.valueOf('Test Data =================');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = dds.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Exception '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception';
                    bxerr.Type__c = 'Docusign Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderScheduler aus= new AttachmentUploaderScheduler();       
         Test.startTest(); 
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock()); 
         AttachmentUploaderScheduler.runUploadAttachment();   
         AttachmentUploaderScheduler.dummyCode();
         Test.stopTest();
         
             
     }
    static testMethod void myTest1() {
 
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
                    
                    Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
                    insert sc1;
                    system.assert(sc1.id!=null);           
                    
                    dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,dsfs__Opportunity__c=opp.id,dsfs__Subject__c='Application');
                    insert dds;
                    system.assert(dds.id!=null);
                
                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                   
                    Blob b = Blob.valueOf('Test Data =======');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = dds.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Exception '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception=';
                    bxerr.Type__c = 'Docusign Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderScheduler aus= new AttachmentUploaderScheduler();
         Test.startTest();         
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock1()); 
         AttachmentUploaderScheduler.runUploadAttachment();                      
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
                    
                    Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
                    insert sc1;
                    system.assert(sc1.id!=null);           
                
                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                   
                    Blob b = Blob.valueOf('Test Data =');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = opp.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Exception '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception';
                    bxerr.Type__c = 'Docusign Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderSchedulerStandard  auss = new AttachmentUploaderSchedulerStandard();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
         String sch1 = '0 1 13 * * ?';
         system.schedule('Test check 1', sch1, auss);                         
         Test.stopTest();        
             
     }
     
       static testMethod void myTest11() {
 
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
                    
                    Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
                    insert sc1;
                    system.assert(sc1.id!=null);           
                
                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                   
                    Blob b = Blob.valueOf('================Test Data');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = opp.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Exception '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception';
                    bxerr.Type__c = 'Docusign Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderSchedulerStandard  auss = new AttachmentUploaderSchedulerStandard();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
         String sch1 = '0 1 13 * * ?';
         system.schedule('Test check 1', sch1, auss);                         
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
                    
                    Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
                    insert sc1;
                    system.assert(sc1.id!=null);           

                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                   
                    Blob b = Blob.valueOf('Test Data =======');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = opp.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Exception '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception=';
                    bxerr.Type__c = 'Docusign Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderSchedulerStandard  auss = new AttachmentUploaderSchedulerStandard();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock1());
         String sch = '0 0 23 * * ?';
         system.schedule('Test check 1', sch, auss);              
         Test.stopTest();
         
             
     }
     static testMethod void myTest4() {
 
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
                    
                    Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='sales');
                    insert sc1;
                    system.assert(sc1.id!=null);           

                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Application');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                   
                    Blob b = Blob.valueOf('===========Test Data =============');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = opp.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Exception '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception=';
                    bxerr.Type__c = 'Docusign Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderSchedulerStandard  auss = new AttachmentUploaderSchedulerStandard();
         AttachmentUploaderSchedulerStandard.dummyCode();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
         String sch = '0 0 23 * * ?';
         system.schedule('Test check 1', sch, auss);              
         Test.stopTest();               
     }
     
     
 static testMethod void myTest5() {
 
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
                
                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Funding-Vendor');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                    Project__c project = new Project__c(Opportunity__c=opp.id);
                    insert project;
                    system.assert(project.id!=null);
                    
                    Attachment__c ca= new Attachment__c();
                    ca.Project__c=project.id;
                    insert ca;
                    System.assert(ca.id!=null);

                    Blob b = Blob.valueOf('=============Test Data =======');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ca.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Heap Size Exceed '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception';
                    bxerr.Type__c = 'Custom Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);                    
                   

         AttachmentUploaderSchedulerCustom ausc = new AttachmentUploaderSchedulerCustom();
         AttachmentUploaderSchedulerCustom.dummyCode();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
         AttachmentUploaderSchedulerCustom.runUploadCustom();                          
         Test.stopTest();
         
             
     }  
     
    static testMethod void myTest6() {
 
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

                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Funding-Vendor');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                    Project__c project = new Project__c(Opportunity__c=opp.id);
                    insert project;
                    system.assert(project.id!=null);
                    
                    Attachment__c ca= new Attachment__c();
                    ca.Project__c=project.id;
                    insert ca;
                    System.assert(ca.id!=null);

                    Blob b = Blob.valueOf('===========Test Data =====');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ca.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Heap Size Exceed '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception=';
                    bxerr.Type__c = 'Custom Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderSchedulerCustom ausc = new AttachmentUploaderSchedulerCustom();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
         AttachmentUploaderSchedulerCustom.runUploadCustom();                      
         Test.stopTest();         
             
     }
     
       static testMethod void myTest7() {
 
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

                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Funding-Vendor');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                    Project__c project = new Project__c(Opportunity__c=opp.id);
                    insert project;
                    system.assert(project.id!=null);
                    
                    Attachment__c ca= new Attachment__c();
                    ca.Project__c=project.id;
                    insert ca;
                    System.assert(ca.id!=null);

                    Blob b = Blob.valueOf('===========Test Data');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ca.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Heap Size Exceed '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception=';
                    bxerr.Type__c = 'Custom Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderSchedulerCustom ausc = new AttachmentUploaderSchedulerCustom();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
         AttachmentUploaderSchedulerCustom.runUploadCustom();                      
         Test.stopTest();         
             
     }
          
     static testMethod void myTest8() {
 
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

                    Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Opportunity__c=opp.id,Name='Funding-Vendor');
                    insert sc;
                    system.assert(sc.id!=null);
                   
                    Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                    insert testBox;
                    System.assert(testBox.id!=null);
                   
                    Project__c project = new Project__c(Opportunity__c=opp.id);
                    insert project;
                    system.assert(project.id!=null);
                    
                    Attachment__c ca= new Attachment__c();
                    ca.Project__c=project.id;
                    insert ca;
                    System.assert(ca.id!=null);

                    Blob b = Blob.valueOf('Test Data  =============');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ca.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = 'Heap Size Exceed '; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = 'Heap Limit Exception==';
                    bxerr.Type__c = 'Custom Doc';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    System.assert(bxerr.id!=null);


         AttachmentUploaderSchedulerCustom ausc = new AttachmentUploaderSchedulerCustom();
         Test.startTest();
         Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
         AttachmentUploaderSchedulerCustom.runUploadCustom();               
         Test.stopTest();
         
             
     }
}