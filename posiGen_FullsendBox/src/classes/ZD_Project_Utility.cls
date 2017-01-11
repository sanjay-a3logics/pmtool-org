public class ZD_Project_Utility {

    public static void copyFieldRemovalProjectToSystem(Project__c oProject, String sSourceField, String sDestinationField)
    {
        // check if this project is a PV Removal record type
        Map<ID,RecordType> mRecordTypes = new Map<ID,RecordType>([Select ID, Name From RecordType Where sObjectType = 'Project__c']);
		if(!mRecordTypes.get(oProject.recordTypeID).name.containsIgnoreCase('PV Removal'))
            return;
        
        // get the system removed project
    	List<Systems__c> lSystem = [SELECT Id FROM Systems__c WHERE Id = :oProject.System_Removed__c]; 
        if(lSystem.isEmpty())
            return;
        
        // copy the source project field to the destination system field
        lSystem[0].put(sDestinationField, oProject.get(sSourceField));        
        update lSystem[0];
    }
}