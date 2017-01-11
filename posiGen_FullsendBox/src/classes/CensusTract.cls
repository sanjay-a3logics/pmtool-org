public class CensusTract implements Schedulable, Database.Stateful{

    public static string api_endpoint = 'http://geocoding.geo.census.gov/geocoder/geographies/address?';
    public static string benchmark = 'Public_AR_Census2010';
    public static string vintage = 'Census2010_Census2010';
    public static string format = 'json';   
    
    public final Set<Id> oppSet;
    public final Map<Id,String> oldOppStageMap;
    public final Map<Id,String> oldCensusTractMap;
    
    public CensusTract(Set<Id> oppSet, Map<Id,String> oldOppStageMap, Map<Id,String> oldCensusTractMap){
    
        this.oppSet = oppSet;
        this.oldOppStageMap = oldOppStageMap;
        this.oldCensusTractMap = oldCensusTractMap;
    }
    
    public void execute(SchedulableContext SC) {
    
        updateCensusTract(oppSet,oldOppStageMap,oldCensusTractMap);
    }

    @future(callout = true)
    public static void updateCensusTract(Set<Id> oppSet, Map<Id,String> oldOppStageMap, Map<Id,String> oldCensusTractMap){
        
        String census_tract_value = '';
        List<Deal__c> opportunityUpdateList = new List<Deal__c>();
        
        Map<String,Decimal> acsMedianIncomeMap = new Map<String,Decimal>();
        for(Census_Tract__c censusTractObj : [select Census_Tract__c,ACS_Median_Income__c from Census_Tract__c where Census_Tract__c != null]){
            acsMedianIncomeMap.put(censusTractObj.Census_Tract__c,censusTractObj.ACS_Median_Income__c);
        }
        
        for(Deal__c Opp : [select id, StageName__c,Census_Tract__c,Property__c,Property__r.Assessor_House__c,
         Property__r.Assessor_City__c,Property__r.Assessor_Street_Direction__c,Property__r.Assessor_Street_Name__c,
         Property__r.Assessor_Street_Type__c,Property__r.Assessor_State__c,Property__r.Assessor_ZIP__c from Deal__c where id in: oppSet]){
            
            // check if stage is changed and it is 'Contracts Approved'
            system.debug('Opp.StageName--opportunity-----------------'+Opp.StageName__c);
            system.debug('Opp.StageName--opportunity-----------------'+Opp.StageName__c+'--------'+oldOppStageMap.get(Opp.id));
            system.debug('Opp.Census_Tract__c-----------------'+Opp.Census_Tract__c);
            
            if(Opp.Census_Tract__c != oldCensusTractMap.get(Opp.id)){
                if(Opp.Census_Tract__c != null){   
                    if(acsMedianIncomeMap.containsKey(Opp.Census_Tract__c)){
                        Opp.ACS_Median_Income__c = acsMedianIncomeMap.get(Opp.Census_Tract__c);
                    }
                    else{
                        Opp.ACS_Median_Income__c = null;
                    }  
                    
                }
                else{
                    Opp.ACS_Median_Income__c = null;
                }
                opportunityUpdateList.add(Opp);
            
            }
            else if(Opp.StageName__c != oldOppStageMap.get(Opp.id) && Opp.StageName__c =='Contracts Approved' && Opp.Census_Tract__c ==null ){
                
                system.debug('Opp.Property__c-----------------'+Opp.Property__c);
                system.debug('Opp.Property__r.Assessor_City__c-----------------'+Opp.Property__r.Assessor_City__c);
                // populate Census_Tract__c field
                if(Opp.Property__c != null && Opp.Property__r.Assessor_City__c != null){
                    //system.assert(false,'Opp.Property__r.Assessor_City__c-----------------'+Opp.Property__r.Assessor_City__c);
                    String street = Opp.Property__r.Assessor_House__c+' ';      
                    if(Opp.Property__r.Assessor_Street_Direction__c != null){
                        street += Opp.Property__r.Assessor_Street_Direction__c+' ';
                    }
                    
                    street += Opp.Property__r.Assessor_Street_Name__c+' ';
                    
                    if(Opp.Property__r.Assessor_Street_Type__c!= null){
                        street += Opp.Property__r.Assessor_Street_Type__c+' ';
                    }
                    system.debug('street -----------------'+street);
                    //call the Geocoding API to get Census Tract
                    HttpRequest req = new HttpRequest();
                    String url = 'street='+EncodingUtil.urlEncode(street, 'UTF-8')+'&city='+EncodingUtil.urlEncode(Opp.Property__r.Assessor_City__c, 'UTF-8')+'&state='+EncodingUtil.urlEncode(Opp.Property__r.Assessor_State__c, 'UTF-8')+'&benchmark='+benchmark+'&vintage='+vintage+'&format='+format;
                    req.setEndpoint(api_endpoint+url);
                    req.setMethod('GET');
                    HTTPResponse res = new HTTPResponse();
                    String resBody = '';
                    if(!Test.isRunningTest()){
                       res  = new Http().send(req);
                       resBody = res.getBody();
                    }else{
                        resBody = '{"result":{"input":{"address":{"city":"Suitland","street":"4600 Silver Hill Rd","state":"MD"},"benchmark":{"isDefault":false,"benchmarkName":"Public_AR_Census2010","benchmarkDescription":"Public Address Ranges - Census 2010 Benchmark","id":"9"},"vintage":{"isDefault":true,"vintageName":"Census2010_Census2010","vintageDescription":"Census2010 Vintage - Census2010 Benchmark","id":"910"}},"addressMatches":[{"geographies":{"Census Blocks":[{"BLKGRP":"1","UR":"","OID":210403970691471,"FUNCSTAT":"S","STATE":"24","AREAWATER":0,"NAME":"Block 1084","SUFFIX":"","LSADC":"BK","CENTLON":"-076.9266698","HU100":0,"LWBLKTYP":"L","BLOCK":"1084","BASENAME":"1084","INTPTLAT":"+38.8477828","POP100":0,"MTFCC":"G5040","COUNTY":"033","GEOID":"240338024051084","CENTLAT":"+38.8477828","INTPTLON":"-076.9266698","AREALAND":33460,"OBJECTID":4385889,"TRACT":"802405"}],"Counties":[{"UR":"","OID":27590286309965,"STATE":"24","FUNCSTAT":"A","AREAWATER":41816219,"NAME":"Prince Georges County","LSADC":"06","HU100":328182,"CENTLON":"-076.8472801","BASENAME":"Prince Georges","INTPTLAT":"+38.8258796","COUNTYCC":"H1","POP100":863420,"MTFCC":"G4020","COUNTY":"033","GEOID":"24033","CENTLAT":"+38.8293080","INTPTLON":"-076.8472724","AREALAND":1250163582,"COUNTYNS":"01714670","OBJECTID":749}],"Census Tracts":[{"UR":"","OID":20790286332785,"STATE":"24","FUNCSTAT":"S","AREAWATER":2053,"NAME":"Census Tract 8024.05","LSADC":"CT","CENTLON":"-076.9365788","HU100":1810,"BASENAME":"8024.05","INTPTLAT":"+38.8583934","POP100":4240,"MTFCC":"G5020","COUNTY":"033","GEOID":"24033802405","CENTLAT":"+38.8553770","INTPTLON":"-076.9353309","AREALAND":3976091,"OBJECTID":30500,"TRACT":"802405"}],"States":[{"OID":27490140608205,"UR":"","STATE":"24","FUNCSTAT":"A","NAME":"Maryland","AREAWATER":6989579585,"LSADC":"00","HU100":2378814,"CENTLON":"-076.6789637","STUSAB":"MD","BASENAME":"Maryland","INTPTLAT":"+38.9466584","POP100":5773552,"DIVISION":"5","MTFCC":"G4000","STATENS":"01714934","GEOID":"24","CENTLAT":"+38.9463596","INTPTLON":"-076.6744939","REGION":"3","AREALAND":25141638381,"OBJECTID":5}]},"matchedAddress":"4600 Silver Hill Rd, SUITLAND, MD, 20746","coordinates":{"x":-76.92691,"y":38.846542},"tigerLine":{"tigerLineId":"613199520","side":"L"},"addressComponents":{"zip":"20746","city":"SUITLAND","state":"MD","fromAddress":"4600","toAddress":"4712","preQualifier":"","preDirection":"","preType":"","streetName":"Silver Hill","suffixType":"Rd","suffixDirection":"","suffixQualifier":""}}]}}';
                    }
                  
                    system.debug('----------------------res='+res);  
                    if(resBody !=''){                   
                        system.debug('----------------------res.getBody()='+res.getBody());
                        String jsonData = resBody.replaceAll('Census Tracts','CensusTracts');
                        ResponseWrapper rw = (ResponseWrapper) System.JSON.deserialize(jsonData, ResponseWrapper.class);
                        if(rw.result != null){
                            if(rw.result.addressMatches != null){
                                for(AddressMatches am: rw.result.addressMatches){
                                    system.debug('-----------------------am='+am);
                                    system.debug('-----------------------am.geographies='+am.geographies);
                                    system.debug('-----------------------am.geographies.CensusTracts='+am.geographies.CensusTracts);                                    
                                    for(CensusTracts ct: am.geographies.CensusTracts){
                                    
                                        if(ct.STATE != null){
                                            census_tract_value = ct.STATE+''+ct.COUNTY+''+ct.TRACT;
                                        }
                                        system.debug('census_tract_value-------------------'+census_tract_value);
                                        
                                        if(census_tract_value != null){
                                            Opp.Census_Tract__c = census_tract_value;
                                            Opp.ACS_Median_Income__c = acsMedianIncomeMap.get(census_tract_value);
                                            opportunityUpdateList.add(Opp);
                                        }
                                    }
                                }
                            }
                        }
                    }     
                }
            }
        }
        
        if(opportunityUpdateList.size()>0){
            OpportunityTriggerHandler.firstRun = false;
            update opportunityUpdateList;
        }
        
    }
    
    public class ResponseWrapper {
        public Result result;
    }    

    public class Address {
        public String state;
        public String street;
        public String city;
    }

    public class Counties {
        public String UR;
        public Long OID;
        public String STATE;
        public String FUNCSTAT;
        public Integer AREAWATER;
        public String NAME;
        public String LSADC;
        public Integer HU100;
        public String CENTLON;
        public String BASENAME;
        public String INTPTLAT;
        public String COUNTYCC;
        public Integer POP100;
        public String MTFCC;
        public String COUNTY;
        public String GEOID;
        public String CENTLAT;
        public String INTPTLON;
        public Integer AREALAND;
        public String COUNTYNS;
        public Integer OBJECTID;
    }

    public class TigerLine {
        public String tigerLineId;
        public String side;
    }

    public class Coordinates {
        public Double x;
        public Double y;
    }

    public class Geographies {
        public List<CensusBlocks> CensusBlocks;
        public List<Counties> Counties;
        public List<CensusTracts> CensusTracts;
        public List<States> States;
    }

    public class AddressMatches {
        public Geographies geographies;
        public String matchedAddress;
        public Coordinates coordinates;
        public TigerLine tigerLine;
        public AddressComponents addressComponents;
    }

    public class Result {
        public List<AddressMatches> addressMatches;
    }

    public class States {
        public Long OID;
        public String UR;
        public String STATE;
        public String FUNCSTAT;
        public String NAME;
        public Long AREAWATER;
        public String LSADC;
        public Integer HU100;
        public String CENTLON;
        public String STUSAB;
        public String BASENAME;
        public String INTPTLAT;
        public Integer POP100;
        public String DIVISION;
        public String MTFCC;
        public String STATENS;
        public String GEOID;
        public String CENTLAT;
        public String INTPTLON;
        public String REGION;
        public Long AREALAND;
        public Integer OBJECTID;
    }


    public class AddressComponents {
        public String state;
        public String fromAddress;
        public String toAddress;
        public String preQualifier;
        public String preDirection;
        public String preType;
        public String streetName;
        public String suffixType;
        public String suffixDirection;
        public String suffixQualifier;
        public String zip;
        public String city;
    }

    public class CensusTracts {
        public String UR;
        public Long OID;
        public String STATE;
        public String FUNCSTAT;
        public Integer AREAWATER;
        public String NAME;
        public String LSADC;
        public String CENTLON;
        public Integer HU100;
        public String BASENAME;
        public String INTPTLAT;
        public Integer POP100;
        public String MTFCC;
        public String COUNTY;
        public String GEOID;
        public String CENTLAT;
        public String INTPTLON;
        public Integer AREALAND;
        public Integer OBJECTID;
        public String TRACT;
    }

    public class CensusBlocks {
        public String BLKGRP;
        public String UR;
        public Long OID;
        public String FUNCSTAT;
        public String STATE;
        public Integer AREAWATER;
        public String NAME;
        public String SUFFIX;
        public String LSADC;
        public String CENTLON;
        public Integer HU100;
        public String LWBLKTYP;
        public String BLOCK;
        public String BASENAME;
        public String INTPTLAT;
        public Integer POP100;
        public String MTFCC;
        public String COUNTY;
        public String GEOID;
        public String CENTLAT;
        public String INTPTLON;
        public Integer AREALAND;
        public Integer OBJECTID;
        public String TRACT;
    }
    
}