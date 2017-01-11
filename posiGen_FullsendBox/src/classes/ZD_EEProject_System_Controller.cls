public class ZD_EEProject_System_Controller {
/*
    private final Project__c m_oProject;
    
    public ZD_EEProject_System_Controller(ApexPages.StandardController stdController) {
        Id oId = stdController.getId();
        this.m_oProject = [
            SELECT
                Id,
                Name,
                Opportunity__c
            FROM
                Project__c
            WHERE
                Id = :oId
        ];
    }
    
    public String getSystemId() {
        String sResult = '';
                
        // get the opportunity
        Id oOpportunityId = m_oProject.Opportunity__c;
        
        // get the PV Install project type
        RecordType oProjectInstallRecordType = [
            SELECT
                Id, 
                Name 
            FROM 
                RecordType 
            WHERE 
                sObjectType = 'Project__c'
                AND Name = 'PV Install'
        ];
        
        // project has a lookup relationship to opportunity
        List<Project__c> lProjects = [
            SELECT
                Id,
                Name,
                Opportunity__c,
                RecordTypeId
            FROM
                Project__c
            WHERE
                Opportunity__c = :oOpportunityId
                AND RecordTypeId = :oProjectInstallRecordType.Id
        ];
                
        if(lProjects.size() == 0)
            return sResult;

        Id oProjectId = lProjects[0].Id;
        
        // system has a master-detail relationship to project
        List<Systems__c> lSystems = [
            SELECT
                Id,
                Name
            FROM
                Systems__c
            WHERE
                Install_Project_Created_On__c = :oProjectId
        ];
            
        if(lSystems.size() == 0)
            return sResult;

        Id oSystemId = lSystems[0].Id;
        
        sResult = '' + oSystemId;
        
        return sResult;
    }*/
}