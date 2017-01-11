@isTest
public class TestBoxPermissionController{
   
 
  public static testmethod void TestBoxPermissionController1(){
     
    Profile pf = [Select Id , name from Profile where Name ='System Administrator'];
    Account acc =new Account();
    acc.name = 'irfan khan';
    upsert acc;
   
    Deal__c opp = new Deal__c();								
    //opp.name = 'Test opp';
    opp.Account__c = acc.id;
    opp.CloseDate__c = date.today();
    opp.stageName__c = 'Closed Won';
    upsert opp;
        
    Deal__c op =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
     
     BoxAccessMatrix_SubFolder__c bsf = new BoxAccessMatrix_SubFolder__c(Name = 'Sales',SubFolder_Name__c='Sales');
     insert bsf;
     
     BoxAccessMatrix_Profile__c bsp = new BoxAccessMatrix_Profile__c(BoxAccessMatrix_SubFolder__c = bsf.id,Profile_Id__c=pf.id,Profile_Name__c = pf.name);
     insert bsp;
     
     BoxAccessMatrix_Stage__c bms = new BoxAccessMatrix_Stage__c(BoxAccessMatrix_Profile__c = bsp.id,Box_Permission__c='Editor',Check__c=true,Stage__c='Closed Won');
     insert bms;
     
     BoxPermissionController bp = new BoxPermissionController();
     
     bp.saveSales();
  
  }
  public static testmethod void TestBoxPermissionController2(){
     
     Profile pf = [Select Id , name from Profile where Name ='System Administrator'];
     Account acc =new Account();
     acc.name = 'irfan khan';
     upsert acc;
   
    Deal__c opp = new Deal__c();
    //opp.name = 'Test opp';
    opp.Account__c = acc.id;
    opp.CloseDate__c = date.today();
    opp.stageName__c = 'Closed Won';
    upsert opp;
        
    Deal__c op =[Select id, Opp_Pipeline_Stage__c from Deal__c where stageName__c='Closed Won' and id=:opp.id];
     
     BoxAccessMatrix_SubFolder__c bsf = new BoxAccessMatrix_SubFolder__c(Name = 'Application',SubFolder_Name__c='Application');
     insert bsf;
     
     BoxAccessMatrix_Profile__c bsp = new BoxAccessMatrix_Profile__c(BoxAccessMatrix_SubFolder__c = bsf.id,Profile_Id__c=pf.id,Profile_Name__c = pf.name);
     insert bsp;
     
     BoxAccessMatrix_Stage__c bms = new BoxAccessMatrix_Stage__c(BoxAccessMatrix_Profile__c = bsp.id,Box_Permission__c='Editor',Check__c=true,Stage__c='Closed Won');
     insert bms;
     
     BoxPermissionController bp = new BoxPermissionController();
     
     bp.saveApplication();
  
  } 
  public static testmethod void TestBoxPermissionController3(){
     
     Profile pf = [Select Id , name from Profile where Name ='System Administrator'];
     
    
     Account acc =new Account();
     acc.name = 'irfan khan';
     upsert acc;
   
    Deal__c opp = new Deal__c();
    //opp.name = 'Test opp';
    opp.Account__c = acc.id;
    opp.CloseDate__c= date.today();  					
    opp.stageName__c = 'Closed Won';
    upsert opp;
     
     BoxAccessMatrix_SubFolder__c bsf = new BoxAccessMatrix_SubFolder__c(Name = 'Funding-Vendor',SubFolder_Name__c='Funding-Vendor');
     insert bsf;
     
     BoxAccessMatrix_Profile__c bsp = new BoxAccessMatrix_Profile__c(BoxAccessMatrix_SubFolder__c = bsf.id,Profile_Id__c=pf.id,Profile_Name__c = pf.name);
     insert bsp;
     
     BoxAccessMatrix_Stage__c bms = new BoxAccessMatrix_Stage__c(BoxAccessMatrix_Profile__c = bsp.id,Box_Permission__c='Editor',Check__c=true,Stage__c='Closed Won');
     insert bms;
     
     BoxPermissionController bp = new BoxPermissionController();
     
     bp.saveFunding();
  
  }
   public static testmethod void TestBoxPermissionController4(){
     
     Profile pf = [Select Id , name from Profile where Name ='System Administrator'];
     
       
     Account acc =new Account();
     acc.name = 'irfan khan';
     upsert acc;
   
    Deal__c opp = new Deal__c();
    //opp.name = 'Test opp';
    opp.Account__c = acc.id;
    opp.CloseDate__c = date.today();
    opp.stageName__c = 'Closed Won';   
    upsert opp;
     
     BoxAccessMatrix_SubFolder__c bsf = new BoxAccessMatrix_SubFolder__c(Name = 'EE',SubFolder_Name__c='EE');
     insert bsf;
     
     BoxAccessMatrix_Profile__c bsp = new BoxAccessMatrix_Profile__c(BoxAccessMatrix_SubFolder__c = bsf.id,Profile_Id__c=pf.id,Profile_Name__c = pf.name);
     insert bsp;
     
     BoxAccessMatrix_Stage__c bms = new BoxAccessMatrix_Stage__c(BoxAccessMatrix_Profile__c = bsp.id,Box_Permission__c='Editor',Check__c=true,Stage__c='Closed Won');
     insert bms;
     
     BoxPermissionController bp = new BoxPermissionController();
     
     bp.saveEE();
  
   } 
 }