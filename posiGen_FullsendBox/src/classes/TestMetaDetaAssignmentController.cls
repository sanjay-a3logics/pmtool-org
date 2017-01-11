@isTest
public class TestMetaDetaAssignmentController{
    
        static testMethod void unittest() {

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
                
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Funding-Vendor');
            insert sc;
            system.assert(sc.id!=null);
            
            Meta_Data_Assignment_Column__c metaDataColumn = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column1');
            insert metaDataColumn;
            Meta_Data_Assignment_Column__c metaDataColumn1 = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column2');
            insert metaDataColumn1;
            Meta_Data_Assignment_Column__c metaDataColumn2 = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column3');
            insert metaDataColumn2;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            ApexPages.StandardController controller;
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new TestFolderInfoMock());
            apexpages.currentpage().getparameters().put('id',opp.id);
            MetaDetaAssignmentController metaData = new MetaDetaAssignmentController(controller);

            Test.stopTest();
           }
           
            static testMethod void unittest2() {

                
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
                
               
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Funding-Vendor');
            insert sc;
            system.assert(sc.id!=null);
            
            Meta_Data_Assignment_Column__c metaDataColumn = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column1');
            insert metaDataColumn;
            Meta_Data_Assignment_Column__c metaDataColumn1 = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column2');
            insert metaDataColumn1;
            Meta_Data_Assignment_Column__c metaDataColumn2 = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column3');
            insert metaDataColumn2;
                        
            Meta_Data_Assignment__c mdAssign = new Meta_Data_Assignment__c(Check__c=true, File_Id__c ='423432', File_name__c='wuudwd', Meta_Data_Assignment_Column__c=metaDataColumn.id, Deal__c=opp.id, Uploaded_at__c='9/9/15', Uploaded_by__c='irfan khan');
            insert mdAssign;
            Meta_Data_Assignment__c mdAssign1 = new Meta_Data_Assignment__c(Check__c=false, File_Id__c ='42322432', File_name__c='wuudwd', Meta_Data_Assignment_Column__c=metaDataColumn1.id, Deal__c=opp.id, Uploaded_at__c='9/9/15', Uploaded_by__c='irfan khan');
            insert mdAssign1;
            Meta_Data_Assignment__c mdAssign2 = new Meta_Data_Assignment__c(Check__c=true, File_Id__c ='4234332', File_name__c='wuudwd', Meta_Data_Assignment_Column__c=metaDataColumn2.id, Deal__c=opp.id, Uploaded_at__c='9/9/15', Uploaded_by__c='irfan khan');
            insert mdAssign2;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            ApexPages.StandardController controller;
            //.startTest();
            //Test.setMock(HttpCalloutMock.class, new TestFolderInfoMock());
            apexpages.currentpage().getparameters().put('id',opp.id);
            MetaDetaAssignmentController metaData = new MetaDetaAssignmentController(controller);
            metaData.save();
           //Test.stopTest();
           }
           
                      static testMethod void unittest1() {

                
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
                   					
               
            
            Sub_Folder__c sc= new Sub_Folder__c(CF_Box_Folder_Id__c='890384',CF_Deal__c=opp.id,Name='Funding-Vendor');
            insert sc;
            system.assert(sc.id!=null);
            
            Meta_Data_Assignment_Column__c metaDataColumn = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column1');
            insert metaDataColumn;
            Meta_Data_Assignment_Column__c metaDataColumn1 = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column2');
            insert metaDataColumn1;
            Meta_Data_Assignment_Column__c metaDataColumn2 = new Meta_Data_Assignment_Column__c(Column_Name__c = 'column3');
            insert metaDataColumn2;
                        
            Meta_Data_Assignment__c mdAssign = new Meta_Data_Assignment__c(Check__c=true, File_Id__c ='423432', File_name__c='wuudwd', Meta_Data_Assignment_Column__c=metaDataColumn.id, Deal__c=opp.id, Uploaded_at__c='9/9/15', Uploaded_by__c='irfan khan');
            insert mdAssign;
            Meta_Data_Assignment__c mdAssign1 = new Meta_Data_Assignment__c(Check__c=false, File_Id__c ='42322432', File_name__c='wuudwd', Meta_Data_Assignment_Column__c=metaDataColumn1.id, Deal__c=opp.id, Uploaded_at__c='9/9/15', Uploaded_by__c='irfan khan');
            insert mdAssign1;
            Meta_Data_Assignment__c mdAssign2 = new Meta_Data_Assignment__c(Check__c=true, File_Id__c ='4234332', File_name__c='wuudwd', Meta_Data_Assignment_Column__c=metaDataColumn2.id, Deal__c=opp.id, Uploaded_at__c='9/9/15', Uploaded_by__c='irfan khan');
            insert mdAssign2;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
            insert testBox;
            System.assert(testBox.id!=null);   
            ApexPages.StandardController controller;
            //.startTest();
            //Test.setMock(HttpCalloutMock.class, new TestFolderInfoMock());
            apexpages.currentpage().getparameters().put('id',opp.id);
            MetaDetaAssignmentController metaData = new MetaDetaAssignmentController(controller);
            metaData.saveColumn();
           //Test.stopTest();
           }
           
            
}