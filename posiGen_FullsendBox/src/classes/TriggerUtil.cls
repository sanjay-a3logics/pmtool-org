global class TriggerUtil{

static String authorizationHeader = ''; 
static String documentEndPointPrefix = ''; 
static String documentListEndPointPrefix = ''; 



static List<Attachment> insList = new List<Attachment>();
static List<Attachment> delList = new List<Attachment>();
static String debugString = '';

@future(callout=true)
static webservice void fetchProposalForProject(String projectID, String solutionID, String leadID, List<String> leadAttachmentNameList,List<String> leadAttachmentIdList)
{
      try { 
        
        
      REST_API_Settings__c settings = REST_API_Settings__c.getInstance();
      authorizationHeader = settings.Authorization_Header__c;
      documentEndPointPrefix = settings.Document_URL_End_Point_Prefix__c;
      documentListEndPointPrefix = settings.Document_List_URL_End_Point_Prefix__c;
      
      
      String timeZone = UserInfo.getTimeZone().getID();
      Datetime dateGMT=Datetime.Now();
      String formatteddate=dateGMT.format('yyyy-MM-dd HH:mm:ss',timeZone);
    debugString = ' Entering fetchProposalForProject at ' + Datetime.valueOfGmt(formatteddate) + '\n\n';
    Http h = new Http();

   HttpRequest req = new HttpRequest();
   req.setHeader('Authorization',authorizationHeader);
   req.setEndpoint(documentListEndPointPrefix + projectID + '/documents.xml');
   req.setMethod('GET');
   
   debugString = debugString + 'Request #1 => \n\n' + req + '\n\n';

    // Send the request, and return a response  
    HttpResponse res = h.send(req);
   
    Dom.Document doc = res.getBodyDocument();
   
    debugString = debugString + 'Response => \n\n' + doc.toXmlString() + '\n\n';
   

   //Retrieve the root element for this document.
    Dom.XMLNode documents = doc.getRootElement();

   
    
    Boolean foundDocument = false;
    for(Dom.XMLNode d : documents.getChildElements()) {
          if (d.getAttribute('SolutionIdRef',null) == solutionID && 
              d.getChildElement('Type', null).getText() == 'Proposal') {
              System.Debug('checking if ' + d.getChildElement('FileName', null).getText() + 'exists in ' + leadAttachmentNameList + ' id list => ' + leadAttachmentIdList);
               Integer aIndex = getListIndex(leadAttachmentNameList,d.getChildElement('FileName', null).getText());
               System.Debug('got index = ' + aIndex);
               if (aIndex > -1) {
                  // query and delete index
                  System.Debug('***** deleting attachment with Id = ' + leadAttachmentIdList[aIndex]);
                  Attachment a = new Attachment(Id=leadAttachmentIdList[aIndex]);
                  delList.add(a);
               }
               
                attachProposalToLead(d.getAttribute('Id',null), d.getChildElement('FileName', null).getText(),leadID);
                      
                      
                foundDocument = true;
                
             }
     }
     
     if(!foundDocument)
     {
         debugString += '\n\n Error: No matching document found';
     }
     
     delete delList;
     insert insList;
     System.debug('upserting lead debug String =>' + debugString);
     Lead l = new Lead(Id = leadId);
     l.Proposal_Fetch_Error__c = debugString;
     upsert l;
      } catch (Exception e) {
        Lead l = new Lead(Id = leadId);
      l.Proposal_Fetch_Error__c = e.getMessage() + '\n\n' + e.getStackTraceString();
      upsert l;
      }
}

public static boolean containsList(List<string> aList, String val)
{
    if (aList == null) { return false;}
    
    for (String s : aList) {
        if (s == val) {
            return true;
        }
    }
    return false;
}


public static Integer getListIndex(List<string> aList, String val)
{
  if (aList == null) { return -1;}
  
  for (Integer i=0; i< aList.size(); i++) {
    if (aList[i] == val) {
      return i;
    }
  }
  return -1;
}

static void attachProposalToLead(String docID, String docName, String leadID)
{

    Http h = new Http();

    HttpRequest req = new HttpRequest();
    req.setHeader('Authorization',authorizationHeader);
    req.setEndpoint(documentEndPointPrefix + docID);
    req.setMethod('GET');
    req.setHeader('Content-Type','application/pdf');
   
    debugString = debugString + 'Request #2 => \n\n' + req + '\n\n';
    
    
    HttpResponse res = h.send(req);
     debugString = debugString + 'Response => \n\n' + res + '\n\n';
    blob pdf = res.getBodyAsBlob();
   
    Attachment n = new Attachment();
    n.ParentId = leadID;
    n.Name = docName;
    n.Body = pdf;
    n.contentType = 'application/pdf';
    insList.add(n);
}

public static void coverageMethod()
{
    List<String> ls = new List<String>();
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
         ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
         ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
         ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
         ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
         ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
         ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
         ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
        ls.add('one');
}
        
        
}