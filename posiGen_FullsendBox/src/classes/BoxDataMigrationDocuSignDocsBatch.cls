public with sharing class BoxDataMigrationDocuSignDocsBatch implements Database.Batchable<Sobject>,Database.AllowsCallouts, Database.Stateful{
  
  public String base_url = 'https://app.box.com/files/0/f/';
  public Integer record_count = 0; 
  public Integer record_count_stop = 0;
  
  public BoxDataMigrationDocuSignDocsBatch(Integer record_count_stop){
    this.record_count_stop = record_count_stop;
  } 
  
  public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('select id, name from opportunity where id not in (select Opportunity__c from box_error__c where Type__c =\'Docusign Doc\')');
  }
    
    public void execute(Database.BatchableContext BC, List<Opportunity> OppList){
      List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
       try{
         
         Set<Id> OppIds = new Set<Id>();
         Set<Id> docuSignSet = new Set<Id>();   
            for(Opportunity Opp : OppList){
                OppIds.add(Opp.Id);
            }
            
            Map<String,List<dsfs__DocuSign_Status__c>> docuSignMap = new  Map<String,List<dsfs__DocuSign_Status__c>>();
            for(dsfs__DocuSign_Status__c docSign: [select id, dsfs__Subject__c, dsfs__Opportunity__c from dsfs__DocuSign_Status__c where dsfs__Opportunity__c in: oppIds]){
                if(!docuSignMap.containsKey(docSign.dsfs__Opportunity__c)){
                    docuSignMap.put(docSign.dsfs__Opportunity__c, new List<dsfs__DocuSign_Status__c>());
                }
                docuSignMap.get(docSign.dsfs__Opportunity__c).add(docSign);
                docuSignSet.add(docSign.id);
            }
            
            //system.debug('######################################## docuSignMap '+docuSignMap );
            // system.debug('######################################## docuSignSet '+docuSignSet);
            
            Map<String,List<Attachment>> DocusignAttachmentsMap = new Map<String,List<Attachment>>();
            for(Attachment DocusignAttachment: [select name, body, parentId from Attachment where parentId in: docuSignSet]){
                if(Limits.getHeapSize()<12000000){ 
                    if(!DocusignAttachmentsMap.containsKey(DocusignAttachment.parentId)){
                       
                         DocusignAttachmentsMap.put(DocusignAttachment.parentId, new List<Attachment>());
                         
                    }
                    DocusignAttachmentsMap.get(DocusignAttachment.parentId).add(DocusignAttachment);
                 }
               else{
                       Box_Error__c bxerr = new Box_Error__c();
                       bxerr.Opportunity__c = null; 
                       bxerr.name = 'Exception'; 
                       bxerr.Message__c = 'Attachment id-'+DocusignAttachment.id; 
                       bxerr.Body__c = 'Heap Limit Exception';
                       bxerr.Type__c = 'Docusign Doc';
                       bxerr.Status__c = 'Error';
                       bxErrList.add(bxerr);
                  }
            }
            
            system.debug('######################################## DocusignAttachmentsMap  '+DocusignAttachmentsMap );

            Map<Id,String> salesSubFoldersMap = new Map<Id,String>();
            for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Sales' and cf_opportunity__c in: oppIds]){
                salesSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
            }
            
            system.debug('######################################## salesSubFoldersMap '+salesSubFoldersMap );

            Map<Id,String> applicationSubFoldersMap = new Map<Id,String>();
            for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Application' and cf_opportunity__c in: oppIds]){
                applicationSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
            } 
            
            system.debug('######################################## applicationSubFoldersMap '+applicationSubFoldersMap );
            
            Box__c bx = Box__c.getInstance();
            
            for(Id oppId: oppIds){
                system.debug('######################################## oppId'+oppId);
                
                String parent_folder;
               if(docuSignMap.containsKey(oppId)){
               for(dsfs__DocuSign_Status__c docuSignStatus : docuSignMap.get(oppId)){
                    
                    String docuSignStatusSubject = docuSignStatus.dsfs__Subject__c;
                    if(docuSignStatusSubject != null && docuSignStatusSubject != ''){
                        docuSignStatusSubject = docuSignStatusSubject.trim();
                    }
                    
                    if(docuSignStatusSubject == 'Application'){
                        parent_folder = applicationSubFoldersMap.get(oppId);
                    }
                    else{
                        parent_folder = salesSubFoldersMap.get(oppId);
                    } 
                
                 
                
                 //system.debug('######################################## DocusignAttachmentsList.size()'+ DocusignAttachmentsList.size());
                 if(DocusignAttachmentsMap.size() > 0 && DocusignAttachmentsMap.containsKey(docuSignStatus.id)){
                  for(Attachment attachmentObj : DocusignAttachmentsMap.get(docuSignStatus.id)){
                 
                     
                      if(Limits.getHeapSize()<12000000){
                     system.debug('######################################## attachmentObj.Name'+ attachmentObj.Name);
                      String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
                      String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attachmentObj.name+'";\nContent-Type: application/octet-stream';
                      String footer = '--'+boundary+'--';             
                      String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                      transient String bodyEncoded='';
                      transient String last4Bytes ='';
                      while(headerEncoded.endsWith('=')){
                       header+=' ';
                       headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                      }
                        Blob Checkblob = attachmentObj.body;
                        Double Size = Checkblob.size();
                        Double Incsize = (Size*36)/100;
                        Size = Size+Incsize;
                      if(Size<12000000){  
                         bodyEncoded = EncodingUtil.base64Encode(attachmentObj.body);
                       }
                      else{
                           Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = null; 
                           bxerr.name = 'Exception String'; 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                           bxerr.Body__c = 'Heap Limit Exception';
                           bxerr.Type__c = 'Docusign Doc';
                           bxerr.Status__c = 'Error';
                           bxErrList.add(bxerr);
                         } 
                     
                      Blob bodyBlob = null;
                     if(bodyEncoded!=null && bodyEncoded!='') 
                       last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
                     if(last4Bytes.endsWith('==')) {
                        last4Bytes = last4Bytes.substring(0,2) + '0K';
                     if(Limits.getHeapSize()<12000000){ 
                        bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                        }
                      else{
                           Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = oppId; 
                           bxerr.name = 'Exception BodyEncode'; 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id+' ,DocusignStatus id-'+docuSignStatus.id; 
                           bxerr.Body__c = 'Heap Limit Exception';
                           bxerr.Type__c = 'Docusign Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                          }   
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                        
                      if(Limits.getHeapSize()<12000000){
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                        }
                       else{
                           Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = oppId; 
                           bxerr.name = 'Exception Body'; 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id+' ,DocusignStatus id-'+docuSignStatus.id; 
                           bxerr.Body__c = 'Heap Limit Exception';
                           bxerr.Type__c = 'Docusign Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                         
                          } 
                      } else if(last4Bytes.endsWith('=')) {
                        last4Bytes = last4Bytes.substring(0,3) + 'N';
                        bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                        footer = '\n' + footer;
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                        
                        Blob Checkblob1 = blob.valueOf(bodyEncoded);
                        Double Size1 = Checkblob.size();
                        Double Incsize1 = (Size*36)/100;
                        Size1 = Size1+Incsize1;
                       
                       if(Size<12000000){
                          bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                        }
                       else{
                           Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = oppId; 
                           bxerr.name = 'Exception Body'; 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id+' ,DocusignStatus id-'+docuSignStatus.id; 
                           bxerr.Body__c = 'Heap Limit Exception';
                           bxerr.Type__c = 'Docusign Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                         
                          }            
                      } else {
                        footer = '\r\n' + footer;
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                       
                        //bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                      if(Limits.getHeapSize()<12000000){
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                        }
                       else{
                           Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = oppId; 
                           bxerr.name = 'Exception Body'; 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id+' ,DocusignStatus id-'+docuSignStatus.id; 
                           bxerr.Body__c = 'Heap Limit Exception';
                           bxerr.Type__c = 'Docusign Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                         
                          }   
                      }
                    if(bodyBlob!=null){  
                     system.debug('checkHeap size'+parent_folder);
                      String sUrl = 'https://upload.box.com/api/2.0/files/content?parent_id='+parent_folder;
                      HttpRequest req = new HttpRequest();
                      req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
                      req.setMethod('POST');
                      req.setEndpoint(sUrl);
                      req.setBodyAsBlob(bodyBlob);
                      req.setTimeout(60000);
                      req.setHeader('Authorization', 'Bearer '+bx.BoxAccess_Token__c);
                      req.setHeader('Content-Length',String.valueof(req.getBodyAsBlob().size()));
                      Http http = new Http();
                      HTTPResponse resfile = http.send(req);
                      
                       if(resfile.getStatusCode() == 201){
                 
                             system.debug('######################################## resfile.getBody()'+ resfile.getBody());
                             FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                             for(Entries_Z entry: fw.entries){
                               
                               system.debug('######################################## entry.parent.id'+ entry.parent.id);
                               system.debug('######################################## parent_folder'+ parent_folder);
                               if(entry.parent.id == parent_folder){
                                 
                                         Box_Error__c bxerr = new Box_Error__c();
                                 bxerr.Opportunity__c = oppId; 
                                 bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                 bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                                 bxerr.Body__c = resfile.getBody();
                                 bxerr.Type__c = 'Docusign Doc';
                                 bxerr.Status__c = 'Success';
                                 
                              // constructing manual url
                                 String manual_url = base_url;
                                 manual_url += parent_folder;
                                 manual_url += '/1/';
                                 manual_url += 'f_'+entry.id;
                                 
                                 bxerr.Manual_Url__c = manual_url;
                                 
                                 system.debug('######################################## manual_url'+ manual_url);
                                 
                                 bxErrList.add(bxerr);
                               }
                               else{
                                 Box_Error__c bxerr = new Box_Error__c();
                                 bxerr.Opportunity__c = oppId; 
                                 bxerr.name = String.valueOf(resfile.getStatusCode()); 
                                 bxerr.Message__c = 'Parent not matched for attachment-'+attachmentObj.id; 
                                 bxerr.Body__c = resfile.getBody();
                                 bxerr.Type__c = 'Docusign Doc';
                                 bxerr.Status__c = 'Error';
                           
                                 bxErrList.add(bxerr);
                               
                               }
                             }
                       }
                       else{
                            Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = oppId; 
                           bxerr.name = String.valueOf(resfile.getStatusCode()); 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                           bxerr.Body__c = resfile.getBody();
                           bxerr.Type__c = 'Docusign Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                      }
                    }
                   else
                      {
                           Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = oppId; 
                           bxerr.name = 'Exception blob'; 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id+' ,DocusignStatus id-'+docuSignStatus.id; 
                           bxerr.Body__c = 'Heap Limit Exception';
                           bxerr.Type__c = 'Docusign Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                   
                      }                      
                  }
                  else{
                           Box_Error__c bxerr = new Box_Error__c();
                           bxerr.Opportunity__c = oppId; 
                           bxerr.name = 'Exception'; 
                           bxerr.Message__c = 'Attachment id-'+attachmentObj.id+' ,DocusignStatus id-'+docuSignStatus.id; 
                           bxerr.Body__c = 'Heap Limit Exception';
                           bxerr.Type__c = 'Docusign Doc';
                           bxerr.Status__c = 'Error';
                     
                           bxErrList.add(bxerr);
                  }
                 }
                 }
                else{
                  
                 Box_Error__c bxerr = new Box_Error__c();
                 bxerr.Opportunity__c = oppId; 
                 bxerr.name = 'Attachment'; 
                 bxerr.Message__c = 'No attachment found'; 
                 bxerr.Body__c = '';
                 bxerr.Type__c = 'Docusign Doc';
                 bxerr.Status__c = 'Empty';
           
                 bxErrList.add(bxerr);
                }
              }
              }
              else{
                  Box_Error__c bxerr = new Box_Error__c();
                  bxerr.Opportunity__c = oppId; 
                  bxerr.name = 'Attachment'; 
                  bxerr.Message__c = 'No Docusign record found'; 
                  bxerr.Body__c = '';
                  bxerr.Type__c = 'Docusign Doc';
                  bxerr.Status__c = 'Empty';
           
                  bxErrList.add(bxerr);
              }  
            }
            
            record_count += OppList.size();
            if(record_count == record_count_stop){
               system.debug('######################################## job aborted record_count is'+ record_count);
               System.abortJob(BC.getJobId());
            }
       }
       catch(Exception e){
        system.debug('######################################## Exception '+ e.getMessage());
        system.debug('######################################## Exception '+ e.getStackTraceString());
         Box_Error__c bxerr = new Box_Error__c();
         bxerr.name = 'Exception';
         bxerr.Status__c = 'Error';
         bxerr.Type__c = 'Docusign Doc'; 
         bxerr.Message__c = e.getMessage(); 
         bxerr.Body__c = e.getStackTraceString();
         
         bxErrList.add(bxerr);
         
       }
       
       finally{
         insert bxErrList;
       }
    }
    
    public void finish(Database.BatchableContext BC){}
    
    public class FileWrapper {
    public Integer total_count;
    public List<Entries_Z> entries;
  }
  
  public class Parent {
    public String type;
    public String id;
    public String sequence_id;
    public String etag;
    public String name;
  }


  public class Entries_Z {
    public String type;
    public String id;
    public String sequence_id;
    public String etag;
    public String sha1;
    public String name;
    public String description;
    public Integer size;
    public String created_at;
    public String modified_at;
    public Object trashed_at;
    public Object purged_at;
    public String content_created_at;
    public String content_modified_at;
    public Object shared_link;
    public Parent parent;
    public String item_status;
  }
}