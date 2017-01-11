trigger ZD_Project_AfterInsert_AfterUpdate on Project__c (after insert, after update) {
    
    String sSourceField = 'R_P_Removal_Date__c';
    String sDestinationField = 'System_Removal_Date__c';
    
    // get PV Removal project type
    RecordType oRemovalProjectType = [Select ID, Name From RecordType Where sObjectType = 'Project__c' AND Name = 'PV Removal'];
        
    // get all systems of project removals
    Set<Id> sSystems = new Set<Id>();
    for(Project__c oProject : Trigger.new)
    {
        if(oProject.RecordTypeId == oRemovalProjectType.Id)
	        sSystems.add(oProject.System_Removed__c);
    }
    
    // get all systems
    List<Systems__c> lSystems = [
        SELECT
        	Id,
        	System_Removal_Date__c
        FROM
        	Systems__c
        WHERE
        	Id IN :sSystems
    ];
    
    // loop through each system and set field if necessary
    for(Systems__c oSystem : lSystems)
    {
        Project__c oProject = null;
    	for(Project__c oProjectTemp : Trigger.new)
        {
            if(oProjectTemp.System_Removed__c == oSystem.Id)
            {
                oProject = oProjectTemp;
                break;
            }
        }
        
        if(oProject != null)
        {
            // copy the source project field to the destination system field
            if(oProject.get(sSourceField) != oSystem.get(sDestinationField))
            {
                oSystem.put(sDestinationField, oProject.get(sSourceField));  
            }            
        }
    }
    
    update lSystems;
}