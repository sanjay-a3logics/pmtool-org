@isTest
public class TestBoxUploadAttachmentController{
    
        static testMethod void unittest() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts; 
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                
                Set<Id> attachmentIds = new Set<Id>();
                Blob b0 = Blob.valueOf('TestData');        
                Attachment attachment0 = new Attachment();  
                attachment0.ParentId = opp.id;  
                attachment0.Name = 'Test Attachment for Parent1.txt';  
                attachment0.Body = b0;
                attachment0.contenttype = 'images/plain';                   
                insert attachment0;
                system.assert(attachment0.id!=null);
                
                Blob b01 = Blob.valueOf('TestData');        
                Attachment attachment01 = new Attachment();  
                attachment01.ParentId = opp.id;  
                attachment01.Name = 'Test Attachment for Parent1.yyy';  
                attachment01.Body = b01;
                attachment01.contenttype = 'images/plain';                   
                insert attachment01;
                system.assert(attachment01.id!=null);
                
                
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for Parent1.jpg';  
                attachment.Body = b;
                attachment.contenttype = 'images/jpeg';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for Parent1.jpeg';  
                attachment1.Body = b1;
                attachment1.contenttype = 'images/jpeg';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;   
            system.assert(dds.id!=null);
           
            Set<Id> FeedItemIds = new Set<Id>();
            
            Blob b3 = Blob.valueOf('TestDatas');  
            FeedItem fi = new FeedItem(ContentFileName= 'Test Feed.jpeg',ContentData =b3,parentId=opp.id);
            insert fi;
            FeedItemIds.add(fi.id);
            
            FeedItem fi1 = new FeedItem(ContentFileName= 'Test Feed.jpeg',ContentData =b3,parentId=opp.id);
            insert fi1;
            FeedItemIds.add(fi1.id);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Deal__c',attachmentIds);
            BoxUploadAttachmentController.uploadFeedItems(Opp.Id,FeedItemIds);
            Test.stopTest();
           } 
           
           
           static testMethod void unittest1() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('Test Data');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for Parent1';  
                attachment.Body = b;                   
                upsert attachment;
                system.assert(attachment.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Set<Id> FeedItemIds = new Set<Id>();
            
            Blob b3 = Blob.valueOf('TestDatas');  
            FeedItem fi = new FeedItem(ContentFileName= 'Test Feed.jpeg',ContentData =b3,parentId=opp.id);
            insert fi;
            FeedItemIds.add(fi.id);
            
            FeedItem fi1 = new FeedItem(ContentFileName= 'Test Feed.jpeg',ContentData =b3,parentId=opp.id);
            insert fi1;
            FeedItemIds.add(fi1.id);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Deal__c',attachmentIds);
            BoxUploadAttachmentController.uploadFeedItems(Opp.Id,FeedItemIds);
            Test.stopTest();
           }   
          static testMethod void unittest2() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                
                dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
                insert dds;
                system.assert(dds.id!=null);
            
                Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Sales');
                insert sc;
                system.assert(sc.id!=null);
                
                Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Application');
                insert sc1;
                system.assert(sc1.id!=null);
                
                
                Set<Id> FeedItemIds = new Set<Id>();
            
                Blob b3 = Blob.valueOf('TestDatas');  
                FeedItem fi = new FeedItem(ContentFileName= 'Test Feed.jpeg',ContentData =b3,parentId=opp.id);
                insert fi;
                FeedItemIds.add(fi.id);
                
                FeedItem fi1 = new FeedItem(ContentFileName= 'Test Feed.jpeg',ContentData =b3,parentId=opp.id);
                insert fi1;
                FeedItemIds.add(fi1.id);
               
                Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
                insert testBox;
                System.assert(testBox.id!=null);
            
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData==');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for Parent';  
                attachment.Body = b;                   
                upsert attachment;
                system.assert(attachment.id!=null);
                
                attachmentIds.add(attachment.id);
                
                   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
            BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            BoxUploadAttachmentController.uploadFeedItems(opp.Id,FeedItemIds);
            Test.stopTest();
           } 
           
            static testMethod void unittestt1() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                
                Set<Id> attachmentIds = new Set<Id>();
                
                Blob b01 = Blob.valueOf('TestData');        
                Attachment attachment01 = new Attachment();  
                attachment01.ParentId = opp.id;  
                attachment01.Name = 'Test Attachment for Parent1.yyy';  
                attachment01.Body = b01;
                attachment01.contenttype = 'images/plain';                   
                insert attachment01;
                system.assert(attachment01.id!=null);
                
                
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for Parent1.jpg';  
                attachment.Body = b;
                attachment.contenttype = 'images/jpeg';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for Parent1.jpeg';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/jpeg';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
           
           
           static testMethod void unittestt2() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for Parent1.jpg';  
                attachment.Body = b;
                attachment.contenttype = 'images/jpeg';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for Parent1.jpeg';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/jpeg';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
           
           
           static testMethod void unittestt3() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for.Parent1.jpeg';  
                attachment.Body = b;
                attachment.contenttype = 'images/jpeg';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for.Parent1.jpeg';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/jpeg';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
           
            static testMethod void unittestt4() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for.Parent1.jpg';  
                attachment.Body = b;
                attachment.contenttype = 'images/jpeg';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for.Parent1.jpg';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/jpeg';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
           
             static testMethod void unittestt5() {

                 Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts; 
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for.Parent1.txt';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for.Parent1.txt';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }


static testMethod void unittestt6() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';
                insert opp;
                System.assert(opp.id!=null);            
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for.Parent1';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for.Parent1';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
          
static testMethod void unittestt7() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
                Account acc =new Account();
                acc.name = 'irfan khan';
                insert acc;
                System.assert(acc.id!=null); 
                           
                Deal__c opp = new Deal__c();
                //opp.name = 'Test opp';
                opp.Account__c = acc.id;
                opp.CloseDate__c = date.today();
                opp.stageName__c = 'Closed won';			
                insert opp;
                System.assert(opp.id!=null);            
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for.Parent1';  
                attachment.Body = b;
                attachment.contenttype = 'images/pdf';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for.Parent1';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/pdf';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
   

static testMethod void unittestt8() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
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
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'Test Attachment for Parent1 dd';  
                attachment.Body = b;
                attachment.contenttype = 'images/pdf';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'Test Attachment for Parent1 dd';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/pdf';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
 
 static testMethod void unittestt9() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
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
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'dd';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'dd';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
   
 static testMethod void unittestt10() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
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
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'dd';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'dd';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock1());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
           
              
 static testMethod void unittestt11() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
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
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'dd';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'dd';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock2());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
           // BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
           
                         
 static testMethod void unittestt12() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
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
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'dd';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'dd';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
             Set<Id> FeedItemIds = new Set<Id>();
             Blob b3 = Blob.valueOf('TestDatas');  
             FeedItem fi = new FeedItem(ContentFileName= 'Test Feed.jpeg',ContentData =b3,parentId=opp.id);
             insert fi;
             FeedItemIds.add(fi.id);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFileUploadMock4());
            BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
            BoxUploadAttachmentController.uploadFeedItems(Opp.Id,FeedItemIds);
            Test.stopTest();
           }
           
                                    
 static testMethod void unittestt13() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
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
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'dd';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'dd';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Application');
            insert sc;
            system.assert(sc.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestUploadAttachmentMockup());
            //BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
            BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
           
           static testMethod void unittestt14() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
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
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'dd';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'dd';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Application');
            insert sc1;
            system.assert(sc1.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application1');
            insert dds;
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestUploadAttachmentMockup());
            //BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
            BoxUploadAttachmentController.uploadDocusignDocs(dds.Id,attachmentIds);
            Test.stopTest();
           }
           
         static testMethod void unittestt15() {

                Trigger_Setting__c ts = new Trigger_Setting__c(Attachment_Trigger__c=true);
                insert ts;
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
                                
                Set<Id> attachmentIds = new Set<Id>();
  
                Blob b = Blob.valueOf('TestData');        
                Attachment attachment = new Attachment();  
                attachment.ParentId = opp.id;  
                attachment.Name = 'dd';  
                attachment.Body = b;
                attachment.contenttype = 'images/plain';                   
                insert attachment;
                system.assert(attachment.id!=null);
                
                Blob b1 = Blob.valueOf('TestDatas');        
                Attachment attachment1 = new Attachment();  
                attachment1.ParentId = opp.id;  
                attachment1.Name = 'dd';  
                attachment1.Body = b;
                attachment1.contenttype = 'images/plain';                    
                insert attachment1;
                system.assert(attachment1.id!=null);
                
                attachmentIds.add(attachment.id);
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='sales');
            insert sc;
            system.assert(sc.id!=null);
            
            Sub_Folder__c sc1= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Application');
            insert sc1;
            system.assert(sc1.id!=null);
            
            dsfs__DocuSign_Status__c  dds = new dsfs__DocuSign_Status__c(dsfs__Company__c=acc.id,Deal__c=opp.id,dsfs__Subject__c='Application1');
            insert dds;   				
            system.assert(dds.id!=null);
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null); 
            
            List<Box_error__c>  bxErrList = new  List<Box_error__c>();
            
            BoxUploadAttachmentController boxupload = new BoxUploadAttachmentController();
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestUploadAttachmentMockup());
            //BoxUploadAttachmentController.uploadAttachment(Opp.Id,'Opportunity',attachmentIds);
            BoxUploadAttachmentController.uploadDuplicateDocumnet(2,attachment1, sc.CF_Box_Folder_Id__c, 'Custom Doc', bxErrList);
            BoxUploadAttachmentController.uploadDuplicateDocument(2,attachment1, sc.CF_Box_Folder_Id__c, 'Custom Doc', bxErrList);
            Test.stopTest();
           }
           
          
        }