trigger OnUpdateLead on Lead (before update) {
   
public class TriggerException extends Exception {}

     // *** bulkification : get all existing attachments and their names
     
     List<Attachment> aList = new List<Attachment>([SELECT Id, Parent.Id, Name FROM Attachment WHERE Parent.Id in :Trigger.newMap.keySet()]);
     
     Map<Id, List<String>> leadIdAttachmentNameListMap = new Map<Id, List<string>>();
     Map<Id, List<String>> leadIdAttachmentIdListMap = new Map<Id, List<string>>();
     for (Attachment a : aList) {
       List<String> tList = leadIdAttachmentNameListMap.get(a.Parent.Id);
       List<String> tList2 = leadIdAttachmentIdListMap.get(a.Parent.Id);
       if (tList == null) {
          tList = new List<String>();
          leadIdAttachmentNameListMap.put(a.Parent.Id, tList);
          
          tList2 = new List<String>();
          leadIdAttachmentIdListMap.put(a.Parent.Id, tList2);
       } 
       
       //System.debug('adding name ' + a.Name);
       tList.add(a.Name);
       tList2.add(a.Id);
     }
    
     
     for (Lead nl : Trigger.new) {
        Lead ol = Trigger.oldMap.get(nl.Id);
        
        // *** only attach if Status changed to Proposed, SolutionID & ProjectID are not null and there is
        // *** not already another attachment with the same name
        
        if (nl.SolarNexus_Proposal_Fetched__c != ol.SolarNexus_Proposal_Fetched__c && nl.SolarNexus_Proposal_Fetched__c == true) {
          String solutionID = nl.SNSolutionID__c;
          String projectID = nl.SNProjectID__c;
          if (solutionID != null && projectId != null) {
               TriggerUtil.fetchProposalForProject(projectID, solutionID, nl.ID, leadIdAttachmentNameListMap.get(nl.Id),leadIdAttachmentIdListMap.get(nl.Id));
          } else {
               nl.Proposal_Fetch_Error__c = 'Error: Either solution Id or project id was blank. Unable to fetch document';
          }
        }
     }
}