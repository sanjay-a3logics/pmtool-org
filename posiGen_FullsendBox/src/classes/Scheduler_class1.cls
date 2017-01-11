public class Scheduler_class1 implements Schedulable,Database.Stateful{

    public String sched;
    public String folderName;
    public String NewStage;
    public String folderId;
    public Map<String,Sub_folder__c> SubfolderMap;
   
   public Scheduler_class1(){
   
   }
   public Scheduler_class1 (String folderName1,String NewStage1,String folderId1){
       this.folderName=folderName1;
       this.NewStage =NewStage1;
       this.folderId = folderId1;
       this.SubfolderMap = SubfolderMap;
   } 
   
  
    
    public void execute(SchedulableContext sc) {
    
        system.debug('============'+folderName+'====='+NewStage+'====='+folderId);
        CreateCollaborationOnStageChangeBatch  b1 = new CreateCollaborationOnStageChangeBatch(folderName,NewStage,folderId);
        ID batchprocessid = Database.executeBatch(b1,1);           
    }
}