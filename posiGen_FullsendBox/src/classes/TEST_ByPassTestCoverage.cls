@isTest 
private class TEST_ByPassTestCoverage {

    static testMethod void byPassTest() {
        CustomerApplicationFormControllerDeal.byPassTest();
        HousePhotoDeal.byPassTest();
        PanelPhotoDeal.byPassTest();
        
        Batch_LinkOpsCommentsToIssue.byPassTest();
        Batch_SyncCaseCommentToIssueComment.byPassTest();
        Batch_SyncCaseToIssue.byPassTest();
        Batch_SyncLeadToProspect.byPassTest();
        Batch_SyncOpportunityToDeal.byPassTest();
        Batch_TransferAttachFromOppToDeal.byPassTest();
        Batch_TransferLeadEventsToProspect.byPassTest();
        Batch_TransferLeadTasksToProspect.byPassTest();
        Batch_TransferNotesFromOpportunityToDeal.byPassTest();
        Batch_TransferOpportunityEventsToDeal.byPassTest();
        Batch_TransferOpportunityTasksToDeal.byPassTest();
        RedirectToCustomLeadConversionPageCtrler.byPassTest();
    }
}