/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class TestBoxDuplicateEEfolderMigrationBatch{

    static testMethod void executeTest() {
        
        List<Box_error__c> OppList = new List<Box_error__c>();
                
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
                
                box_error__c bxerr = new box_error__c();
                bxerr.Opportunity__c = opp.id; 
                bxerr.name = '409'; 
                bxerr.Message__c = 'Attachment id-'; 
                bxerr.Body__c = '{"type":"error","status":409,"code":"item_name_in_use","context_info":{"conflicts":{"type":"folder","id":"5045260509","sequence_id":"0","etag":"0","name":"2796_9019apricotst_JamesTobias"}},"help_url":"http:developers.box.com","message":"Item with the same name already exists","request_id":"1145339348561cbaa279ec4"}';
                bxerr.Type__c = 'EE';
                bxerr.Status__c = 'Error';  
                OppList.add(bxerr) ;   
              
              insert  OppList;

           
            
             
            BoxDuplicateEEfolderMigrationBatch  bfb = new BoxDuplicateEEfolderMigrationBatch(1);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
           insert testBox;
           
            bfb.start(bc);
           
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new BoxApiGETDuplicate_mock());
         
            bfb.execute(bc,OppList);
            bfb.finish(bc);
            Test.stopTest();
    }
    
 
    static testMethod void executeTest2() {
        
        
               List<Box_error__c> OppList = new List<Box_error__c>(); 
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
                
                
                box_error__c bxerr = new box_error__c();
                bxerr.Opportunity__c = opp.id; 
                bxerr.name = '409'; 
                bxerr.Message__c = 'Attachment id-'; 
                bxerr.Body__c = '{"total_count":17,"entries":[{"type":"file","id":"37242823954","file_version":{"type":"file_version","id":"36887815730","sha1":"fcd7d08d27001080b6b7364a0da19fbba1593040"},"sequence_id":"2","etag":"2","sha1":"fcd7d08d27001080b6b7364a0da19fbba1593040","name":"Department Issue (2).png"},{"type":"file","id":"38187475686","file_version":{"type":"file_version","id":"37957493718","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(10).pdf"},{"type":"file","id":"38187103950","file_version":{"type":"file_version","id":"37957080058","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(2).pdf"},{"type":"file","id":"38187148478","file_version":{"type":"file_version","id":"37957129742","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(3).pdf"},{"type":"file","id":"38187199486","file_version":{"type":"file_version","id":"37957186418","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(4).pdf"},{"type":"file","id":"38187235782","file_version":{"type":"file_version","id":"37957226802","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(5).pdf"},{"type":"file","id":"38187295426","file_version":{"type":"file_version","id":"37957293034","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(6).pdf"},{"type":"file","id":"38187337138","file_version":{"type":"file_version","id":"37957339674","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(7).pdf"},{"type":"file","id":"38187387842","file_version":{"type":"file_version","id":"37957396130","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(8).pdf"},{"type":"file","id":"38187432998","file_version":{"type":"file_version","id":"37957446166","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031(9).pdf"},{"type":"file","id":"38186309010","file_version":{"type":"file_version","id":"37956197970","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52"},"sequence_id":"2","etag":"2","sha1":"27a2781dd2ff945b39fc84c2f205a619fbb02c52","name":"Lease for Brandon E Davis & Tiffany L Delery @ 6771 Marshall Foch St_Completed., New Orleans, LA 70124 on 031.pdf"},{"type":"file","id":"37499369562","file_version":{"type":"file_version","id":"37181568946","sha1":"2a95e3b6cf3a07ae762adfe29d25233aa2bc8752"},"sequence_id":"3","etag":"3","sha1":"2a95e3b6cf3a07ae762adfe29d25233aa2bc8752","name":"loading.gif"},{"type":"file","id":"38688619837","file_version":{"type":"file_version","id":"38516405045","sha1":"4c46cedeafe7b599e95a02cae35d7383357f5bdc"},"sequence_id":"2","etag":"2","sha1":"4c46cedeafe7b599e95a02cae35d7383357f5bdc","name":"msg-1-fc-40.jpg"},{"type":"file","id":"37488183190","file_version":{"type":"file_version","id":"37168677742","sha1":"21949095a63e92715a70f3879343ff937e36b2c5"},"sequence_id":"2","etag":"2","sha1":"21949095a63e92715a70f3879343ff937e36b2c5","name":"Verbiage Issues.docx"},{"type":"file","id":"37242823238","file_version":{"type":"file_version","id":"36887814942","sha1":"cbe99876d860bcb94934a9dea861ff0ee903848b"},"sequence_id":"2","etag":"2","sha1":"cbe99876d860bcb94934a9dea861ff0ee903848b","name":"Veterans Folder Structure_final.xlsx"},{"type":"file","id":"37488185102","file_version":{"type":"file_version","id":"37168680014","sha1":"5dcb32930fd1e179bf60ba7116d50a58cfed5f93"},"sequence_id":"2","etag":"2","sha1":"5dcb32930fd1e179bf60ba7116d50a58cfed5f93","name":"viewinvitation-nullpoint.JPG"},{"type":"file","id":"37488184122","file_version":{"type":"file_version","id":"37168678862","sha1":"b31fc65a79e01baeef515d46899066b7febee394"},"sequence_id":"2","etag":"2","sha1":"b31fc65a79e01baeef515d46899066b7febee394","name":"Visible.png"}],"offset":0,"limit":100,"order":[{"by":"type","direction":"ASC"},{"by":"name","direction":"ASC"}]}';
                bxerr.Type__c = 'EE';
                bxerr.Status__c = 'Error';  
               OppList.add(bxerr) ;   
              
              insert  OppList;

            
            BoxDuplicateEEfolderMigrationBatch  bfb = new BoxDuplicateEEfolderMigrationBatch(1);
            Database.BatchableContext BC;
            
            Box__c testBox = new Box__c (BoxAccess_Token__c='sdgagfsgdgs2351254',Boxrefresh_token__c ='fbsdjjshvvjdfyugfdshag67324',Boxclient_Id__c ='12334asd',Boxclient_Secret__c='dsgzdfagadfh');
           insert testBox;
            
            bfb.start(bc);
            
            Test.startTest();
            Test.setMock(HttpCalloutMock.class, new BoxApiControllerRecover_mock_error());
            bfb.execute(bc,OppList);
            bfb.finish(bc);
            Test.stopTest();
    }
  
}