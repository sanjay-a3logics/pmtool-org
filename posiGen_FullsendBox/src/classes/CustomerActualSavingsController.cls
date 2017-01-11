/******************************************************

TO DO: 
    *Get "Link to Locus" info
    *ERROR HANDLING!!
    *WRITE UNIT TESTS

******************************************************/
public class CustomerActualSavingsController {

    public String getData() {
        return null;
    }

    public PageReference forwardToCustomAuthPage() {
        if(UserInfo.getUserType() == 'Guest'){
            return new PageReference('/login');
        }
        else{
            return null;
        }
    }    //public PageReference forwardToCustomAuthPage()
    
    public pageReference redirectToHowToSaveMore() {
        return new PageReference((standardUser?'/apex':'') + '/CustomerCommunity_HowToSaveMore');
    }

    public pageReference redirectToEESavings() {
        return new PageReference((standardUser?'/apex':'') + '/CustomerCommunity_EESavings');
    }
    
    public pageReference redirectToMySavings() {
        return new PageReference((standardUser?'/apex':'') + '/CustomerCommunity_MySavings');
    }

    public pageReference redirectToSEProduction() {
        return new PageReference((standardUser?'/apex':'') + '/CustomerCommunity_SolarEnergyAnalysis');
    }

    public Boolean standardUser { get; set; }
    public Boolean hasData { get; set; }
    public Boolean hasEE { get; set; }
    public Boolean callCSR { get; set; }
    public Boolean hasAmbassador { get; set; }
    public List<Customer_Actual_Saving__c> casAll { get; set; }
    public List<Customer_Actual_Saving__c> cas12 { get; set; }
    public List<Customer_Actual_Saving__c> casChart { get; set; }
    public String myString { get; set; }
    public List<AggregateResult> mySums = new List<AggregateResult>();
    public Decimal myNetDollars { get; set; }
    public Decimal myNetPV { get; set; }
    public Decimal myTotalDollars { get; set; }
    public Decimal myTotalKWH { get; set; }
    public Decimal myYrEEkWh { get; set; }
    public Decimal myYrEEDollars { get; set; }
    public List<CASDisplay> myCAS { get; set; }
    public CASDisplay monthCAS { get; set; }
    public List<Environmental_Impact_Of_Savings__c> envImpact { get; set; }
    public List<EnvImpact> myEnvImpact = new List<EnvImpact>();
    public Integer myNetEnvImpactNumber { get; set; }
    public String myNetEnvImpactText { get; set; }
    public Integer myEUEnvImpactNumber { get; set; }
    public List<Economic_Impact_Of_Savings__c> econImpact { get; set; }
    public List<EconImpact> myEconImpact = new List<EconImpact>();
    public Integer myNetEconImpactNumber { get; set; }
    public String myNetEconImpactText { get; set; }
    public List<RowWrapper> rows { get; set; }
    public List<RowWrapper> eerows { get; set; }
    public String myBaseURL { get; set; }
    public Customer_Actual_Saving__c casLatest { get; set; }
    public List<RowWrapper> futureRows { get; set; }
    public Decimal eeVal { get; set; }
    public List<EE_Upgrade__c> myEEUs { get; set; }
    public List<EEUSavings> myEEUSavings { get; set; }
    public Decimal myEarnedAmbassador { get; set; }
    public String ambassadorReferralURL { get; set; }
    public Account currentAccount { get; set; }
    public Customer_Portal_Global_Setting__c globalSettings { get; set; }
    public String bccEmail { get; set; }
    public String subjectEmail { get; set; }
    public String bodyEmail { get; set; }
    public String csrName { get; set; }
    public String csrPhone { get; set; }
    public String csrPhotoURL { get; set; }
    public String csrEmail { get; set; }
    
    public List<Customer_Actual_Saving__c> get_casChart() {
        return this.casChart;
    }        
    
    public List<Customer_Actual_Saving__c> get_casAll() {
        return this.casAll;
    }
    
    public List<CASDisplay> get_myCAS() {
        return this.myCAS;
    }
    
    public Class CASDisplay {
        public String id{get;set;}
        public String name{get;set;}
        public String opportunity{get;set;}
        public String monthending{get;set;}
        public Decimal pvprod{get;set;}
        public Decimal pvsavings{get;set;}
        public Decimal eukwh{get;set;}
        public Decimal eusavings{get;set;}
        public Decimal leasecost{get;set;}
        public Decimal pvpluseukwh{get;set;}
        public Decimal totalsavings{get;set;}
        public Decimal netsavings{get;set;}
        public Decimal cumulsavings{get;set;}
    }       //public Class CASDisplay

    public Class EEUSavings {
        public String id{get;set;}
        public String Item{get;set;}
        public String Unit{get;set;}
        public Decimal kwh{get;set;}
        public Decimal January{get;set;}
        public Decimal February{get;set;}
        public Decimal March{get;set;}
        public Decimal April{get;set;}
        public Decimal May{get;set;}
        public Decimal June{get;set;}
        public Decimal July{get;set;}
        public Decimal August{get;set;}
        public Decimal September{get;set;}
        public Decimal October{get;set;}
        public Decimal November{get;set;}
        public Decimal December{get;set;}
        public Decimal YearTotal{get;set;}
    }      //public Class EEUSavings
    
    public CustomerActualSavingsController() {
/*
*    test account id with savings data = 0017A000008Z1VdQAK, without savings data = 0017A00000BtdJj
*/
        //    Get current user and account for filtering. Standard users reach this page via button with Account ID parameter in URL.
        standardUser = (UserInfo.getUserType() == 'Standard');
        String c = [Select ContactId from User where Id =:UserInfo.getUserID()].ContactId;   
        String a = standardUser?(ApexPages.currentPage().getParameters().get('a')):[Select AccountId from Contact where Id =: c].AccountId;
        myString = a==null?'0017A000008txEm':a;
        currentAccount = [SELECT Ambassador_Total_Earned__c, Ambassador_Referral_URL__c, OwnerId, Owner_Name__c, Owner_Phone__c, Owner_Email__c 
                          FROM Account WHERE Id =: myString];
        myEarnedAmbassador = currentAccount.Ambassador_Total_Earned__c;
        ambassadorReferralURL = currentAccount.Ambassador_Referral_URL__c;
        csrName = currentAccount.Owner_Name__c;
        csrPhone = currentAccount.Owner_Phone__c==null?'1-866-767-4436':currentAccount.Owner_Phone__c;
        csrEmail = currentAccount.Owner_Email__c==null?'info@posigen.com':currentAccount.Owner_Email__c;
        csrPhotoURL = [SELECT Id, smallPhotoURL FROM User WHERE ID =:currentAccount.OwnerId].smallPhotoURL;
        hasAmbassador = ambassadorReferralURL==null?false:true;
        
        //    Get global customer portal settings
        globalSettings = [SELECT Minimum_Net_Savings_for_Display__c, Posigen_BCC_for_Referrals__c, Refer_a_Friend_Email_Body_Text__c, Refer_a_Friend_Email_Subject__c 
          FROM Customer_Portal_Global_Setting__c LIMIT 1];
        bccEmail = globalSettings.Posigen_BCC_for_Referrals__c;
        subjectEmail = globalSettings.Refer_a_Friend_Email_Subject__c.replaceAll(' ','%20');
        bodyEmail = globalSettings.Refer_a_Friend_Email_Body_Text__c.replaceAll(' ','%20');
        Decimal minSavings = globalSettings.Minimum_Net_Savings_for_Display__c;
        
        //    Get all savings data for current account:
        casAll = [SELECT Id, Name, Opportunity__r.Name, Savings_Month_Ending_Date__c, PV_Production_kWh__c, PV_Savings__c, Month_Name__c, EU_kWh_Conserved__c,
                        EU_Savings__c, Lease_Cost__c, Month_Total_Savings__c, Month_Net_Savings__c, Savings_Year__c, Savings_Month__c, Opportunity__c,
                        Utility_Rate_Per_kWh__c, To_Date_PV_Savings__c, To_Date_EE_Savings__c, To_Date_Total_Savings__c, To_Date_Lease_Cost__c, 
                        To_Date_Net_Savings__c, Future_Total_Production_kWh__c, Future_Total_PV_Savings__c, Future_Total_EE_Savings__c, 
                        Future_Total_PV_Plus_EE_Savings__c, Future_Total_Lease_Cost__c, Future_Total_Net_Savings__c, Lifetime_Total_Production_kWh__c, 
                        Lifetime_Total_PV_Savings__c, Lifetime_Total_EE_Savings__c, Lifetime_Total_PV_Plus_EE_Savings__c, Lifetime_Total_Lease_Cost__c, 
                        Lifetime_Total_Net_Savings__c, Projected_Annual_EE_kWh_Saved__c, Projected_Annual_PV_Production__c, Projected_Next_01Yr_EE_Savings__c, 
                        Projected_Next_01Yr_Lease_Cost__c, Projected_Next_01Yr_Net_Savings__c, Projected_Next_01Yr_PV_Savings__c, 
                        Projected_Next_01Yr_Total_Savings__c, Projected_Next_05Yrs_EE_kWh__c, Projected_Next_05Yrs_EE_Savings__c, Projected_Next_05Yrs_PV_Prod__c, 
                        Projected_Next_05Yrs_PV_Savings__c, Projected_Next_05Yrs_Total_Savings__c, Projected_Next_05Yrs_Lease_Cost__c, 
                        Projected_Next_05Yrs_Net_Savings__c, Projected_Next_10Yrs_EE_kWh__c, Projected_Next_10Yrs_EE_Savings__c, Projected_Next_10Yrs_PV_Prod__c, 
                        Projected_Next_10Yrs_PV_Savings__c, Projected_Next_10Yrs_Total_Savings__c, Projected_Next_10Yrs_Lease_Cost__c, 
                        Projected_Next_10Yrs_Net_Savings__c, Lease_Months_Remaining__c, Month_Total_kWh_for_PV_and_EE__c
                   FROM Customer_Actual_Saving__c
                   WHERE Account__c =: a
                   ORDER BY Savings_Month_Ending_Date__c];
        hasData = (casAll.size() > 0);    //proceed with data work only if there are savings records for the account
        if (hasData) {
            //    Get the most recent 12 records from casAll and populate for display with cumulatives:
            cas12 = [SELECT Id FROM Customer_Actual_Saving__c WHERE Account__c =: a ORDER BY Savings_Month_Ending_Date__c DESC LIMIT 12];
            myCAS = new List<CASDisplay>();
            String id, name, opportunity, monthending;
            Decimal pvprod, pvsavings, eusavings, leasecost, totalsavings, netsavings, cumulsavings;
            casChart = new List<Customer_Actual_Saving__c>();
            cumulsavings = 0.00;
            Integer j = 0;
            for (Customer_Actual_Saving__c currentCAS : casAll) {
                //cumulsavings += currentCAS.Month_Net_Savings__c;    //Change this. "Cumulative" as displayed refers to the most recent 12-month period.
                j++;
                if (j == casAll.size()) {
                    casLatest = currentCAS;
                    hasEE = (currentCAS.EU_Savings__c > 0);
                }    //if (j = casAll.size())
                for (Customer_Actual_Saving__c current12 : cas12) {    //Surely there is a better way to accomplish this, but will it work in the SF environment?
                    if (currentCAS.Id == current12.Id) {
                        cumulsavings += currentCAS.Month_Total_Savings__c.setscale(2); //2016-09 version will use only gross savings until lease cost data is available, not .Month_Net_Savings__c
                        casChart.Add(currentCAS);
                        CASDisplay monthCAS = new CASDisplay();
                        monthCAS.id            = currentCAS.Id;
                        monthCAS.name          = currentCAS.Name;
                        monthCAS.opportunity   = currentCAS.Opportunity__c;
                        monthCAS.monthending   = currentCAS.Month_Name__c + ' ' + currentCAS.Savings_Year__c;
                        monthCAS.pvprod        = currentCAS.PV_Production_kWh__c;
                        monthCAS.pvsavings     = currentCAS.PV_Savings__c;
                        monthCAS.eukwh         = currentCAS.EU_kWh_Conserved__c;
                        monthCAS.eusavings     = currentCAS.EU_Savings__c;
                        monthCAS.leasecost     = currentCAS.Lease_Cost__c;
                        monthCAS.pvpluseukwh   = currentCAS.Month_Total_kWh_for_PV_and_EE__c;
                        monthCAS.totalsavings  = currentCAS.Month_Total_Savings__c;
                        monthCAS.netsavings    = currentCAS.Month_Net_Savings__c;
                        monthCAS.cumulsavings  = cumulsavings.setscale(2);
                        myCAS.Add(monthCAS);
                    }    //if (currentCAS.Id == current12.Id)
                }    //for (Customer_Actual_Savings__c current12 : cas12)
            }    //for (Customer_Actual_Saving__c currentCAS : casAll)
        
            //    Populate summaries:
            mySums = [SELECT SUM(PV_Production_kWh__c) YrPV, SUM(Month_Net_Savings__c) YrNetSavings, SUM(PV_Savings__c) YrPVSavings, SUM(EU_Savings__c) YrEUSavings, 
                      SUM(EU_kWh_Conserved__c) YrEUkWh, SUM(Month_Total_Savings__c) YrTotalSavings, SUM(Lease_Cost__c) YrLeaseCost, SUM(Month_Total_kWh_for_PV_and_EE__c) YrTotalKWH
                      FROM Customer_Actual_Saving__c WHERE Id IN :cas12];
            myNetDollars = (Decimal)mySums[0].get('YrNetSavings');
            myNetPV = (Decimal)mySums[0].get('YrPV');
            myTotalDollars = (Decimal)mySums[0].get('YrTotalSavings');
            myTotalKWH = (Decimal)mySums[0].get('YrTotalKWH');
            myYrEEkWh = (Decimal)mySums[0].get('YrEUkWh');
            myYrEEDollars = (Decimal)mySums[0].get('YrEUSavings');
            callCSR = (myTotalDollars < minSavings);
            
            //    Populate environmental impact analogy. LATER: Provide dropdown list of phrases for user to select (e.g., trees planted, truck miles driven).
            envImpact = [SELECT Id, Conversion_Factor__c, Text_Analogy__c FROM Environmental_Impact_Of_Savings__c];
            for (Environmental_Impact_Of_Savings__c currentEnvImpact : envImpact) {
                EnvImpact currentEI = new EnvImpact();
                currentEI.factor = currentEnvImpact.Conversion_Factor__c;
                currentEI.phrase = currentEnvImpact.Text_Analogy__c;
                currentEI.impact = (Integer)(myNetPV * currentEnvImpact.Conversion_Factor__c);
                currentEI.euimpact = (Integer)(myYrEEkWh * currentEnvImpact.Conversion_Factor__c);
                myEnvImpact.Add(currentEI);
            }    // for(Environmental_Impact_Of_Savings__c currentEnvImpact : envImpact)
            myNetEnvImpactNumber = (Integer)myEnvImpact[0].impact;
            myEUEnvImpactNumber = (Integer)myEnvImpact[0].euimpact;
            myNetEnvImpactText = myEnvImpact[0].phrase;
            
            //    Populate economic impact analogy. LATER: Provide dropdown list of phrases for user to select (e.g., Super Bowl parties, concert tickets).
            econImpact = [SELECT Id, Conversion_Factor__c, Text_Analogy__c FROM Economic_Impact_Of_Savings__c];
            for (Economic_Impact_Of_Savings__c currentEconImpact : econImpact) {
                EconImpact currentEcI = new EconImpact();
                currentEcI.factor = currentEconImpact.Conversion_Factor__c;
                currentEcI.phrase = currentEconImpact.Text_Analogy__c;
                currentEcI.impact = (Integer)(myTotalDollars / currentEconImpact.Conversion_Factor__c);    //2016-09 version will use only gross savings until lease cost data is available
                currentEcI.euimpact = (Integer)(myYrEEDollars / currentEconImpact.Conversion_Factor__c);
                myEconImpact.Add(currentEcI);
            }    // for(Environmental_Impact_Of_Savings__c currentEnvImpact : envImpact)
            myNetEconImpactNumber = (Integer)myEconImpact[0].impact;
            myNetEconImpactText = myEconImpact[0].phrase;
            
            //    Transform the myCAS data for table with one column per savings month
            //    adapted from Bob Buzzard Blog http://bobbuzzard.blogspot.com/2010/09/rotating-visualforce-table.html
            //    create a row for each of the 8 fields to display in the table:
            //        Month Ending (no row header), PV Production, PV Savings, EE Savings, Total Savings, Lease Cost, Net Savings, Cumulative Net Savings
            //    2016-09 version: omit lease cost and net savings data until lease cost data is fully available; change 8 rows to 5
            rows = new List<RowWrapper>();
            for (Integer idx=0; idx<5; idx++) {    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available; change 8 rows to 5
                rows.add(new RowWrapper());
            }
            //    populate the first column with field names - sort of a row 'header':
            rows[0].addValue('');
            rows[1].addValue('PV Production');
            rows[2].addValue('PV Savings');
            rows[3].addValue('EE Savings');
            rows[4].addValue('Total Savings');
 //           rows[5].addValue('Lease Cost');    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
 //           rows[6].addValue('Net Savings');    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
 //           rows[7].addValue('Cumulative Net Savings');    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
            
            //    iterate the myCAS records and populate the rows:
            for (Integer idx=0; idx<12; idx++) {
                rows[0].addValue(myCAS[idx].monthending);
                rows[1].addValue(myCAS[idx].pvprod.format());
                rows[2].addValue('$' + currency(myCAS[idx].pvsavings.format()));
                rows[3].addValue('$' + currency(myCAS[idx].eusavings.format()));
                rows[4].addValue('$' + currency(myCAS[idx].totalsavings.format()));
                //rows[5].addValue('$' + currency(myCAS[idx].leasecost.format()));    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
                //rows[6].addValue(((myCAS[idx].netsavings < 0)?'-':'') + '$' + currency(myCAS[idx].netsavings.format()));    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
                //rows[7].addValue(((myCAS[idx].cumulsavings < 0)?'-':'') + '$' + currency(myCAS[idx].cumulsavings.format()));    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
            }    //for (Integer idx=0; idx<12; idx++)
    
            //    populate the rightmost column with totals; cumulative-over-last-12-months total repeats the cumulative sum in the last month
            rows[0].addValue('SUMMARY');
            rows[1].addValue(myNetPV.format());
            Decimal myYrPVSavings = (Decimal)mySums[0].get('YrPVSavings');
            rows[2].addValue('$' + currency(myYrPVSavings.toPlainString()));
            Decimal myYrEUSavings = (Decimal)mySums[0].get('YrEUSavings');
            rows[3].addValue('$' + currency(myYrEUSavings.toPlainString()));
            Decimal myYrTotalSavings = (Decimal)mySums[0].get('YrTotalSavings');
            rows[4].addValue('$' + currency(myYrTotalSavings.toPlainString()));
            //Decimal myYrLeaseCost = (Decimal)mySums[0].get('YrLeaseCost');    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
            //rows[5].addValue('$' + currency(myYrLeaseCost.toPlainString()));    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
            //rows[6].addValue(((myNetDollars < 0)?'-':'') + '$' + currency(myNetDollars.toPlainString()));    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
            //rows[7].addValue(((myCAS[11].cumulsavings < 0)?'-':'') + '$' + currency(myCAS[11].cumulsavings.format()));    //2016-09 version: omit lease cost and net savings data until lease cost data is fully available
            
            // Get future and lifetime figures to populate the Future table. Projections for next 1, 5, and 10 years depend on remaining lease months.
            Integer leaseMonthsLeft = (Integer)casLatest.Lease_Months_Remaining__c;
            Integer rowCount = (leaseMonthsLeft > 119?3:leaseMonthsLeft > 59?2:leaseMonthsLeft > 11?1:0) + 3;
            futureRows = new List<RowWrapper>();
            for (Integer idx=0; idx<rowCount; idx++) {
                futureRows.add(new RowWrapper());
            }    //for (Integer idx=0; idx<rowCount; idx++)
            
            //    populate the values; this can't be done by iteration since it all comes from a single record
            //    --NOTE: there will always be at least 3 rows, regardless of how many lease months remain
            futureRows[0].addValue('');
            futureRows[0].addValue('Total kWh Produced');
            futureRows[0].addValue('Total Solar Savings');
            futureRows[0].addValue('Total EE Savings');
            futureRows[0].addValue('Total Savings');
            //futureRows[0].addValue('Total Net Savings');    //2016-09 version will use only gross savings until lease cost data is available
            futureRows[rowCount-1].addValue('Total over Life of Lease');
            futureRows[rowCount-1].addValue(casLatest.Lifetime_Total_Production_kWh__c.format());
            Decimal lifetimePVSavings = casLatest.Lifetime_Total_PV_Savings__c;
            futureRows[rowCount-1].addValue('$' + currency(lifetimePVSavings.toPlainString()));
            Decimal lifetimeEESavings = casLatest.Lifetime_Total_EE_Savings__c;
            futureRows[rowCount-1].addValue('$' + currency(lifetimeEESavings.toPlainString()));
            Decimal lifetimeTotalSavings = casLatest.Lifetime_Total_PV_Plus_EE_Savings__c;
            futureRows[rowCount-1].addValue('$' + currency(lifetimeTotalSavings.toPlainString()));
            //Decimal lifetimeNetSavings = casLatest.Lifetime_Total_Net_Savings__c;    //2016-09 version will use only gross savings until lease cost data is available
            //futureRows[rowCount-1].addValue('$' + currency(lifetimeNetSavings.toPlainString()));    //2016-09 version will use only gross savings until lease cost data is available
            futureRows[rowCount-2].addValue('Total Future');
            futureRows[rowCount-2].addValue(casLatest.Future_Total_Production_kWh__c.format());
            Decimal futurePVSavings = casLatest.Future_Total_PV_Savings__c;
            futureRows[rowCount-2].addValue('$' + currency(futurePVSavings.toPlainString()));
            Decimal futureEESavings = casLatest.Future_Total_EE_Savings__c;
            futureRows[rowCount-2].addValue('$' + currency(futureEESavings.toPlainString()));
            Decimal futureTotalSavings = casLatest.Future_Total_PV_Plus_EE_Savings__c;
            futureRows[rowCount-2].addValue('$' + currency(futureTotalSavings.toPlainString()));
            //Decimal futureNetSavings = casLatest.Future_Total_Net_Savings__c;    //2016-09 version will use only gross savings until lease cost data is available
            //futureRows[rowCount-2].addValue('$' + currency(futureNetSavings.toPlainString()));    //2016-09 version will use only gross savings until lease cost data is available
            if (rowCount > 3) {
                futureRows[1].addValue('Total over Next 1 Year');
                futureRows[1].addValue(casLatest.Projected_Annual_PV_Production__c.format());
                Decimal next1YrPVSavings = casLatest.Projected_Next_01Yr_PV_Savings__c;
                futureRows[1].addValue('$' + currency(next1YrPVSavings.toPlainString()));
                Decimal next1YrEESavings = casLatest.Projected_Next_01Yr_EE_Savings__c;
                futureRows[1].addValue('$' + currency(next1YrEESavings.toPlainString()));
                Decimal next1YrTotalSavings = casLatest.Projected_Next_01Yr_Total_Savings__c;
                futureRows[1].addValue('$' + currency(next1YrTotalSavings.toPlainString()));
                //Decimal next1YrNetSavings = casLatest.Projected_Next_01Yr_Net_Savings__c;    //2016-09 version will use only gross savings until lease cost data is available
                //futureRows[1].addValue('$' + currency(next1YrNetSavings.toPlainString()));    //2016-09 version will use only gross savings until lease cost data is available
                if (rowCount > 4) {
                    futureRows[2].addValue('Total over Next 5 Years');
                    futureRows[2].addValue(casLatest.Projected_Next_05Yrs_PV_Prod__c.format());
                    Decimal next5YrsPVSavings = casLatest.Projected_Next_05Yrs_PV_Savings__c;
                    futureRows[2].addValue('$' + currency(next5YrsPVSavings.toPlainString()));
                    Decimal next5YrsEESavings = casLatest.Projected_Next_05Yrs_EE_Savings__c;
                    futureRows[2].addValue('$' + currency(next5YrsEESavings.toPlainString()));
                    Decimal next5YrsTotalSavings = casLatest.Projected_Next_05Yrs_Total_Savings__c;
                    futureRows[2].addValue('$' + currency(next5YrsTotalSavings.toPlainString()));
                    //Decimal next5YrsNetSavings = casLatest.Projected_Next_05Yrs_Net_Savings__c;    //2016-09 version will use only gross savings until lease cost data is available
                    //futureRows[2].addValue('$' + currency(next5YrsNetSavings.toPlainString()));    //2016-09 version will use only gross savings until lease cost data is available
                    if (rowCount > 5) {
                        futureRows[3].addValue('Total over Next 10 Years');
                        futureRows[3].addValue(casLatest.Projected_Next_10Yrs_PV_Prod__c.format());
                        Decimal next10YrsPVSavings = casLatest.Projected_Next_10Yrs_PV_Savings__c;
                        futureRows[3].addValue('$' + currency(next10YrsPVSavings.toPlainString()));
                        Decimal next10YrsEESavings = casLatest.Projected_Next_10Yrs_EE_Savings__c;
                        futureRows[3].addValue('$' + currency(next10YrsEESavings.toPlainString()));
                        Decimal next10YrsTotalSavings = casLatest.Projected_Next_10Yrs_Total_Savings__c;
                        futureRows[3].addValue('$' + currency(next10YrsTotalSavings.toPlainString()));
                        //Decimal next10YrsNetSavings = casLatest.Projected_Next_10Yrs_Net_Savings__c;    //2016-09 version will use only gross savings until lease cost data is available
                        //futureRows[3].addValue('$' + currency(next10YrsNetSavings.toPlainString()));    //2016-09 version will use only gross savings until lease cost data is available
                    }    //if (rowCount > 5)
                }    //if (rowCount > 4)
            }    //if (rowCount > 3)

            //populate EE page month-savings table:
            eerows = new List<RowWrapper>();
            for (Integer idx=0; idx<3; idx++) {
                eerows.add(new RowWrapper());
            }
            //    populate the first column with field names - sort of a row 'header':
            eerows[0].addValue('');
            eerows[1].addValue('Energy Consumption Savings (kWh)');
            eerows[2].addValue('EE Savings');
            
            //    iterate the myCAS records and populate the eerows:
            for (Integer idx=0; idx<12; idx++) {
                eerows[0].addValue(myCAS[idx].monthending);
                eerows[1].addValue(myCAS[idx].eukwh.format());
                eerows[2].addValue('$' + currency(myCAS[idx].eusavings.format()));
            }    //for (Integer idx=0; idx<12; idx++)
    
            //    populate the rightmost column with totals; cumulative-over-last-12-months total repeats the cumulative sum in the last month
            eerows[0].addValue('SUMMARY');
            eerows[1].addValue(myYrEEkWh.format());
            eerows[2].addValue('$' + currency(myYrEEDollars.toPlainString()));
            
            //    get ee upgrade items:
            myEEUs = [SELECT Id, Field_Name__c, Field_Api_Name__c, Value__c, Points__c, Distribution_01_Jan_Pct__c, Distribution_02_Feb_Pct__c, 
                        Distribution_03_Mar_Pct__c, Distribution_04_Apr_Pct__c, Distribution_05_May_Pct__c, Distribution_06_Jun_Pct__c, 
                        Distribution_07_Jul_Pct__c, Distribution_08_Aug_Pct__c, Distribution_09_Sep_Pct__c, Distribution_10_Oct_Pct__c, 
                        Distribution_11_Nov_Pct__c, Distribution_12_Dec_Pct__c 
                      FROM EE_Upgrade__c 
                      WHERE Energy_Audit__r.Project__r.Opportunity__r.Account.Id = :a 
                      AND EE_Upgrade_Item_Type__r.Show_in_Customer_Savings_Detail__c = true
                      ORDER BY Field_Name__c];
            myEEUSavings = new List<EEUSavings>();
            for (EE_Upgrade__c currentEEU : myEEUs) {
                EEUSavings eeuitem = new EEUSavings();
                eeuitem.id        = currentEEU.Id;
                eeuitem.Item      = currentEEU.Field_Name__c.replace('(QTY)','');
                eeuitem.Unit      = currentEEU.Value__c;
                eeuitem.kWh       = Decimal.valueOf(String.valueOf(currentEEU.Points__c));
                eeuitem.January   = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_01_Jan_Pct__c;
                eeuitem.February  = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_02_Feb_Pct__c;
                eeuitem.March     = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_03_Mar_Pct__c;
                eeuitem.April     = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_04_Apr_Pct__c;
                eeuitem.May       = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_05_May_Pct__c;
                eeuitem.June      = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_06_Jun_Pct__c;
                eeuitem.July      = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_07_Jul_Pct__c;
                eeuitem.August    = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_08_Aug_Pct__c;
                eeuitem.September = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_09_Sep_Pct__c;
                eeuitem.October   = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_10_Oct_Pct__c;
                eeuitem.November  = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_11_Nov_Pct__c;
                eeuitem.December  = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh) * currentEEU.Distribution_12_Dec_Pct__c;
                eeuitem.YearTotal = myYrEEDollars * (Decimal.valueOf(String.valueOf(currentEEU.Points__c)) / myYrEEkWh);
                myEEUSavings.Add(eeuitem);
            }    //            for (EE_Upgrade__c currentEEU : myEEUs)
            EEUSavings eeuannual = new EEUSavings();
            eeuannual.Item = 'Total Energy Efficiency Upgrades';
            eeuannual.kWh = myYrEEkWh;
            eeuannual.YearTotal = myYrEEDollars;
            myEEUSavings.Add(eeuannual);
            
        }    //if (hasData)

    }    //public CustomerActualSavingsController
    
    public Class EnvImpact {
        public Decimal factor{get;set;}
        public String phrase{get;set;}
        public Integer impact{get;set;}
        public Integer euimpact{get;set;}
    }    //public Class EnvImpact
    
    public Class EconImpact {
        public Decimal factor{get;set;}
        public String phrase{get;set;}
        public Integer impact{get;set;}
        public Integer euimpact{get;set;}
    }    //public Class EconImpact
    

    public Class RowWrapper {
    // adapted from Bob Buzzard Blog http://bobbuzzard.blogspot.com/2010/09/rotating-visualforce-table.html
        //the values (cells) making up this row
        public List<String> values { get; set; }
        
        //constructor
        public RowWrapper() {
            values = new List<String>();
        }    //public RowWrapper()
        
        //append a value (cell) to the row
        public void addValue(String value) {
            values.add(value);
        }    //public void addValue(String value)
    }    //public Class RowWrapper

    public static String currency(String i) {
        String s = ( Decimal.valueOf(i==null||i.trim()==''?'0':i).setScale(2) + 0.001 ).format();
        return s.substring(0,s.length()-1);
    }
    

/*    page component notes:
    -use http://salesforce.stackexchange.com/questions/27845/solved-multiplication-in-soql approach for row and column totals
*/

}