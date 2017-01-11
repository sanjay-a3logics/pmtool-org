@isTest
public class TestBoxProjectExtension{

 public static testMethod void UnitTest1(){
 
       Account acc =new Account();
        acc.name = 'irfan khan';
        insert acc;
        
        Opportunity opp = new Opportunity();
        opp.name = 'Test opp';
        opp.accountId = acc.id;
        opp.CloseDate = date.today();
        opp.stageName = 'Closed won';
        insert opp;
        
        Project__c prj= new Project__c();
        prj.Opportunity__c =opp.id;
        insert prj;
        
        Sub_folder__c sf = new Sub_folder__c();
        sf.name = 'Sales';
        sf.CF_Box_Folder_Id__c = '234873284632';
        sf.CF_Opportunity__c = opp.id;
        
        ApexPages.StandardController controller = new ApexPages.StandardController(prj);
        
        BoxProjectExtension bpe = new BoxProjectExtension(controller);
        bpe.ShareWithUser();
        bpe.getDetails();
 
 }





}