/*
* This class will run at 12:00 AM every day,
* for creating collaborations, which are logged as error in Box-logs object 
*/
public without sharing class BoxCreateCollaborationsFromErrorLogs implements Schedulable,Database.AllowsCallouts {

    public string code;
    public BoxCreateCollaborationsFromErrorLogs() {
        
    }
    
    public void execute(SchedulableContext sc) {
        Batch_BoxCreateCollaborationsFrom  b1 = new Batch_BoxCreateCollaborationsFrom();
        ID batchprocessid = Database.executeBatch(b1,3);
    }
}