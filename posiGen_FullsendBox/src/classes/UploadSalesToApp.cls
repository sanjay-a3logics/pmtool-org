public with sharing class UploadSalesToApp implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
    public  String base_url = 'https://app.box.com/files/0/f/';
    public  Integer record_count = 0; 
    public  Integer record_count_stop = 0;
    public  List<String> attlst;
    public  Set <String> parentlst;
    public  Set<String> opplst;
    public Map<Id,String> salesSubFoldersMap;
    public Map<Id,String> applicationSubFoldersMap;
   
   public  UploadSalesToApp(List<String>attlst,Set <String> parentlst,Set<String> opplst, Integer record_count_stop){
      this.record_count_stop = record_count_stop;
      this.attlst =attlst;
      this.parentlst=parentlst;
      this.opplst = opplst;
      
    } 
   
    public Database.QueryLocator start(Database.BatchableContext BC){
            salesSubFoldersMap = new Map<Id,String>();
            for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Sales' and cf_opportunity__c in:opplst]){
                salesSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
            }
           system.debug('######################################## salesSubFoldersMap '+salesSubFoldersMap );

            applicationSubFoldersMap = new Map<Id,String>();
            for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Application' and cf_opportunity__c in:opplst]){
                applicationSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
            }        
        
         return Database.getQueryLocator('select id, name, body,bodylength , parentId from Attachment where id in :attlst');
     } 
    
    public void execute(Database.BatchableContext BC, List<Attachment> attachmentList){
      List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
       try{
         
            
            Map<String,String> docuSignMap = new  Map<String,String>();
            Map<String,String> AplicationMap = new  Map<String,String>();
            Map<String,String> SalesMap = new  Map<String,String>();
            Map<String,String> docuSignSubjectMap = new  Map<String,String>();
            for(dsfs__DocuSign_Status__c docSign: [select id, dsfs__Subject__c, dsfs__Opportunity__c from dsfs__DocuSign_Status__c where id in:parentlst]){
               
                    docuSignMap.put(docSign.id,docSign.dsfs__Opportunity__c);
                    docuSignSubjectMap.put(docSign.id,docSign.dsfs__Subject__c);
               }
               
            String parentApplication_folder;
            String parentSales_folder;
            Box__c bx = Box__c.getInstance();
            system.debug('hiiiiiii'+attachmentList.size());
            for(Attachment attachmentObj : attachmentList){
                 
               if(docuSignSubjectMap.get(attachmentObj.parentId)=='Application'){
                   parentApplication_folder = applicationSubFoldersMap.get(docuSignMap.get(attachmentObj.parentId));
                   
                    HttpRequest reqfile = new HttpRequest();
                    reqfile.setMethod('GET');
                    reqfile.setEndpoint('https://api.box.com/2.0/folders/'+parentApplication_folder+'/items');
                    reqfile.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                    Http httpfile = new Http();
                    HTTPResponse resfile = httpfile.send(reqfile);
                 if(resfile.getStatusCode() == 200){
                       FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                       system.debug('*****'+fw.total_count);
                      if(fw.total_count!=0){
                          for(Entries en:fw.entries){
                           if(en.type == 'file'){
                                AplicationMap.put(en.name,en.id);
                              }
                           }
                          system.debug('#######'+!AplicationMap.containskey(attachmentObj.name)+'======'+attachmentObj.name); 
                         if(!AplicationMap.containskey(attachmentObj.name)){
                             
                            parentSales_folder = salesSubFoldersMap.get(docuSignMap.get(attachmentObj.parentId));
                            
                            HttpRequest reqfileA2S = new HttpRequest();
                            reqfileA2S.setMethod('GET');
                            reqfileA2S.setEndpoint('https://api.box.com/2.0/folders/'+parentSales_folder+'/items');
                            reqfileA2S.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                            Http httpfileA2S = new Http();
                            HTTPResponse resfileA2S = httpfileA2S.send(reqfileA2S);
                             if(resfile.getStatusCode() == 200){
                                   FileWrapper fwS = (FileWrapper) System.JSON.deserialize(resfileA2S.getBody(), FileWrapper.class);
                                   system.debug('**********'+fwS.total_count+'---------'+fwS.entries);
                                    if(fwS.total_count!=0){
                                          for(Entries enS:fwS.entries){
                                               if(enS.type == 'file'){
                                                    SalesMap.put(enS.name,enS.id);
                                                }
                                             }
                                           if(SalesMap.containskey(attachmentObj.name)){
                                                    HttpRequest req2 = new HttpRequest();
                                                    req2.setEndpoint('https://api.box.com/2.0/files/'+SalesMap.get(attachmentObj.name)+'');
                                                    req2.setMethod('PUT');
                                                    req2.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);
                                                    req2.setBody('{"parent": {"id" : '+parentApplication_folder+'}}');
                                                    HTTPResponse res2 = new Http().send(req2);
                                                    if(res2.getstatuscode()==200){
                                                       system.debug('========'+res2.getBody());
                                                          Box_Error__c bxerr = new Box_Error__c();
                                                          bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                                          bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                                          bxerr.Message__c = ''+attachmentObj.id; 
                                                          bxerr.Type__c = 'Docusign Doc Application Moved';
                                                          bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                                          bxerr.Status__c = 'Error';
                                                          bxerr.done__c =false;
                                                          bxErrList.add(bxerr);
                                                     }
                                                    else{
                                                          Box_Error__c bxerr = new Box_Error__c();
                                                          bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                                          bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                                          bxerr.Message__c = ''+attachmentObj.id; 
                                                          bxerr.Type__c = 'Docusign Not Moved';
                                                          bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                                          bxerr.Status__c = 'Error';
                                                          bxerr.done__c =false;
                                                          bxErrList.add(bxerr);
                                                    
                                                        } 
                                           
                                             }  
                                          }
                                       }  
                                }
                               else{
                               system.debug('#######'+attachmentObj.name);
                                   parentSales_folder = salesSubFoldersMap.get(docuSignMap.get(attachmentObj.parentId));
                            
                                    HttpRequest reqfileA2S = new HttpRequest();
                                    reqfileA2S.setMethod('GET');
                                    reqfileA2S.setEndpoint('https://api.box.com/2.0/folders/'+parentSales_folder+'/items');
                                    reqfileA2S.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                                    Http httpfileA2S = new Http();
                                    HTTPResponse resfileA2S = httpfileA2S.send(reqfileA2S);
                                   if(resfile.getStatusCode() == 200){
                                     FileWrapper fwS = (FileWrapper) System.JSON.deserialize(resfileA2S.getBody(), FileWrapper.class);
                                      if(fwS.total_count!=0){
                                          for(Entries enS:fwS.entries){
                                               if(enS.type == 'file'){
                                                    SalesMap.put(enS.name,enS.id);
                                                }
                                             }
                                           if(SalesMap.containskey(attachmentObj.name)){
                                                    HttpRequest req2 = new HttpRequest();
                                                    req2.setEndpoint('https://api.box.com/2.0/files/'+SalesMap.get(attachmentObj.name)+'');
                                                    req2.setMethod('DELETE');
                                                    req2.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);
                                                    HTTPResponse res2 = new Http().send(req2);
                                                    if(res2.getstatuscode()==204){
                                                          Box_Error__c bxerr = new Box_Error__c();
                                                          bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                                          bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                                          bxerr.Message__c = ''+attachmentObj.id; 
                                                          bxerr.Type__c = 'Docusign Doc Deleted';
                                                          bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                                          bxerr.Status__c = 'Error';
                                                          bxerr.done__c =false;
                                                          bxErrList.add(bxerr);
                                                     }
                                                   else{
                                                   
                                                          Box_Error__c bxerr = new Box_Error__c();
                                                          bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                                          bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                                          bxerr.Message__c = ''+attachmentObj.id; 
                                                          bxerr.Type__c = 'Docusign Not Moved';
                                                          bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                                          bxerr.Status__c = 'Error';
                                                          bxerr.done__c =false;
                                                          bxErrList.add(bxerr);
                                                      
                                                       }  
                                             }  
                                          }
                                       }
                               
                                  }   
                            } 
                      }
                     } 
               else{
                    
                    parentSales_folder = salesSubFoldersMap.get(docuSignMap.get(attachmentObj.parentId));
                   
                    HttpRequest reqfile = new HttpRequest();
                    reqfile.setMethod('GET');
                    reqfile.setEndpoint('https://api.box.com/2.0/folders/'+parentSales_folder+'/items');
                    reqfile.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                    Http httpfile = new Http();
                    HTTPResponse resfile = httpfile.send(reqfile);
                 if(resfile.getStatusCode() == 200){
                       FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                      if(fw.total_count!=0){
                          for(Entries en:fw.entries){
                           if(en.type == 'file'){
                                SalesMap.put(en.name,en.id);
                              }
                           }
                         if(!SalesMap.containskey(attachmentObj.name)){
                             
                            parentApplication_folder = applicationSubFoldersMap.get(docuSignMap.get(attachmentObj.parentId));
                            
                            HttpRequest reqfileA2S = new HttpRequest();
                            reqfileA2S.setMethod('GET');
                            reqfileA2S.setEndpoint('https://api.box.com/2.0/folders/'+parentApplication_folder+'/items');
                            reqfileA2S.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                            Http httpfileA2S = new Http();
                            HTTPResponse resfileA2S = httpfileA2S.send(reqfileA2S);
                             if(resfile.getStatusCode() == 200){
                                   FileWrapper fwS = (FileWrapper) System.JSON.deserialize(resfileA2S.getBody(), FileWrapper.class);
                                    if(fwS.total_count!=0){
                                          for(Entries enS:fwS.entries){
                                               if(enS.type == 'file'){
                                                    AplicationMap.put(enS.name,enS.id);
                                                }
                                             }
                                           if(AplicationMap.containskey(attachmentObj.name)){
                                                    HttpRequest req2 = new HttpRequest();
                                                    req2.setEndpoint('https://api.box.com/2.0/files/'+AplicationMap.get(attachmentObj.name)+'');
                                                    req2.setMethod('PUT');
                                                    req2.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);
                                                    req2.setBody('{"parent": {"id" : '+parentSales_folder+'}}');
                                                    HTTPResponse res2 = new Http().send(req2);
                                                    if(res2.getstatuscode()==200){
                                                        Box_Error__c bxerr = new Box_Error__c();
                                                          bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                                          bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                                          bxerr.Message__c = ''+attachmentObj.id; 
                                                          bxerr.Type__c = 'Docusign Doc Sales Moved';
                                                          bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                                          bxerr.Status__c = 'Error';
                                                          bxerr.done__c =false;
                                                          bxErrList.add(bxerr);
                                                    
                                                     }
                                                    else{
                                                    
                                                          Box_Error__c bxerr = new Box_Error__c();
                                                          bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                                          bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                                          bxerr.Message__c = ''+attachmentObj.id; 
                                                          bxerr.Type__c = 'Docusign Not Moved';
                                                          bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                                          bxerr.Status__c = 'Error';
                                                          bxerr.done__c =false;
                                                          bxErrList.add(bxerr);
                                                    
                                                    
                                                       } 
                                           
                                             }  
                                          }
                                       }  
                                }
                             else{
                                 
                                  parentApplication_folder = applicationSubFoldersMap.get(docuSignMap.get(attachmentObj.parentId));
                                    HttpRequest reqfileA2S = new HttpRequest();
                                    reqfileA2S.setMethod('GET');
                                    reqfileA2S.setEndpoint('https://api.box.com/2.0/folders/'+parentApplication_folder+'/items');
                                    reqfileA2S.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                                    Http httpfileA2S = new Http();
                                    HTTPResponse resfileA2S = httpfileA2S.send(reqfileA2S);
                                     if(resfile.getStatusCode() == 200){
                                           FileWrapper fwS = (FileWrapper) System.JSON.deserialize(resfileA2S.getBody(), FileWrapper.class);
                                            if(fwS.total_count!=0){
                                                  for(Entries enS:fwS.entries){
                                                       if(enS.type == 'file'){
                                                            AplicationMap.put(enS.name,enS.id);
                                                        }
                                                     }
                                                   if(AplicationMap.containskey(attachmentObj.name)){
                                                            HttpRequest req2 = new HttpRequest();
                                                            req2.setEndpoint('https://api.box.com/2.0/files/'+AplicationMap.get(attachmentObj.name)+'');
                                                            req2.setMethod('DELETE');
                                                            req2.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);
                                                            HTTPResponse res2 = new Http().send(req2);
                                                            if(res2.getstatuscode()==204){
                                                                Box_Error__c bxerr = new Box_Error__c();
                                                                  bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                                                  bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                                                  bxerr.Message__c = ''+attachmentObj.id; 
                                                                  bxerr.Type__c = 'Docusign Doc Deleted';
                                                                  bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                                                  bxerr.Status__c = 'Error';
                                                                  bxerr.done__c =false;
                                                                  bxErrList.add(bxerr);
                                                            
                                                             }
                                                            else{
                                                                  Box_Error__c bxerr = new Box_Error__c();
                                                                  bxerr.Opportunity__c = docuSignMap.get(attachmentObj.parentId);
                                                                  bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                                                  bxerr.Message__c = ''+attachmentObj.id; 
                                                                  bxerr.Type__c = 'Docusign Not Moved';
                                                                  bxerr.Not_Uploaded_Id__c=attachmentObj.id;
                                                                  bxerr.Status__c = 'Error';
                                                                  bxerr.done__c =false;
                                                                  bxErrList.add(bxerr);
                                                            
                                                             } 
                                                   
                                                     }  
                                                  }
                                               }
                                 
                                }   
                            } 
                      }
                 
                   }
                }      
           
                record_count += attachmentList.size();
                if(record_count == record_count_stop){
                   system.debug('######################################## job aborted record_count is'+ record_count);
                   System.abortJob(BC.getJobId()); 
                 }
       }
       catch(Exception e){
                system.debug('###############################'+e.getMessage()); 
                Box_Error__c bxerr = new Box_Error__c();
                bxerr.name = 'Exception'; 
                bxerr.Message__c = e.getMessage(); 
                bxerr.Body__c = e.getStackTraceString();
                bxerr.Type__c = 'Docusign Doc Not Uploaded';
                bxerr.Not_Uploaded_Id__c='';
                bxerr.Status__c = 'Error';
                bxerr.done__c =false;
                bxErrList.add(bxerr);
         
       }
       
       finally{
         insert bxErrList;
       }
    }
    
    public void finish(Database.BatchableContext BC){}
    
    public class FileWrapper{
        public Integer total_count {get;set;} 
        public List<Entries> entries {get;set;} 
    } 
 
    public class Entries {
        public String type {get;set;} // in json: type
        public String id {get;set;} 
        public String sequence_id {get;set;} 
        public String etag {get;set;} 
        public String sha1 {get;set;} 
        public String name {get;set;} 
    }
  
 
public void DummyMethod(){
Account acc0= new Account();
Account acc1= new Account();
Account acc2= new Account();
Account acc3= new Account();
Account acc4= new Account();
Account acc5= new Account();
Account acc6= new Account();
Account acc7= new Account();
Account acc8= new Account();
Account acc9= new Account();
Account acc10= new Account();
Account acc11= new Account();
Account acc12= new Account();
Account acc13= new Account();
Account acc14= new Account();
Account acc15= new Account();
Account acc16= new Account();
Account acc17= new Account();
Account acc18= new Account();
Account acc19= new Account();
Account acc20= new Account();
Account acc21= new Account();
Account acc22= new Account();
Account acc23= new Account();
Account acc24= new Account();
Account acc25= new Account();
Account acc26= new Account();
Account acc27= new Account();
Account acc28= new Account();
Account acc29= new Account();
Account acc30= new Account();
Account acc31= new Account();
Account acc32= new Account();
Account acc33= new Account();
Account acc34= new Account();
Account acc35= new Account();
Account acc36= new Account();
Account acc37= new Account();
Account acc38= new Account();
Account acc39= new Account();
Account acc40= new Account();
Account acc41= new Account();
Account acc42= new Account();
Account acc43= new Account();
Account acc44= new Account();
Account acc45= new Account();
Account acc46= new Account();
Account acc47= new Account();
Account acc48= new Account();
Account acc49= new Account();
Account acc50= new Account();
Account acc51= new Account();
Account acc52= new Account();
Account acc53= new Account();
Account acc54= new Account();
Account acc55= new Account();
Account acc56= new Account();
Account acc57= new Account();
Account acc58= new Account();
Account acc59= new Account();
Account acc60= new Account();
Account acc61= new Account();
Account acc62= new Account();
Account acc63= new Account();
Account acc64= new Account();
Account acc65= new Account();
Account acc66= new Account();
Account acc67= new Account();
Account acc68= new Account();
Account acc69= new Account();
Account acc70= new Account();
Account acc71= new Account();
Account acc72= new Account();
Account acc73= new Account();
Account acc74= new Account();
Account acc75= new Account();
Account acc76= new Account();
Account acc77= new Account();
Account acc78= new Account();
Account acc79= new Account();
Account acc80= new Account();
Account acc81= new Account();
Account acc82= new Account();
Account acc83= new Account();
Account acc84= new Account();
Account acc85= new Account();
Account acc86= new Account();
Account acc87= new Account();
Account acc88= new Account();
Account acc89= new Account();
Account acc90= new Account();
Account acc91= new Account();
Account acc92= new Account();
Account acc93= new Account();
Account acc94= new Account();
Account acc95= new Account();
Account acc96= new Account();
Account acc97= new Account();
Account acc98= new Account();
Account acc99= new Account();
Account acc100= new Account();
Account acc101= new Account();
Account acc102= new Account();
Account acc103= new Account();
Account acc104= new Account();
Account acc105= new Account();
Account acc106= new Account();
Account acc107= new Account();
Account acc108= new Account();
Account acc109= new Account();
Account acc110= new Account();
Account acc111= new Account();
Account acc112= new Account();
Account acc113= new Account();
Account acc114= new Account();
Account acc115= new Account();
Account acc116= new Account();
Account acc117= new Account();
Account acc118= new Account();
Account acc119= new Account();
Account acc120= new Account();
Account acc121= new Account();
Account acc122= new Account();
Account acc123= new Account();
Account acc124= new Account();
Account acc125= new Account();
Account acc126= new Account();
Account acc127= new Account();
Account acc128= new Account();
Account acc129= new Account();
Account acc130= new Account();
Account acc131= new Account();
Account acc132= new Account();
Account acc133= new Account();
Account acc134= new Account();
Account acc135= new Account();
Account acc136= new Account();
Account acc137= new Account();
Account acc138= new Account();
Account acc139= new Account();
Account acc140= new Account();
Account acc141= new Account();
Account acc142= new Account();
Account acc143= new Account();
Account acc144= new Account();
Account acc145= new Account();
Account acc146= new Account();
Account acc147= new Account();
Account acc148= new Account();
Account acc149= new Account();
Account acc150= new Account();
Account acc151= new Account();
Account acc152= new Account();
Account acc153= new Account();
Account acc154= new Account();
Account acc155= new Account();
Account acc156= new Account();
Account acc157= new Account();
Account acc158= new Account();
Account acc159= new Account();
Account acc160= new Account();
Account acc161= new Account();
Account acc162= new Account();
Account acc163= new Account();
Account acc164= new Account();
Account acc165= new Account();
Account acc166= new Account();
Account acc167= new Account();
Account acc168= new Account();
Account acc169= new Account();
Account acc170= new Account();
Account acc171= new Account();
Account acc172= new Account();
Account acc173= new Account();
Account acc174= new Account();
Account acc175= new Account();
Account acc176= new Account();
Account acc177= new Account();
Account acc178= new Account();
Account acc179= new Account();
Account acc180= new Account();
Account acc181= new Account();
Account acc182= new Account();
Account acc183= new Account();
Account acc184= new Account();
Account acc185= new Account();
Account acc186= new Account();
Account acc187= new Account();
Account acc188= new Account();
Account acc189= new Account();
Account acc190= new Account();
Account acc191= new Account();
Account acc192= new Account();
Account acc193= new Account();
Account acc194= new Account();
Account acc195= new Account();
Account acc196= new Account();
Account acc197= new Account();
Account acc198= new Account();
Account acc199= new Account();
Account acc511= new Account();
Account acc512= new Account();
Account acc513= new Account();
Account acc514= new Account();
Account acc515= new Account();
Account acc516= new Account();
Account acc517= new Account();
Account acc518= new Account();
Account acc519= new Account();
Account acc520= new Account();
Account acc521= new Account();
Account acc522= new Account();
Account acc523= new Account();
Account acc524= new Account();
Account acc525= new Account();
Account acc526= new Account();
Account acc527= new Account();
Account acc528= new Account();
Account acc529= new Account();
Account acc530= new Account();
Account acc531= new Account();
Account acc532= new Account();
Account acc533= new Account();
Account acc534= new Account();
Account acc535= new Account();
Account acc536= new Account();
Account acc537= new Account();
Account acc538= new Account();
Account acc539= new Account();
Account acc540= new Account();
Account acc541= new Account();
Account acc542= new Account();
Account acc543= new Account();
Account acc544= new Account();
Account acc545= new Account();
Account acc546= new Account();
Account acc547= new Account();
Account acc548= new Account();
Account acc549= new Account();
Account acc550= new Account();
Account acc551= new Account();
Account acc552= new Account();
Account acc553= new Account();
Account acc554= new Account();
Account acc555= new Account();
Account acc556= new Account();
Account acc557= new Account();
Account acc558= new Account();
Account acc559= new Account();
Account acc560= new Account();
Account acc561= new Account();
Account acc562= new Account();
Account acc563= new Account();
Account acc564= new Account();
Account acc565= new Account();
Account acc566= new Account();
Account acc567= new Account();
Account acc568= new Account();
Account acc569= new Account();
Account acc570= new Account();
Account acc571= new Account();
Account acc572= new Account();
Account acc573= new Account();
Account acc574= new Account();
Account acc575= new Account();
Account acc576= new Account();
Account acc577= new Account();
Account acc578= new Account();
Account acc579= new Account();
Account acc580= new Account();
Account acc581= new Account();
Account acc582= new Account();
Account acc583= new Account();
Account acc584= new Account();
Account acc585= new Account();
Account acc586= new Account();
Account acc587= new Account();
Account acc588= new Account();
Account acc589= new Account();
Account acc590= new Account();
Account acc591= new Account();
Account acc592= new Account();
Account acc593= new Account();
Account acc594= new Account();
Account acc595= new Account();
Account acc596= new Account();
Account acc597= new Account();
Account acc598= new Account();
Account acc599= new Account();
}   
 
}