@isTest
public class TestBoxLogincontroller{

  public static testmethod void TestBoxLogincontroller(){
       
        Box__c testBox = new Box__c (BoxAccess_Token__c='7sejJNKnLhC6NFQFcGTPqZk1a8T2JjLd',Boxrefresh_token__c ='uvXGWWKFyArawZRa4kJ2VdQP4qmBkMMwcoweMQRpiigpzJzxYkW9My3j6TlHBnnM',Boxclient_Id__c ='askknl10jr57z26sb649nqlh4ftb2xz4',Boxclient_Secret__c='iVmHlomxgyJOPIa7b55vZDzAdCV98833');
        insert testBox;
       
       ApexPages.currentPage().getParameters().put('token', testBox.BoxAccess_Token__c+','+testBox.Boxrefresh_token__c+','+testBox.Boxclient_Id__c+','+testBox.Boxclient_Secret__c);
       BoxLogincontroller bl = new BoxLogincontroller();
       bl.Accesstoken=testBox.BoxAccess_Token__c;
       bl.startup();
       
  
    }

}