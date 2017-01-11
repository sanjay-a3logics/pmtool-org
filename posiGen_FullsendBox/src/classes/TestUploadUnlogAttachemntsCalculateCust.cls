@isTest
public class TestUploadUnlogAttachemntsCalculateCust{

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
                    
                   List<Attachment> attLst = new  List<Attachment> ();
                    Blob b = Blob.valueOf('Test Data');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = opp.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    attLst.add(attachment);
                    
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.name = attachment.id; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = ' ';
                    bxerr.Type__c = 'Standard Doc Count';
                    bxerr.Status__c = 'Error';
                    insert bxerr;

                    
                     UploadUnlogAttachemntsCalculateCust uha = new UploadUnlogAttachemntsCalculateCust(1,'Standard');
                     
                     Database.BatchableContext BC;
        
                     uha.start(BC);
                     uha.execute(bc,attlst);
                  
         
             
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
                    
                     dsfs__DocuSign_Status__c ds = new dsfs__DocuSign_Status__c();
                    ds.dsfs__Opportunity__c = opp.id;
                    ds.dsfs__Subject__c ='Sales';
                    ds.dsfs__Company__c =acc.id;
                    insert ds; 
                    
                    Blob b = Blob.valueOf('NewTest==========');
                    
                    List<Attachment> attLst = new  List<Attachment> ();  
                   
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ds.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    attLst.add(attachment);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.name =  attachment.id;
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = ' ';
                    bxerr.Type__c = 'Docusign Doc Count';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                    
                    UploadUnlogAttachemntsCalculateCust uha = new UploadUnlogAttachemntsCalculateCust(1,'Docusign');
          
                    Database.BatchableContext BC;
        
                     uha.start(BC);
                     uha.execute(bc,attlst);
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
                    
                    List<Attachment> attLst = new  List<Attachment> ();
                    Project__c project = new Project__c(Opportunity__c=opp.id);
                    insert project;
                    system.assert(project.id!=null);
                    
                     Attachment__c ca= new Attachment__c();
                     ca.Project__c=project.id;
                     insert ca;
                     System.assert(ca.id!=null);
                
                   
                    Blob b = Blob.valueOf('Test Data');  
                    Attachment attachment = new Attachment();  
                    attachment.ParentId = ca.id;  
                    attachment.Name = 'Test Attachment for Parent';  
                    attachment.Body = b;  
                    upsert attachment;
                    system.assert(attachment.id!=null);
                    attLst.add(attachment);
                    
                    box_error__c bxerr = new box_error__c();
                    bxerr.Opportunity__c = opp.id; 
                    bxerr.name = attachment.id; 
                    bxerr.Message__c = 'Attachment id-'+attachment.id; 
                    bxerr.Body__c = ' ';
                    bxerr.Type__c = 'Custom Doc Count';
                    bxerr.Status__c = 'Error';
                    insert bxerr;
                  UploadUnlogAttachemntsCalculateCust uha = new UploadUnlogAttachemntsCalculateCust(1,'Custom');
                  
                   Database.BatchableContext BC;
        
                     uha.start(BC);
                     uha.execute(bc,attlst);
             
     }




}