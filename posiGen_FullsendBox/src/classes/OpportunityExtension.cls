public with sharing class OpportunityExtension{
    public List<Sub_Folder__c> ChList{get; set;}
    public List<Sub_Folder__c> ChList1{get; set;}
    public List<SelectOption> lstUsers {get;set;}
    public List<Selectoption> lstRoles {get;set;}
    
    public String SelectedUserId {get;set;}
    public String SelectedFolderId {get;set;}
    public String SelectedRole{get;set;}
    public boolean IsSuccess {get;set;}
    
    public OpportunityExtension(ApexPages.StandardController controller){
        SelectedFolderId = '';
        SelectedUserId = '';
        SelectedRole = '';
        IsSuccess = false;
        
        ChList = new List<Sub_Folder__c>();
        ChList1 = new List<Sub_Folder__c>();
        String OppId = controller.getRecord().Id;
        lstUsers = new List<SelectOption>();
        lstRoles = new List<SelectOption>();
        
        
        for(Sub_Folder__c CF : SoqlServices.getChildFolders(OppId)){
            ChList.add(CF);
        }
        
        for(Integer i=ChList.size()-1; i>=0; i--){
        	ChList1.add(ChList[i]);
        }
        
        lstRoles.add(new SelectOption('editor','Editor'));
        lstRoles.add(new SelectOption('viewer','Viewer'));
        lstRoles.add(new SelectOption('previewer','Previewer'));
        lstRoles.add(new SelectOption('uploader','Uploader'));
        lstRoles.add(new SelectOption('previewer uploader','Previewer Uploader'));
        lstRoles.add(new SelectOption('viewer uploader','Viewer Uploader'));
        lstRoles.add(new SelectOption('co-owner','Co-owner'));
        lstRoles.sort();       
    }
    
    public PageReference getDetails(){
        return null;
    }
    
    public PageReference ShareWithUser(){
        return null;
    }
    
}