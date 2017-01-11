@isTest
public class TestUserCollaboratiionController{
   
   public static testmethod void Test1(){
   
    Profile prf= [select id,Name,(Select id,email from users limit 2) From Profile Where Name='System Administrator'];
        
         User u = new User(Alias = 'standt', Email='standarduser1@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='TestingUserTri1', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = prf.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardpsg1@testorg.com');
          insert u; 
         //UserIds.add(u);
       
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Sales';
        bams.Name='Sales';
        insert bams;    
     
       UserCollaboratiionController ucc= new UserCollaboratiionController();
       ucc.createUserCollaboratoion(u);
       ucc.DeleteUserCollaboratoion(u);
   
   
   
   }
   public static testmethod void Test4(){
   
    Profile prf= [select id,Name,(Select id,email from users limit 2) From Profile Where Name='System Administrator'];
        List<User>UserIds = new List<User>(); 
         User u = new User(Alias = 'standt', Email='standarduser2@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='TestingUserTri2', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = prf.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardpsg2@testorg.com');
          insert u; 
         UserIds.add(u);
       
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='EE';
        bams.Name='EE';
        insert bams;    
     
       UserCollaboratiionController ucc= new UserCollaboratiionController();
       ucc.createUserCollaboratoion(U);
       ucc.DeleteUserCollaboratoion(u);
   
   
   
   }
   public static testmethod void Test2(){
   
    Profile prf= [select id,Name,(Select id,email from users limit 2) From Profile Where Name='System Administrator'];
        List<User>UserIds = new List<User>(); 
       Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='standarduser3@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='TestingUserTri3', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = prf.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardpsg3@testorg.com');
          insert u; 
         UserIds.add(u); 
       
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Application';
        bams.Name='Application';
        insert bams;    
     
       UserCollaboratiionController ucc= new UserCollaboratiionController();
       ucc.createUserCollaboratoion(U);
       ucc.DeleteUserCollaboratoion(u);
   
   
   
   }
   public static testmethod void Test3(){
   
    Profile prf= [select id,Name,(Select id,email from users limit 2) From Profile Where Name='System Administrator'];
        List<User>UserIds = new List<User>(); 
         User u = new User(Alias = 'standt', Email='standarduser4@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='TestingUserTri4', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = prf.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standardpsg4@testorg.com');
          insert u; 
         UserIds.add(u);
        BoxAccessMatrix_SubFolder__c bams = new BoxAccessMatrix_SubFolder__c();
        bams.SubFolder_Name__c='Funding-Vendor';
        bams.Name='Funding-Vendor';
        insert bams;    
     
       UserCollaboratiionController ucc= new UserCollaboratiionController();
       ucc.createUserCollaboratoion(U);
       ucc.DeleteUserCollaboratoion(u);
   
   
   
   }
  


}