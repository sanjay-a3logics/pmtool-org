public class UserDashboardController
{
//    public List<Milestone1_Task__c> tasksReady;
//   public List<Milestone1_Task__c> tasksNotReady;
    public List<Lead> myLeads;
    public List<Case> myCases;
    public List<Opportunity> myOpportunities;
    public List<Opportunity> deptOpportunities;
    
    public UserDashboardController()
    {
 /*       tasksReady = [SELECT 
                      //milestone information
    //                  Project_Milestone__r.Name,
     //                 Project_Milestone__c,
                      //task information
                      Id, 
                      Name,
                      //project information
        //              Related_Project__r.Name,
         //             Related_Project__c,
                      //extra fields
                      Task_Stage__c,
                      CreatedDate,
                      Started_On__c                 
            //          FROM Milestone1_Task__c  
                      WHERE Assigned_To_Me_and_Ready_to_Work__c = TRUE
                      ORDER BY CreatedDate
                     ];
                     
         tasksNotReady = [SELECT
                          //milestone information
            //              Project_Milestone__r.Name,
             //             Project_Milestone__c,
                          //task information
                          Id, 
                          Name,
                          //project information
             //             Related_Project__r.Name,
             //             Related_Project__c,
                          //predecessor
                //          Predecessor_Task__c,
                 //         Predecessor_Task__r.Name,
                          //extra fields
                          Task_Stage__c,
                          CreatedDate,
                          Started_On__c                 
                //          FROM Milestone1_Task__c  
                          WHERE Assigned_To_Me_and_Not_Ready_to_Work__c = TRUE
                          ORDER BY CreatedDate
                         ];
        
        
        myLeads = [SELECT
                   LastActivityDate,
                   Id,
                   Name,
                   Street,
                   City,
                   Phone,
                   Email,
                   Status,
                   CreatedDate
                   FROM Lead
                   WHERE OwnerId = :UserInfo.getUserId()
                   ORDER BY LastActivityDate, CreatedDate
                  ];
                  
        myCases = [SELECT
                   Id,
                   CaseNumber,
                   ContactId,
                   Contact.Name,
                   Subject,
                   Status,
                   Priority,
                   CreatedDate
                   FROM Case
                   WHERE OwnerId = :UserInfo.getUserId()
                   AND Status <> 'Closed'
                   ORDER BY CreatedDate
                  ];
                  
        myOpportunities = [SELECT
                           Id,
                           Name,
                           Account.Id,
                           Account.Name,
                           StageName,
                           LastActivityDate,
                           Customer_Liason__c,
                           Customer_Liason__r.Name,
                           Owner.Id,
                           Owner.Name
                           FROM Opportunity
                           WHERE Need_My_Action__c = TRUE
                           ORDER BY LastActivityDate
                          ];

        deptOpportunities = [SELECT
                           Id,
                           Name,
                           Account.Id,
                           Account.Name,
                           StageName,
                           LastActivityDate
                           FROM Opportunity
                           WHERE Need_My_Depts_Action__c = TRUE
                           ORDER BY LastActivityDate];
  */  }
    
 /*   public List<Milestone1_Task__c> getTasksReady()
    {
        return tasksReady;
    }
    
    public List<Milestone1_Task__c> getTasksNotReady()
    {
        return tasksNotReady;
    }
  */  
    public List<Lead> getMyLeads()
    {
        return myLeads;
    }
    
    public List<Case> getMyCases()
    {
        return myCases;
    }
    
    public List<Opportunity> getMyOpportunities()
    {
        return myOpportunities;
    }
    
    public List<Opportunity> getDeptOpportunities ()
    {
        return deptOpportunities;
    }
    
}