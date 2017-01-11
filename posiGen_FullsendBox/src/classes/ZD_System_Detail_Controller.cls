public class ZD_System_Detail_Controller {
        
    // *** Variables
   
    public Systems__c m_oSystem {
    	get { return m_oSystem; }
      	set { m_oSystem = value; }
    }    
    
    // Energy Production
    
    public List<Double> m_lACEnergyKwh {
    	get { return m_lACEnergyKwh; }
      	set { m_lACEnergyKwh = value; }
    }
    public Double m_dACEnergyTotalKwh {
    	get { return m_dACEnergyTotalKwh; }
      	set { m_dACEnergyTotalKwh = value; }
    }
    public List<Double> m_lEnergyValueDollar {
    	get { return m_lEnergyValueDollar; }
      	set { m_lEnergyValueDollar = value; }
   	}
    public Double m_dEnergyValueTotalDollar {
    	get { return m_dEnergyValueTotalDollar; }
      	set { m_dEnergyValueTotalDollar = value; }
    }
    
    // PV Install
    
    public Project__c m_oInstallProject {
    	get { return m_oInstallProject; }
      	set { m_oInstallProject = value; }        
    }
    
    // *** Methods
    
	public ZD_System_Detail_Controller() {
           
        m_dACEnergyTotalKwh = 0;
        m_dEnergyValueTotalDollar = 0;
        
        try {
        	// get values for energy production     
        
            String sId = ApexPages.currentPage().getParameters().get('id');
            if(sId == null)
                throw new ZD_Exception('No System ID Parameter');
            
            Integer nYear = System.Today().year();
            if(ApexPages.currentPage().getParameters().get('year') != null)
                nYear = Integer.valueOf(ApexPages.currentPage().getParameters().get('year'));
            
            // get the System object
            m_oSystem = [SELECT Id, Name, Install_Project_Created_On__c FROM Systems__c 
                        WHERE Id = :sId];
                        
            
            // get values for PV Install             
            String sProjectId = m_oSystem.Install_Project_Created_On__c;
            if(sProjectId == null)
                throw new ZD_Exception('No Install Project associated with System');
            
            List<Project__c> lProjects = [
                SELECT 
                	Id,
                	Building_Permit_Received_Date__c,
                	Electrical_Permit_Received_Date__c,
                	R_P_Reinstall_Date__c,
                	PVI_Rails_Installed_Date__c,
                	PVI_Electrical_Installed_Date__c,
                	PVI_Placed_In_Service_Date__c,
                	Net_Meter_Status__c,
                	Net_Meter_Install_Scheduled_Date__c,
                	Informed_Net_Meter_Installed_Date__c,
                	QC_Date__c,
                	QC_Passed__c
                FROM 
                	Project__c 
                WHERE Id = :sProjectId
            ];
            if(lProjects.isEmpty())
                throw new ZD_Exception('No Projects associated with Install Project ID');
            
            m_oInstallProject = lProjects[0];
                        
            // get the System Channel(s)
            List<System_Channel__c> lSystemChannels = [SELECT Id, Name FROM System_Channel__c
                                                      WHERE System__c = :sId];            
            if(lSystemChannels.isEmpty())
                throw new ZD_Exception('No System Channels associated with System ID Parameter');
            
            // get the System PV Production 
            
            // if we don't find any production table entries through an error
            Boolean bPVProductionFound = false;
            
            // store 
            List<Double> lACEnergyKwh = new Double[12];
            List<Double> lEnergyValueDollar = new Double[12];            
            for(Integer ix = 0; ix < 12; ix++)
            {
                lACEnergyKwh[ix] = 0;
                lEnergyValueDollar[ix] = 0;
            }
            
            for(Integer ix = 0; ix < lSystemChannels.size(); ix++)
            {
                Id oSystemChannelId = lSystemChannels[ix].Id;
                List<System_PV_Production__c> lSystemPVProduction = [
                    SELECT 
                    	Id, 
                    	Name, 
                    	DateTime__c, 
                    	Model_W__c,
                    	Production_W__c, 
                    	Energy_Value__c
                    FROM 
                    	System_PV_Production__c
                    WHERE 
                    	System_Channel__c = :oSystemChannelId
                    	AND CALENDAR_YEAR(DateTime__c) = :nYear
                ];
                if(lSystemPVProduction.isEmpty())
                    continue;
                
                bPVProductionFound = true;     
                
                // loop through all production and add 
                for(Integer jx = 0; jx < lSystemPVProduction.size(); jx++)
                {
                	DateTime oMonth = lSystemPVProduction[jx].DateTime__c;              
                    Integer nMonth = oMonth.month() - 1;
                    
                    Double dACEnergy = (lSystemPVProduction[jx].Model_W__c == null) ? 0 : lSystemPVProduction[jx].Model_W__c;
                    Double dEnergyValue = (lSystemPVProduction[jx].Energy_Value__c == null) ? 0 : lSystemPVProduction[jx].Energy_Value__c;
                                        
                    dACEnergy = dACEnergy + lACEnergyKwh[nMonth];
                    dEnergyValue = dEnergyValue + lEnergyValueDollar[nMonth];         
                    
                    lACEnergyKwh.set(nMonth, dACEnergy);
                    lEnergyValueDollar.set(nMonth, dEnergyValue);
                }
            }
            
            // error check
            if(bPVProductionFound)
            {
                m_lACEnergyKwh = lACEnergyKwh;
                m_lEnergyValueDollar = lEnergyValueDollar;
                
                // totals for energy production
                for(Integer ix = 0; ix < 12; ix++)
                {
                    m_dACEnergyTotalKwh = m_dACEnergyTotalKwh + lACEnergyKwh[ix];
                    m_dEnergyValueTotalDollar = m_dEnergyValueTotalDollar + lEnergyValueDollar[ix];
                }
            }
            else
            {
                String sTemp = 'No estimated production data available for this system';
                ApexPages.Message sError = new ApexPages.Message(ApexPages.Severity.FATAL, sTemp);
                ApexPages.addMessage(sError);                
            }
        }
        catch(Exception ex) {
            String sTemp = '';       
            sTemp = sTemp + ex.getMessage();            
            sTemp = sTemp + ' ' + ex.getStackTraceString();
            ApexPages.Message sError = new ApexPages.Message(ApexPages.Severity.FATAL, sTemp);
            ApexPages.addMessage(sError);
        }
    }
}