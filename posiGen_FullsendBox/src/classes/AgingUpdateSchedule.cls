global class AgingUpdateSchedule implements Schedulable {
 
 global void execute(SchedulableContext SC) {
  try {   
    AgingUpdate obj = new AgingUpdate();
    String sch = '0 0 13 * * ?';
    //system.schedule('Aging Auto Update', sch, obj);
    ID batchprocessid = Database.executeBatch(obj);   
  } 
  catch(Exception ex) {
      System.debug('Job Error: '+ex.getMessage());
  } 
  finally {
  }
 }
}