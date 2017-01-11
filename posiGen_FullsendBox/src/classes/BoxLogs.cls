public class BoxLogs {
    
    public static string CREATE_COLLABORATION = 'Create Collaboration';
    public static string CREATE_GROUP_COLLABORATION = 'Create Group Collaboration';
    public static string DELETE_COLLABORATION = 'Delete Collaboration';
    public static string UPDATE_COLLABORATION = 'Update Collaboration';
    public static string CREATE_FOLDER = 'Create Folder';
    
    public static List<Box_Log__c> createLogs(string reference,string oppId, string subFolderId, string body, string type, string status, string errorCode, string email, string Collaboration_Role, List<Box_Log__c> boxLogs ) {
        
       boxLogs.add(new Box_Log__c( 
            Error_Code__c = errorCode,
            Error_Message__c = body,
            Deal__c = oppId,        
            Status__c = status,
            Sub_Folder__c = subFolderId,
            type__c = type,
            Reference__c = reference,
            email__c = email,
            Collaboration_Role__c = Collaboration_Role,
            Random_Number__c = Math.random()+' ' +System.DateTime.now()
        ));
        
        return boxLogs;
        
    }

}