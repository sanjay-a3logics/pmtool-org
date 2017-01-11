public class BoxUploadAttachmentController{
   public static String base_url = 'https://app.box.com/files/0/f/'; 
   public BoxUploadAttachmentController(){}

   @future(callout=true) 
   public static void uploadAttachment(Id newParentId, string sobjectName, Set<Id> attachmentsIdSet){
   string errorType = '';
   if(sobjectName == 'Deal__c'){
         errorType  = 'Standard Doc';
     }
     else if(sobjectName == 'Attachment__c'){
         errorType  = 'Custom Doc';
     } 
   List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
      try{
       string subFolderId;
       
       Map<String,String> customErrorMap= new  Map<String,String>();
          for(Attachment__c attCustom: [select id, project__r.Deal__c from Attachment__c where id=:newParentId]){
            customErrorMap.put(attCustom.id,attCustom.project__r.Deal__c);
          }
       
       system.debug('folderIddNew'+newParentId);
       List<Sub_Folder__c> CFList =SoqlServices.getsubfolder(string.valueOf(newParentId),sobjectName);
       if(CFList.size()>0)   	
         subFolderId= CFList[0].CF_Box_Folder_Id__c;
       
       Map<String,Integer> dupNameList = new Map<String,Integer>();
       List<attachment> distinctRecords = new List<attachment>();
       List<attachment> duplicateRecords = new List<attachment>();
       Integer count = 0;
       for(Attachment oppObj:  [Select id, Name from Attachment where parentId =: newParentId]){ 
              Boolean found = false;
              
              for(Integer i=0; i< distinctRecords.size(); i++){
                    if(oppObj.name.equalsIgnoreCase(distinctRecords[i].name)){ 
                         found=true;
                        duplicateRecords.add(oppObj);
                        if(!dupNameList.containsKey(oppObj.name)){
                            dupNameList.put(oppObj.name,1);
                        }
                        Integer c = dupNameList.get(oppObj.name);
                        c++;
                        dupNameList.put(oppObj.name,c);
                    }
              }
              if(!found){
                distinctRecords.add(oppObj);
              }
       }         
       system.debug('folderId'+subFolderId);   
       for(Attachment att:  [Select id, Name, Body, parentId, contenttype from Attachment where Id in: attachmentsIdSet]){ 
         if(att.parentId != null){				
           if(att.body.size()<=8000000){				
           
            Integer namecount = dupNameList.get(att.name);
            system.debug(subFolderId+'subFolderId-------+++++++++++++++++++++-------namecount--'+namecount);  
          if(subFolderId!=null){ 
           
                if(namecount > 1){
                    BoxUploadAttachmentController.uploadDuplicateDocumnet(2,att, subFolderId, errorType, bxErrList);
                }
                else{
                    BoxUploadAttachmentController.uploadDuplicateDocumnet(1,att, subFolderId, errorType, bxErrList);
                }
           }  
            

        }
       else{
             Box_Error__c bxerr = new Box_Error__c();
             if(errorType == 'Standard Doc'){
                 bxerr.Deal__c =att.parentId; 
             }
             else if(errorType == 'Custom Doc'){
                 bxerr.Deal__c =customErrorMap.get(att.parentId); 
             }
             
             bxerr.name = 'Heap Size Exceed-Trigger'; 
             bxerr.Message__c = 'Attachment id-'+att.id; 
             bxerr.Body__c = '';
             bxerr.Type__c =errorType;
             bxerr.Status__c = 'Error';
       
             bxErrList.add(bxerr);
      
          }
        }
      }
      
     }
      catch(Exception e){
            Box_Error__c bxerr = new Box_Error__c();
            bxerr.name = 'Exception-Trigger'; 
            bxerr.Message__c = e.getMessage(); 
            bxerr.Body__c = e.getStackTraceString();
             
            bxerr.Type__c =errorType;
            
            bxerr.Status__c = 'Error';
            bxErrList.add(bxerr); 
        }
        finally{
            insert bxErrList;
        }         
    
    }
    

  public static void uploadDuplicateDocumnet(Integer count, Attachment att, String subFolderId, String errorType, List<box_error__c> bxErrList ){
  

          Map<String,String> customErrorMap= new  Map<String,String>();
          for(Attachment__c attCustom: [select id, project__r.Deal__c from Attachment__c where id=:att.parentId]){
            customErrorMap.put(attCustom.id,attCustom.project__r.Deal__c);
          }
          
          Map<String,String> docuSignErrorMap = new  Map<String,String>();
          for(dsfs__DocuSign_Status__c docSign: [select id, Deal__c from dsfs__DocuSign_Status__c where id=:att.parentid]){
            docuSignErrorMap.put(docSign.id,docSign.Deal__c);
          }

         
          String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
          String attName ='';
              system.debug('------------count------'+count);
              if(count>1){
                       string s = att.name;
                        string sext = att.contenttype;
                        string[] part = s.split('\\.');
                        string[] partext = sext.split('\\/');
                        string name = '';
                        if(part.size() > 1){
                            for(integer j=0; j<=part.size()-2;j++){
                                if(j==part.size()-2){
                                    name += part[j];    
                                }
                                else{
                                    name += part[j]+'.';
                                }
                                
                            }
                           
                            if(partext[1]==part[part.size()-1]){
                                name = name+'('+count+').'+part[part.size()-1];
                            }
                            else{
                                String extension = ''; 
                                if(partext[1] == 'plain' && part[part.size()-1] == 'txt'){
                                    extension = 'txt';
                                    name = name+'('+count+')'+'.'+extension;
                                }
                                else if(partext[1] == 'plain' && part[part.size()-1] !='txt'){
                                    extension = 'txt';
                                    name = name+'.'+part[part.size()-1]+'('+count+')'+'.'+extension;
                                }
                                else if(partext[1] == 'jpeg' && part[part.size()-1] == 'jpg'){
                                    extension = 'jpg';
                                    name = name+'('+count+')'+'.'+extension;
                                }
                                else{
                                    extension = partext[1];
                                    name = name+'('+count+')'+'.'+part[part.size()-1];
                                }
                                
                            }
                        }
                        else{
                           String extension = ''; 
                            if(partext[1] == 'plain'){
                                extension = 'txt';
                            }
                            else{
                                extension = partext[1];
                            }
                            name = s+'('+count+').'+extension;
                        }
    
                       attName =name;
                        
                }
                else{
                 
                    string name = '';
                    if(att.contenttype != null){
                        string s = att.name;
                        string sext = att.contenttype;
                        system.debug('------------att.contenttype------'+att.contenttype);
                        string[] part = s.split('\\.');
                        system.debug('------------part ------'+part );
                        string[] partext = sext.split('\\/');
                        
                        system.debug('------------partext ------'+partext );
                        if(part.size() > 1){
                            for(integer j=0; j<=part.size()-2;j++){
                                if(j==part.size()-2){
                                    name += part[j];    
                                }
                                else{
                                    name += part[j]+'.';
                                }
                            }
                            
                            if(partext[1]==part[part.size()-1]){
                               name = name+'.'+part[part.size()-1];
                            }
                            else{
                                String extension = ''; 
                                if(partext[1] == 'plain' && part[part.size()-1] == 'txt'){
                                    extension = 'txt';
                                    name = name+'.'+extension;
                                }
                                else if(partext[1] == 'plain' && part[part.size()-1] !='txt'){
                                    extension = 'txt';
                                    name = name+'.'+part[part.size()-1]+'.'+extension;
                                }
                                else if(partext[1] == 'jpeg' && part[part.size()-1] == 'jpg'){
                                    extension = 'jpg';
                                    name = name+'.'+extension;
                                }
                                else{
                                    extension = partext[1];
                                    name = name+'.'+part[part.size()-1];
                                }
                            }
                        }
                        else{
                           
                            String extension = ''; 
                            if(partext[1] == 'plain'){
                                extension = 'txt';
                            }
                            else{
                                extension = partext[1];
                            }
                            name = s+'.'+extension;
                        }
                    }
                    else{
                        name = att.name;
                    }
        
                    attName = name;
                    
                    }  
                    String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attName+'";\nContent-Type: application/octet-stream';
                    String footer = '--'+boundary+'--';
                    String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    transient String bodyEncoded='';
                    transient String last4Bytes ='';
                    while(headerEncoded.endsWith('=')){
                        header+=' ';
                        headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    }
                     bodyEncoded = EncodingUtil.base64Encode(att.body);
                       
                       Blob bodyBlob = null;
                     if(bodyEncoded!=null && bodyEncoded!='') 
                       last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
                     if(last4Bytes.endsWith('==')) {
                        last4Bytes = last4Bytes.substring(0,2) + '0K';
                    
                        bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes; 
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                      } 
                     else if(last4Bytes.endsWith('=')) {
                        last4Bytes = last4Bytes.substring(0,3) + 'N';
                        bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                        footer = '\n' + footer;
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer)); 
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                       }
                     else{
                        footer = '\r\n' + footer;
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
                      }                
                
                
                  Box__c bx = Box__c.getInstance();
                
                  HttpRequest reqfile = new HttpRequest();
                                        
                                    
                reqfile.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
                reqfile.setMethod('POST');
                reqfile.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+subFolderId);
                reqfile.setBodyAsBlob(bodyBlob);
                reqfile.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                reqfile.setHeader('Content-Length',String.valueof(reqfile.getBodyAsBlob().size()));
                
                // Send HTTP request and get HTTP response
                Http httpfile = new Http();
                HTTPResponse resfile = httpfile.send(reqfile);
                if(resfile.getStatusCode() == 201){
                    FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                     for(Entries_Z entry: fw.entries){
                
                 if(entry.parent.id == subFolderId){
                     
                     Box_Error__c bxerr = new Box_Error__c();
                     if(errorType == 'Standard Doc'){
                         bxerr.Deal__c =att.parentId; 
                     }
                     else if(errorType == 'Custom Doc'){
                         bxerr.Deal__c =customErrorMap.get(att.parentId); 
                     }
                     else if(errorType == 'Docusign Doc'){
                         bxerr.Deal__c =docuSignErrorMap.get(att.parentId); 
                     }
                     
                     
                     bxerr.name = String.valueOf(resfile.getStatusCode()); 
                     bxerr.Message__c = 'Attachment id-'+att.id; 
                     bxerr.Body__c = resfile.getBody();
                     bxerr.Type__c = errorType;
                     bxerr.Status__c = 'Success';
                     
                     // constructing manual url
                     String manual_url = base_url;
                     manual_url += subFolderId;
                     manual_url += '/1/';
                     manual_url += 'f_'+entry.id;
                     
                     bxerr.Manual_Url__c = manual_url;
                     
                    
                     
                     bxErrList.add(bxerr);
                }
                else{
                   Box_Error__c bxerr = new Box_Error__c();
                   if(errorType == 'Standard Doc'){
                         bxerr.Deal__c =att.parentId; 
                     }
                     else if(errorType == 'Custom Doc'){
                         bxerr.Deal__c =customErrorMap.get(att.parentId); 
                     }
                     else if(errorType == 'Docusign Doc'){
                         bxerr.Deal__c =docuSignErrorMap.get(att.parentId); 
                     }
                   bxerr.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr.Message__c = 'parent not match-'+att.id; 
                   bxerr.Body__c = resfile.getBody();
                   bxerr.Type__c =errorType;
                   bxerr.Status__c = 'Error';
             
                   bxErrList.add(bxerr);
            
               } 
                
      
            } 
      
        }
        else if(resfile.getStatusCode() == 409){
           
            count++;
           
            uploadDuplicateDocumnet(count, att, subFolderId, errorType, bxErrList);
        }
        else{
           Box_Error__c bxerr = new Box_Error__c();
           if(errorType == 'Standard Doc'){
                 bxerr.Deal__c =att.parentId; 
             }
             else if(errorType == 'Custom Doc'){
                 bxerr.Deal__c =customErrorMap.get(att.parentId); 
             }
             else if(errorType == 'Docusign Doc'){
                 bxerr.Deal__c =docuSignErrorMap.get(att.parentId); 
             }
           bxerr.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
           bxerr.Message__c = 'Attachment id-'+att.id; 
           bxerr.Body__c = resfile.getBody();
           bxerr.Type__c =errorType;
           bxerr.Status__c = 'Error';
     
           bxErrList.add(bxerr);
    
       }

}
 
 
 /* Author: Irfan Khan (Appcino Technologies Pvt. Ltd.)
  * Function for uploading DocuSign documents to Sales and Application folder when Trigger (AddOpportunityAttachment) will call 
  * Params:
  *     1. Name: opportunityId, Type: Id, Description: Opportunity record id 
  *     2. Name: attachmentsIdSet, Type: Set<Id>, Description: Set of attachment record id 
  */
  @future(callout=true)    
  public static void uploadDocusignDocs(Id docparentId, Set<Id> attachmentsIdSet){   
                
        system.debug(attachmentsIdSet+'############################### uploadDocusignDocs called'+docparentId); 
        List<Box_Error__c> bxErrList = new List<Box_Error__c>();
        try{		
            String subFolderId ='';
            
            Box__c bx = Box__c.getInstance();
            
               Map<String,Integer> dupNameList = new Map<String,Integer>();
               List<attachment> distinctRecords = new List<attachment>();
               List<attachment> duplicateRecords = new List<attachment>();
               Integer count = 0;
               for(Attachment oppObj:  [Select id, Name from Attachment where parentId =: docparentId]){ 
                      Boolean found = false;
                      
                      for(Integer i=0; i< distinctRecords.size(); i++){
                            if(oppObj.name.equalsIgnoreCase(distinctRecords[i].name)){ 
                                 found=true;
                                duplicateRecords.add(oppObj);
                                if(!dupNameList.containsKey(oppObj.name)){
                                    dupNameList.put(oppObj.name,1);
                                }
                                Integer c = dupNameList.get(oppObj.name);
                                c++;
                                dupNameList.put(oppObj.name,c);
                            }
                      }
                      if(!found){
                        distinctRecords.add(oppObj);
                      }
               } 
               
               system.debug('############################### dupNameList'+dupNameList);

                dsfs__DocuSign_Status__c docuSignStatus = SoqlServices.getDocusignStatus(docparentId);
                String docuSignStatusSubject = docuSignStatus.dsfs__Subject__c;
                if(docuSignStatusSubject != null && docuSignStatusSubject != ''){
                    docuSignStatusSubject = docuSignStatusSubject.trim();
                }
                
                if(docuSignStatusSubject == 'Application'){
                    Sub_folder__c subFolder = SoqlServices.getSubFolder(docuSignStatus.Deal__c,'Application');
                    subFolderId = subFolder.CF_Box_Folder_Id__c;
                }
                else{
                    Sub_folder__c subFolder = SoqlServices.getSubFolder(docuSignStatus.Deal__c,'Sales');
                    subFolderId = subFolder.CF_Box_Folder_Id__c;
                }
                
                system.debug('############################### subFolderId '+subFolderId);
                
               for(Attachment docusignAttachment : [select id, name,parentId,ContentType, body from attachment where id in: attachmentsIdSet]){
                
                   if(docusignAttachment.body.size()<=8000000){ 
                     
                        Integer namecount = dupNameList.get(docusignAttachment.name);
                        if(namecount > 1){
                            BoxUploadAttachmentController.uploadDuplicateDocumnet(2,docusignAttachment, subFolderId, 'Docusign Doc', bxErrList);
                        }
                        else{
                            BoxUploadAttachmentController.uploadDuplicateDocumnet(1,docusignAttachment, subFolderId, 'Docusign Doc', bxErrList);
                        }                   
 
                    }
                   else{
                   
                        Box_Error__c bxerr = new Box_Error__c();
                         bxerr.Deal__c = docuSignStatus.Deal__c ;
                         bxerr.name = 'Heap Size Exceed-Trigger'; 
                         bxerr.Message__c = 'Attachment id-'+docusignAttachment.id; 
                         bxerr.Body__c = '';
                         bxerr.Type__c = 'Docusign Doc';
                         bxerr.Status__c = 'Error';
                   
                         bxErrList.add(bxerr);
                      } 
                  }     

        }
        catch(Exception e){
            system.debug('###############################'+e.getMessage()); 
            Box_Error__c bxerr = new Box_Error__c();
            bxerr.name = 'Trigger-Exception'; 
            bxerr.Message__c = e.getMessage(); 
            bxerr.Body__c = e.getStackTraceString();
            bxerr.Type__c = 'Docusign Doc';
            bxerr.Status__c = 'Error';
            bxErrList.add(bxerr); 
        }
        finally{   
            insert bxErrList;
        }
   }
   
  @future(callout=true) 
   public static void uploadFeedItems(Id newParentId , Set<Id> FeedItemsIdSet){
  
  
   List<Box_Error__c> bxErrList = new List<Box_Error__c>();  
      try{
       string subFolderId;
       
      
       List<Sub_Folder__c> CFList = [Select id,Name,CF_Box_Folder_Id__c,CF_Deal__c from Sub_Folder__c where CF_Deal__c =:newParentId  and name=:'Sales' ];
       if(CFList.size()>0)
         subFolderId= CFList[0].CF_Box_Folder_Id__c;
       
       Map<String,Integer> dupNameList = new Map<String,Integer>();
       List<FeedItem> distinctRecords = new List<FeedItem>();
       List<FeedItem > duplicateRecords = new List<FeedItem>();
       Integer count = 0;
       List<FeedItem> llll = new List<FeedItem>([Select id, ContentFileName from FeedItem where parentId =: newParentId and type='ContentPost']);
       system.debug('llll =='+llll );
       for(FeedItem oppObj:  [Select id, ContentFileName from FeedItem where parentId =: newParentId]){ 
              system.debug('-------oppObj ------------'+oppObj);
              Boolean found = false;
              system.debug('--------------distinctRecords.size()--------------'+distinctRecords.size());
              for(Integer i=0; i< distinctRecords.size(); i++){
                  system.debug('--------distinctRecords[i].ContentFileName------'+distinctRecords[i].ContentFileName);
                  system.debug('--------------oppObj.ContentFileName.equalsIgnoreCase--------------'+oppObj.ContentFileName.equalsIgnoreCase(distinctRecords[i].ContentFileName));
                  if(distinctRecords[i].ContentFileName!=null){
                    if(oppObj.ContentFileName.equalsIgnoreCase(distinctRecords[i].ContentFileName)){ 
                         found=true;
                        duplicateRecords.add(oppObj);
                        system.debug('****************'+dupNameList.containsKey(oppObj.ContentFileName));
                        if(!dupNameList.containsKey(oppObj.ContentFileName)){
                            dupNameList.put(oppObj.ContentFileName ,1);
                        }
                        Integer c = dupNameList.get(oppObj.ContentFileName );
                        c++;
                        dupNameList.put(oppObj.ContentFileName ,c);
                    }
                  }
              }
              if(!found){
                distinctRecords.add(oppObj);
              }
       } 
        
       
       system.debug('folderId'+subFolderId);   
       for(FeedItem att:  [Select id, ContentFileName , ContentData, parentId, contenttype from FeedItem where Id in: FeedItemsIdSet]){ 
         if(att.parentId != null){
           if(att.ContentData.size()<=4000000){
           
            Integer namecount = dupNameList.get(att.ContentFileName);
          if(subFolderId!=null){ 
           
                if(namecount > 1){
                    BoxUploadAttachmentController.uploadFeedDuplicateItem(2,att, subFolderId, bxErrList);
                }
                else{
                    BoxUploadAttachmentController.uploadFeedDuplicateItem(1,att, subFolderId, bxErrList);
                }
           }  
            

        }
       else{
             Box_Error__c bxerr = new Box_Error__c();
             
             bxerr.name = 'Heap Size Exceed-Trigger'; 
             bxerr.Message__c = 'Attachment id-'+att.id; 
             bxerr.Body__c = '';
             bxerr.Type__c ='Feed Item';
             bxerr.Status__c = 'Error';
       
             bxErrList.add(bxerr);
      
          }
        }
      }
      
     }
      catch(Exception e){
      //system.assert(false,e.getMessage()+'--'+e.getStackTraceString());
            Box_Error__c bxerr = new Box_Error__c();
            bxerr.name = 'Exception-Trigger'; 
            bxerr.Message__c = e.getMessage(); 
            bxerr.Body__c = e.getStackTraceString();
             
            bxerr.Type__c ='Feed Item';
            
            bxerr.Status__c = 'Error';
            bxErrList.add(bxerr); 
        }
        finally{
            insert bxErrList;
        }         
    
    }
    

    
  
    
 
 /* Author: Irfan Khan (Appcino Technologies Pvt. Ltd.)
  * Function for uploading duplicate names documents 
  */
  public static void uploadFeedDuplicateItem(Integer count, FeedItem att, String subFolderId, List<box_error__c> bxErrList ){

          system.debug('################################ count'+count);
          String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
          String attName ='';
              if(count>1){
                       string s = att.ContentFileName;
                        string sext = att.contenttype;
                        string[] part = s.split('\\.');
                        string[] partext = sext.split('\\/');
                        string name = '';
                        if(part.size() > 1){
                            for(integer j=0; j<=part.size()-2;j++){
                                if(j==part.size()-2){
                                    name += part[j];    
                                }
                                else{
                                    name += part[j]+'.';
                                }
                                
                            }
                            //system.assert(false,name);
                            if(partext[1]==part[part.size()-1]){
                                name = name+'('+count+').'+part[part.size()-1];
                            }
                            else{
                                String extension = ''; 
                                if(partext[1] == 'plain' && part[part.size()-1] == 'txt'){
                                    extension = 'txt';
                                    name = name+'('+count+')'+'.'+extension;
                                }
                                else if(partext[1] == 'plain' && part[part.size()-1] !='txt'){
                                    extension = 'txt';
                                    name = name+'.'+part[part.size()-1]+'('+count+')'+'.'+extension;
                                }
                                else if(partext[1] == 'jpeg' && part[part.size()-1] == 'jpg'){
                                    extension = 'jpg';
                                    name = name+'('+count+')'+'.'+extension;
                                }
                                else{
                                    extension = partext[1];
                                    name = name+'('+count+')'+'.'+part[part.size()-1];
                                }
                                
                            }
                        }
                        else{
                           String extension = ''; 
                            if(partext[1] == 'plain'){
                                extension = 'txt';
                            }
                            else{
                                extension = partext[1];
                            }
                            name = s+'('+count+').'+extension;
                        }
    
                       attName =name;
                        
                }
                else{
                string name = '';
                     if(att.contenttype != null){
                    string s = att.ContentFileName;
                        string sext = att.contenttype;
                        string[] part = s.split('\\.');
                        string[] partext = sext.split('\\/');
                        
                        if(part.size() > 1){
                            for(integer j=0; j<=part.size()-2;j++){
                                if(j==part.size()-2){
                                    name += part[j];    
                                }
                                else{
                                    name += part[j]+'.';
                                }
                            }
                            
                            if(partext[1]==part[part.size()-1]){
                               name = name+'.'+part[part.size()-1];
                            }
                            else{
                                String extension = ''; 
                                if(partext[1] == 'plain' && part[part.size()-1] == 'txt'){
                                    extension = 'txt';
                                    name = name+'.'+extension;
                                }
                                else if(partext[1] == 'plain' && part[part.size()-1] !='txt'){
                                    extension = 'txt';
                                    name = name+'.'+part[part.size()-1]+'.'+extension;
                                }
                                else if(partext[1] == 'jpeg' && part[part.size()-1] == 'jpg'){
                                    extension = 'jpg';
                                    name = name+'.'+extension;
                                }
                                else{
                                    extension = partext[1];
                                    name = name+'.'+part[part.size()-1];
                                }
                            }
                        }
                        else{
                           
                            String extension = ''; 
                            if(partext[1] == 'plain'){
                                extension = 'txt';
                            }
                            else{
                                extension = partext[1];
                            }
                            name = s+'.'+extension;
                        }
                        
                        }
                        else{
                            name = att.ContentFileName;
                        }
        
                    attName = name;
                    
                    }  
                    String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attName+'";\nContent-Type: application/octet-stream';
                    String footer = '--'+boundary+'--';
                    String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    transient String bodyEncoded='';
                    transient String last4Bytes ='';
                    while(headerEncoded.endsWith('=')){
                        header+=' ';
                        headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    }
                     bodyEncoded = EncodingUtil.base64Encode(att.ContentData);
                       
                       Blob bodyBlob = null;
                     if(bodyEncoded!=null && bodyEncoded!='') 
                       last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
                     if(last4Bytes.endsWith('==')) {
                        last4Bytes = last4Bytes.substring(0,2) + '0K';
                    
                        bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes; 
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                      } 
                     else if(last4Bytes.endsWith('=')) {
                        last4Bytes = last4Bytes.substring(0,3) + 'N';
                        bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                        footer = '\n' + footer;
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer)); 
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                       }
                     else{
                        footer = '\r\n' + footer;
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer));
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);  
                      }                
                
                
                  Box__c bx = Box__c.getInstance();
                
                  HttpRequest reqfile = new HttpRequest();
                                        
                                    
                reqfile.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
                reqfile.setMethod('POST');
                reqfile.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+subFolderId);
                reqfile.setBodyAsBlob(bodyBlob);
                reqfile.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                reqfile.setHeader('Content-Length',String.valueof(reqfile.getBodyAsBlob().size()));
                
                // Send HTTP request and get HTTP response
                Http httpfile = new Http();
                HTTPResponse resfile = httpfile.send(reqfile);
                if(resfile.getStatusCode() == 201){
                    FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                     for(Entries_Z entry: fw.entries){
                   
                   system.debug('######################################## entry.parent.id'+ entry.parent.id);
                   system.debug('######################################## parent_folder'+ subFolderId);
                   //System.assert(false,entry.parent.id+'         '+att.parentId);
                 if(entry.parent.id == subFolderId){
                     
                     Box_Error__c bxerr = new Box_Error__c();
                     
                     bxerr.name = String.valueOf(resfile.getStatusCode()); 
                     bxerr.Message__c = 'Attachment id-'+att.id; 
                     bxerr.Body__c = resfile.getBody();
                     bxerr.Type__c = 'Feed Item';
                     bxerr.Status__c = 'Success';
                     
                     // constructing manual url
                     String manual_url = base_url;
                     manual_url += subFolderId;
                     manual_url += '/1/';
                     manual_url += 'f_'+entry.id;
                     
                     bxerr.Manual_Url__c = manual_url;
                     
                     system.debug('######################################## manual_url'+ manual_url);
                     
                     bxErrList.add(bxerr);
                }
                else{
                   Box_Error__c bxerr = new Box_Error__c();
                 
                   bxerr.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr.Message__c = 'parent not match-'+att.id; 
                   bxerr.Body__c = resfile.getBody();
                   bxerr.Type__c ='Feed Item';
                   bxerr.Status__c = 'Error';
             
                   bxErrList.add(bxerr);
            
               } 
                
      
            } 
      
        }
        else if(resfile.getStatusCode() == 409){
            system.debug('####################################### recursive');
            count++;
            system.debug('####################################### recursive count'+count);
            uploadFeedDuplicateItem(count, att, subFolderId, bxErrList);
        }
        else{
           Box_Error__c bxerr = new Box_Error__c();
           
           bxerr.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
           bxerr.Message__c = 'Attachment id-'+att.id; 
           bxerr.Body__c = resfile.getBody();
           bxerr.Type__c ='Feed Item';
           bxerr.Status__c = 'Error';
     
           bxErrList.add(bxerr);
    
       }

}

    public static void uploadDuplicateDocument(Integer count, Attachment att, String subFolderId, String errorType, List<box_error__c> bxErrList ){
  

          Map<String,String> customErrorMap= new  Map<String,String>();
          for(Attachment__c attCustom: [select id, project__r.Deal__c from Attachment__c where id=:att.parentId]){
            customErrorMap.put(attCustom.id,attCustom.project__r.Deal__c);
          }
          
          Map<String,String> docuSignErrorMap = new  Map<String,String>();
          for(dsfs__DocuSign_Status__c docSign: [select id, Deal__c from dsfs__DocuSign_Status__c where id=:att.parentid]){
            docuSignErrorMap.put(docSign.id,docSign.Deal__c);  
          }

         
          String boundary = '----------------------------'+String.valueOf(DateTime.now().getTime())+'';
          String attName ='';
              system.debug('------------count------'+count);
              
                    String header = '--'+boundary+'\nContent-Disposition: form-data; name="file"; filename="'+attName+'";\nContent-Type: application/octet-stream';
                    String footer = '--'+boundary+'--';
                    String headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    transient String bodyEncoded='';
                    transient String last4Bytes ='';
                    while(headerEncoded.endsWith('=')){
                        header+=' ';
                        headerEncoded = EncodingUtil.base64Encode(Blob.valueOf(header+'\r\n\r\n'));
                    }
                     bodyEncoded = EncodingUtil.base64Encode(att.body);
                       
                       Blob bodyBlob = null;
                     if(bodyEncoded!=null && bodyEncoded!='') 
                       last4Bytes = bodyEncoded.substring(bodyEncoded.length()-4,bodyEncoded.length());
                    if(last4Bytes.endsWith('=')) {
                        last4Bytes = last4Bytes.substring(0,3) + 'N';
                        bodyEncoded = bodyEncoded.substring(0,bodyEncoded.length()-4) + last4Bytes;
                        footer = '\n' + footer;
                        String footerEncoded = EncodingUtil.base64Encode(Blob.valueOf(footer)); 
                        bodyBlob = EncodingUtil.base64Decode(headerEncoded+bodyEncoded+footerEncoded);
                       }
                                    
                
                
                  Box__c bx = Box__c.getInstance();
                
                  HttpRequest reqfile = new HttpRequest();
                                        
                                    
                reqfile.setHeader('Content-Type', 'multipart/form-data; boundary=' + boundary);
                reqfile.setMethod('POST');
                reqfile.setEndpoint('https://upload.box.com/api/2.0/files/content?parent_id='+subFolderId);
                reqfile.setBodyAsBlob(bodyBlob);
                reqfile.setHeader('Authorization','Bearer '+bx.BoxAccess_Token__c);        
                reqfile.setHeader('Content-Length',String.valueof(reqfile.getBodyAsBlob().size()));
                
                // Send HTTP request and get HTTP response
                Http httpfile = new Http();
                HTTPResponse resfile = httpfile.send(reqfile);
                if(resfile.getStatusCode() == 201){
                    FileWrapper fw = (FileWrapper) System.JSON.deserialize(resfile.getBody(), FileWrapper.class);
                     for(Entries_Z entry: fw.entries){
                
                     Box_Error__c bxerr = new Box_Error__c();
                    
                     
                     
                     bxerr.name = String.valueOf(resfile.getStatusCode()); 
                     bxerr.Message__c = 'Attachment id-'+att.id; 
                     bxerr.Body__c = resfile.getBody();
                     bxerr.Type__c = errorType;
                     bxerr.Status__c = 'Success';
                     
                     // constructing manual url
                     String manual_url = base_url;
                     manual_url += subFolderId;
                     manual_url += '/1/';
                     manual_url += 'f_'+entry.id;
                     
                     bxerr.Manual_Url__c = manual_url;
                     
                    
                     
                     bxErrList.add(bxerr);
                     
                     Box_Error__c bxerr1 = new Box_Error__c();
                     
                     
                     bxerr1.name = String.valueOf(resfile.getStatusCode()); 
                     bxerr1.Message__c = 'Attachment id-'+att.id; 
                     bxerr1.Body__c = resfile.getBody();
                     bxerr1.Type__c = errorType;
                     bxerr1.Status__c = 'Success';
                     
                     // constructing manual url
                      manual_url = base_url;
                     manual_url += subFolderId;
                     manual_url += '/1/';
                     manual_url += 'f_'+entry.id;
                     
                     bxerr1.Manual_Url__c = manual_url;
                     
                    
                     
                     bxErrList.add(bxerr1);
                
                   Box_Error__c bxerr2 = new Box_Error__c();
                  
                   bxerr2.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr2.Message__c = 'parent not match-'+att.id; 
                   bxerr2.Body__c = resfile.getBody();
                   bxerr2.Type__c =errorType;
                   bxerr2.Status__c = 'Error';
             
                   bxErrList.add(bxerr2);
                   
                    Box_Error__c bxerr3 = new Box_Error__c();
          
                   bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
                   
                  
          
                   bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
                   
                   bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
                   
                   bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
                    bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
                    bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
                    bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
                    bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
                    bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
                    bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
                    bxerr3.name = 'Trigger-'+String.valueOf(resfile.getStatusCode()); 
                   bxerr3.Message__c = 'Attachment id-'+att.id; 
                   bxerr3.Body__c = resfile.getBody();
                   bxerr3.Type__c =errorType;
                   bxerr3.Status__c = 'Error';
             
                   bxErrList.add(bxerr3);
      
            } 
      
        }
       
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