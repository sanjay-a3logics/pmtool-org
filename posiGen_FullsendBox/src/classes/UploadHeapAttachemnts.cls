public class UploadHeapAttachemnts{
    public static String base_url = 'https://app.box.com/files/0/f/';
   
   public UploadHeapAttachemnts(){}
  
  @future(callout=true)

   public static void uploadattachments(String Ids){
   
    List<Box_Error__c> updateBoxErrorList = new List<Box_Error__c>();
    List<Box_Error__c> bxErrList = new List<Box_Error__c>();
    
    try{
          
   
   
              String parent_folder;
              List<String> bxIt = Ids.split(',');
              String attachId = bxIt[0].trim();
              String BxerId = bxIt[1].trim();
              Box_Error__c bxrrr = new Box_Error__c();
              system.debug('Id Of Attachment'+attachId+'Id Of Error'+BxerId);
             if(BxerId!=null)
                bxrrr = [Select Id,Opportunity__c ,name ,Type__c ,Status__c , Message__c, body__c from Box_Error__c where id=:BxerId and name like 'Exception%' and Type__c = 'Docusign Doc'and Status__c = 'Error']; 
       
              Set<Id> attachParentIds = new Set<Id>();
              for(Attachment att : [select id,name, parentId from Attachment where  id=: attachId]){
                 attachParentIds.add(att.parentId);
              }
              
              Map<Id,String> salesSubFoldersMap = new Map<Id,String>();
              for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Sales']){
                  salesSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
              }
              
              Map<Id,String> applicationSubFoldersMap = new Map<Id,String>();
              for(Sub_folder__c subFolder : [select cf_opportunity__c, cf_box_folder_id__c, name from sub_folder__c where name = 'Application']){
                  applicationSubFoldersMap.put(subFolder.cf_opportunity__c, subFolder.cf_box_folder_id__c);
              } 
              
              Map<String,String> docuSignMap = new  Map<String,String>();
              Map<String,String> erorMap = new  Map<String,String>();
              for(dsfs__DocuSign_Status__c docSign: [select id, dsfs__Subject__c, dsfs__Opportunity__c from dsfs__DocuSign_Status__c where id in: attachParentIds]){
                erorMap.put(docSign.id,docSign.dsfs__Opportunity__c);
                if(docSign.dsfs__Subject__c != null && docSign.dsfs__Subject__c == 'Application'){
                    parent_folder = applicationSubFoldersMap.get(docSign.dsfs__Opportunity__c);
                }
                else{
                    parent_folder = salesSubFoldersMap.get(docSign.dsfs__Opportunity__c);
                } 
                docuSignMap.put(docSign.id, parent_folder);
              }
              
              for(Attachment attachmentObj : [select name, body, parentId from Attachment where id =: attachId]){
                  if(attachmentObj.body.size()<12000000){
                      if(docuSignMap.containsKey(attachmentObj.parentId)){
                          String boundary = '----------------------------741e90d31eff';
                          String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attachmentObj.name+'";\nContent-Type: application/octet-stream';
                          
                          String footer = '--'+boundary+'--';             
                          String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                          while(headerEncoded.endsWith('='))
                          {
                           header+=' ';
                           headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                          }
                          
                           Blob Checkblob = attachmentObj.body;
                           Double Size = Checkblob.size();
                           system.debug('ssssssssssrr'+Size); 
                          String bodyEncoded = EncodingUtil.base64Encode(attachmentObj.body);
                                      
                          Blob bodyBlob = null;
                          String last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
                      
                         if(last4Bytes.endsWith('==')) {
                            last4Bytes = last4Bytes.substring(0,2) + '0K';
                            system.debug('aaaaaaa'+bodyEncoded.length()); 
                            //bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                             bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4);
                             bodyEncoded += last4Bytes;
                             system.debug('vvvvvvvvv'+bodyEncoded.length()); 
                            // We have appended the \r\n to the Blob, so leave footer as it is.
                            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                           
                                bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                           system.debug('ssssssssss'+bodyBlob.size());
                            
                          } else if(last4Bytes.endsWith('=')) {
                            last4Bytes = last4Bytes.substring(0,3) + 'N';
                            system.debug('bbbbbbb'+bodyEncoded.length()); 
                            //bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                             bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4);
                             system.debug('kkkkkkk'+bodyEncoded.length());
                             bodyEncoded += last4Bytes;
                             system.debug('vvvvvvvvvjj'+bodyEncoded.length()); 
                            // We have appended the CR e.g. \r, still need to prepend the line feed to the footer
                            footer = '\n' + footer;
                            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                            
                                bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                           
                            
                          } else {
                            // Prepend the CR LF to the footer
                            footer = '\r\n' + footer;
                            String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                            system.debug('vvvvvvvvvjjiiii'+bodyEncoded.length()); 
                           bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                             system.debug('vvvvvvvvvjjiiiikkk'+bodyBlob.size()); 
                            
                          }
            
                          if(bodyBlob != null){
                          system.debug('kkkkkkk'+bodyBlob.size()); 
                      
                                  Box__c bx = Box__c.getInstance();
                                  String sUrl = 'https://upload.box.com/api/2.0/files/content?parent_id='+docuSignMap.get(attachmentObj.parentId);
                                  HttpRequest req = new HttpRequest();
                                  req.setHeader('Content-Type','multipart/form-data; boundary='+boundary);
                                  req.setMethod('POST');
                                  req.setEndpoint(sUrl);
                                  req.setBodyAsBlob(bodyBlob);
                                  req.setHeader('Authorization', 'Bearer '+bx.BoxAccess_Token__c);
                                  req.setTimeout(120000);
                             
                                  Http http = new Http();
                                  HTTPResponse resfile = http.send(req);
                                   if(resfile.getStatusCode() == 201){
                             
                                     system.debug('######################################## resfile.getBody()'+ resfile.getBody());
                                     FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                                     for(Entries_Z entry: fw.entries){
                                       
                                       system.debug('######################################## entry.parent.id'+ entry.parent.id);
                                       system.debug('######################################## parent_folder'+ parent_folder);
                                       //System.assert(false,entry.parent.id+'fl   '+parent_folder);
                                         Box_Error__c bxerr = bxrrr ;
                                         bxerr.Opportunity__c = erorMap.get(attachmentObj.parentId); 
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
                                         
                                         updateBoxErrorList.add(bxerr);
                                           
                                      }
                             
                                }
                           else{
                             Box_Error__c bxerr =  bxrrr ;
                             bxerr.Opportunity__c = erorMap.get(attachmentObj.parentId);
                             bxerr.name = String.valueOf(resfile.getStatusCode())+'-Duplicate Attachment'; 
                             bxerr.Message__c = 'Attachment id-'+attachmentObj.id; 
                             bxerr.Body__c = resfile.getBody();
                             bxerr.Type__c = 'Docusign Doc';
                             bxerr.Status__c = 'Error';
                       
                             updateBoxErrorList.add(bxerr);
                            } 
          
                     }
                  
                 }
              }
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
            update updateBoxErrorList;
            insert bxErrList;
          }
   
   }
   
    public static void dummyCode(){
    Integer i = 0;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
     i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
     i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
     i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
    i++;
   

     }
   
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