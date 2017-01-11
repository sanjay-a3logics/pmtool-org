trigger AfterInsertOnSystem on Systems__c (after insert) {
	//Boolean firsttime = true;
	
	List<Systems__c> systemsInserted = [SELECT Id, Install_Project_Created_On__c, Install_Project_Created_On__r.Opportunity__c FROM Systems__c WHERE Id IN : Trigger.newMap.keySet()];
	
	Map<String, List<Planned_Arrays__c>> pArraysToCopy = new Map<String,List<Planned_Arrays__c>>();
    
    List<Project__c> projsForSystem = [SELECT Id, Opportunity__c FROM Project__c WHERE Id IN (SELECT Install_Project_Created_On__c FROM Systems__c WHERE Id IN :systemsInserted)];
    List<Opportunity> oppsFromProj = [SELECT Id FROM Opportunity WHERE Id IN (SELECT Opportunity__c FROM Project__c WHERE Id IN :projsForSystem)];
   	for (Planned_Arrays__c pa : [SELECT Id, Name, Tilt__c, Azimuth__c, Number_of_Modules__c, Array_Rating_kW__c, Array_Rating_for_Rollup_kW__c, Yeild_kWh_yr__c, Opportunity_ID__c FROM Planned_Arrays__c WHERE Project__c in 
								(SELECT Id FROM Project__c WHERE RecordType.Name = 'PV Feasibility' AND Opportunity__c IN :oppsFromProj)])
	{
		if (pArraysToCopy.containsKey(pa.Opportunity_ID__c))
		{
			pArraysToCopy.get(pa.Opportunity_ID__c).add(pa);
		}
		else
		{
			pArraysToCopy.put(pa.Opportunity_ID__c, new List<Planned_Arrays__c>{pa});
		}
	}
    System.debug(pArraysToCopy);
    
    List<Opportunity> oppsToUpdate = new List<Opportunity>{};
	List<Array__c> arraysToInsert = new List<Array__c>{};
        
    for (Systems__c sys : systemsInserted) 
	{
        if (pArraysToCopy.size() > 0) {
		
			Integer numberOfPlannedArrays = pArraysToCopy.get(sys.Install_Project_Created_On__r.Opportunity__c).size();
			Integer indexOfList = 0;
			Systems__c systemForArray = sys;
			while (numberOfPlannedArrays > 0)
			{
				Planned_Arrays__c pa = pArraysToCopy.get(sys.Install_Project_Created_On__r.Opportunity__c)[indexOfList];
                Double arrayRating = pa.Array_Rating_for_Rollup_kW__c;
				Array__c a = new Array__c();
				a.System__c = systemForArray.Id;
				a.Name = pa.Name;
                String nameOfpa = pa.Name;
                integer lengthOfpa = nameOfpa.length();
				a.Number__c = integer.valueof(nameOfpa.substring(lengthOfpa - 1));
				a.Tilt__c = pa.Tilt__c;
				a.Azimuth__c = pa.Azimuth__c;
				a.Planned_Number_of_Modules__c = pa.Number_of_Modules__c;
				a.Array_Rating_kW__c = pa.Array_Rating_kW__c;
				a.Array_Rating_for_Rollup_kW__c = arrayRating;
				a.Project__c = sys.Install_Project_Created_On__c;
				a.Planned_Array__c = pa.Id;
				a.Yield_kWh_yr__c = pa.Yeild_kWh_yr__c;
				arraysToInsert.add(a);
				numberOfPlannedArrays--;
				indexOfList++;
			}
		
        }
   }
	insert arraysToInsert;

}