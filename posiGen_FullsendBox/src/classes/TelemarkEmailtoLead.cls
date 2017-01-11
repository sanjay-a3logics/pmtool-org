global class TelemarkEmailtoLead implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, 
                                                       Messaging.InboundEnvelope env){
    // Create an InboundEmailResult object for returning the result of the  
    // Apex Email Service 
    Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
    String plaintextbody= email.plainTextbody;
    String subject = email.subject;
                                                      
    Integer bodysize = plaintextbody.length();                                                       
    String configName = '';
    map<String,Integer> emailfieldloc = new map<String,Integer>();
    map<String,String> leadfields = new map<String,String>();
                                                           
    if (subject == 'PosiGen Appointment Request'){
        configName = subject; 
    }else if(subject =='new messages for 2807'){
        configName = subject;
    }else{ configName = subject;
    }
                                                           
    list<InboundEmailConfig__c> emailconfig = [Select Name,Field_1_Label__c,Owner__c,Field_1_API__c,Field_2_Label__c,Field_2_API__c,Field_3_Label__c,Field_3_API__c,Field_4_Label__c,Field_4_API__c,
                                            Field_5_Label__c,Field_5_API__c,Field_6_Label__c,Field_6_API__c,Field_7_Label__c,Field_7_API__c,Field_8_Label__c,Field_8_API__c, 
                                            Field_9_Label__c,Field_9_API__c,Field_10_Label__c,Field_10_API__c,Field_11_Label__c,Field_11_API__c,Field_12_Label__c,Field_12_API__c,
                                            Field_13_Label__c,Field_13_API__c,Field_14_Label__c,Field_14_API__c,Key_Field_Label__c,Key_Field_API__C,Campaign__c From InboundEmailConfig__c where Name = :configName limit 1];
    
    if (!emailconfig.isempty()){
        InboundEmailConfig__c thisconfig = emailconfig[0];
        if(thisconfig.Field_1_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_1_Label__c)!=-1){
            system.debug('field 1 start ');
            system.debug(plaintextbody.indexOf(thisconfig.Field_1_Label__c));
            system.debug(thisconfig.Field_1_Label__c.trim().length());
            emailfieldloc.put(thisconfig.Field_1_Label__c,plaintextbody.indexOf(thisconfig.Field_1_Label__c)-1);
            leadfields.put(thisconfig.Field_1_API__c,plaintextbody.substring(plaintextbody.indexOf(thisconfig.Field_1_Label__c)+thisconfig.Field_1_Label__c.trim().length(),bodysize).normalizeSpace());
        }
        if(thisconfig.Field_2_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_2_Label__c)!=-1){
            system.debug('field 2 start ');
            system.debug(plaintextbody.indexOf(thisconfig.Field_2_Label__c));
            system.debug(thisconfig.Field_2_Label__c.trim().length());
            emailfieldloc.put(thisconfig.Field_2_Label__c,plaintextbody.indexOf(thisconfig.Field_2_Label__c)-1);
            leadfields.put(thisconfig.Field_2_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_2_Label__c)+thisconfig.Field_2_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_1_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_1_Label__c)+thisconfig.Field_1_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_2_Label__c)).normalizeSpace());
        }                                                               
        if(thisconfig.Field_3_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_3_Label__c)!=-1){
            system.debug('field 3 start ');
            system.debug(plaintextbody.indexOf(thisconfig.Field_3_Label__c));
            system.debug(thisconfig.Field_3_Label__c.trim().length());
            emailfieldloc.put(thisconfig.Field_3_Label__c,plaintextbody.indexOf(thisconfig.Field_3_Label__c)-1);
            leadfields.put(thisconfig.Field_3_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_3_Label__c)+thisconfig.Field_3_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_2_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_2_Label__c)+thisconfig.Field_2_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_3_Label__c)).normalizeSpace());
        }                                                           
        if(thisconfig.Field_4_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_4_Label__c)!=-1){
            system.debug('field 4 start '+plaintextbody.indexOf(thisconfig.Field_4_Label__c)+thisconfig.Field_4_Label__c.trim().length());
            emailfieldloc.put(thisconfig.Field_4_Label__c,plaintextbody.indexOf(thisconfig.Field_4_Label__c)-1);
            leadfields.put(thisconfig.Field_4_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_4_Label__c)+thisconfig.Field_4_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_3_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_3_Label__c)+thisconfig.Field_3_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_4_Label__c)).normalizeSpace());
        }
        if(thisconfig.Field_5_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_5_Label__c)!=-1){
            system.debug('field 5 start '+plaintextbody.indexOf(thisconfig.Field_5_Label__c)+thisconfig.Field_5_Label__c.trim().length());
            emailfieldloc.put(thisconfig.Field_5_Label__c,plaintextbody.indexOf(thisconfig.Field_5_Label__c)-1);
            leadfields.put(thisconfig.Field_5_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_5_Label__c)+thisconfig.Field_5_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_4_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_4_Label__c)+thisconfig.Field_4_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_5_Label__c)).normalizeSpace());
        }                                                               
        if(thisconfig.Field_6_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_6_Label__c)!=-1){
            system.debug('field 6 start '+plaintextbody.indexOf(thisconfig.Field_6_Label__c)+thisconfig.Field_6_Label__c.trim().length());
            emailfieldloc.put(thisconfig.Field_6_Label__c,plaintextbody.indexOf(thisconfig.Field_6_Label__c)-1);
            leadfields.put(thisconfig.Field_6_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_6_Label__c)+thisconfig.Field_6_Label__c.length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_5_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_5_Label__c)+thisconfig.Field_5_Label__c.length()),emailfieldloc.get(thisconfig.Field_6_Label__c)).normalizeSpace());
        }
        if(thisconfig.Field_7_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_7_Label__c)!=-1){
            system.debug('field 7 start '+plaintextbody.indexOf(thisconfig.Field_7_Label__c)+thisconfig.Field_7_Label__c.trim().length());
            emailfieldloc.put(thisconfig.Field_7_Label__c,plaintextbody.indexOf(thisconfig.Field_7_Label__c)-1);
            leadfields.put(thisconfig.Field_7_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_7_Label__c)+thisconfig.Field_7_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_6_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_6_Label__c)+thisconfig.Field_6_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_7_Label__c)).normalizeSpace());
        }
        if(thisconfig.Field_8_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_8_Label__c)!=-1){
            system.debug('field 8 start '+plaintextbody.indexOf(thisconfig.Field_8_Label__c)+thisconfig.Field_8_Label__c.trim().length());
            emailfieldloc.put(thisconfig.Field_8_Label__c,plaintextbody.indexOf(thisconfig.Field_8_Label__c)-1);
            leadfields.put(thisconfig.Field_8_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_8_Label__c)+thisconfig.Field_8_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_7_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_7_Label__c)+thisconfig.Field_7_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_8_Label__c)).normalizeSpace());
        }
        if(thisconfig.Field_9_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_9_Label__c)!=-1){
            system.debug('field 9 start '+plaintextbody.indexOf(thisconfig.Field_9_Label__c)+thisconfig.Field_9_Label__c.trim().length());       
            emailfieldloc.put(thisconfig.Field_9_Label__c,plaintextbody.indexOf(thisconfig.Field_9_Label__c)-1);
            leadfields.put(thisconfig.Field_9_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_9_Label__c)+thisconfig.Field_9_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_8_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_8_Label__c)+thisconfig.Field_8_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_9_Label__c)).normalizeSpace());
        }
        if(thisconfig.Field_10_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_10_Label__c)!=-1){
            system.debug('field 10 start '+plaintextbody.indexOf(thisconfig.Field_10_Label__c)+thisconfig.Field_10_Label__c.trim().length());       
            emailfieldloc.put(thisconfig.Field_10_Label__c,plaintextbody.indexOf(thisconfig.Field_10_Label__c)-1);
            leadfields.put(thisconfig.Field_10_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_10_Label__c)+thisconfig.Field_10_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_9_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_9_Label__c)+thisconfig.Field_9_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_10_Label__c)).normalizeSpace());
        }
         if(thisconfig.Field_11_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_11_Label__c)!=-1){
            system.debug('field 11 start '+plaintextbody.indexOf(thisconfig.Field_11_Label__c)+thisconfig.Field_11_Label__c.trim().length());       
            emailfieldloc.put(thisconfig.Field_11_Label__c,plaintextbody.indexOf(thisconfig.Field_11_Label__c)-1);
            leadfields.put(thisconfig.Field_11_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_11_Label__c)+thisconfig.Field_11_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_10_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_10_Label__c)+thisconfig.Field_10_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_11_Label__c)).normalizeSpace());
        }
         if(thisconfig.Field_12_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_12_Label__c)!=-1){
            system.debug('field 12 start '+plaintextbody.indexOf(thisconfig.Field_12_Label__c)+thisconfig.Field_12_Label__c.trim().length());       
            emailfieldloc.put(thisconfig.Field_12_Label__c,plaintextbody.indexOf(thisconfig.Field_12_Label__c)-1);
            leadfields.put(thisconfig.Field_12_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_12_Label__c)+thisconfig.Field_12_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_11_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_11_Label__c)+thisconfig.Field_11_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_12_Label__c)).normalizeSpace());
        }
        if(thisconfig.Field_13_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_13_Label__c)!=-1){
            system.debug('field 13 start '+plaintextbody.indexOf(thisconfig.Field_13_Label__c)+thisconfig.Field_13_Label__c.trim().length());       
            emailfieldloc.put(thisconfig.Field_13_Label__c,plaintextbody.indexOf(thisconfig.Field_13_Label__c)-1);
            leadfields.put(thisconfig.Field_13_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_13_Label__c)+thisconfig.Field_13_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_12_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_12_Label__c)+thisconfig.Field_12_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_13_Label__c)).normalizeSpace());
        }
        if(thisconfig.Field_14_Label__c!=null && plaintextbody.indexOf(thisconfig.Field_14_Label__c)!=-1){
            system.debug('field 14 start '+plaintextbody.indexOf(thisconfig.Field_14_Label__c)+thisconfig.Field_14_Label__c.trim().length());       
            emailfieldloc.put(thisconfig.Field_14_Label__c,plaintextbody.indexOf(thisconfig.Field_14_Label__c)-1);
            leadfields.put(thisconfig.Field_14_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_14_Label__c)+thisconfig.Field_14_Label__c.trim().length()),bodysize).normalizeSpace());
            leadfields.put(thisconfig.Field_13_API__c,plaintextbody.substring((plaintextbody.indexOf(thisconfig.Field_13_Label__c)+thisconfig.Field_13_Label__c.trim().length()),emailfieldloc.get(thisconfig.Field_14_Label__c)).normalizeSpace());
        }
        list<Lead> leads = new list<Lead>();
    // Check for existing leads with the matching key
        If (thisconfig.key_field_API__c == 'Email'){
            leads = [SELECT Id, Name, Email FROM Lead WHERE Email = :leadfields.get('Email')];
        }

    if (leads.size() == 0) {
      // New Lead object to be created - set LastName and Company to
      // dummy values for simplicity
      Lead newLead = new Lead();
        if(leadfields.get('FirstName;LastName')!=null){
            leadfields.put('FirstName',leadfields.get('FirstName;LastName').substringBefore(' '));
            leadfields.put('LastName',leadfields.get('FirstName;LastName').substringAfter(' '));
        }
        system.debug(leadfields.get('Street;City;State;PostalCode'));
        if(leadfields.get('Street;City;State;PostalCode')!=null){
            list<string> leadaddr = leadfields.get('Street;City;State;PostalCode').split(',');
            if(leadaddr.size()==3){
            	leadfields.put('Street',leadaddr[0]);
            	leadfields.put('City',leadaddr[1]);
            	leadfields.put('State',leadaddr[2].substringBefore(' '));
            	leadfields.put('Postalcode',leadaddr[2].substringAfter(' '));
            }
        }
        system.debug(leadfields.get('Street'));
        system.debug(leadfields.get('Roof_Type__c'));
        system.debug(leadfields.get('Average_Monthly_Electric_Bill__c'));
        system.debug(leadfields.get('FirstName;LastName'));
        system.debug(leadfields.get('FirstName'));
        system.debug(leadfields.get('LastName'));  
        system.debug(leadfields.get('Email'));
        system.debug(leadfields.get('Phone'));
        if(leadfields.get('Email')!=null){
            newLead.Email = leadfields.get('Email').substringBefore('<mailto:');
        }
        newLead.FirstName = leadfields.get('FirstName');
        newLead.LastName = leadfields.get('LastName');
        if(newLead.LastName==null || newLead.LastName==' ' || newLead.LastName=='')
        	newLead.LastName = 'NoLastName'; 
        newLead.Company = leadfields.get('Company');
        if(leadfields.get('Average_Monthly_Electric_Bill__c')!=null){
            newLead.Average_Monthly_Electric_Bill__c = Decimal.valueof(leadfields.get('Average_Monthly_Electric_Bill__c').remove('$').normalizeSpace());
        }
        If(leadfields.get('Image_URL__c')!=null){
            newLead.Image_URL__c = leadfields.get('Image_URL__c').substringBefore(' [');
        }
        newLead.Street = leadfields.get('Street');
        newLead.City = leadfields.get('City');
        newLead.State = leadfields.get('State');
        newLead.PostalCode = leadfields.get('Postalcode');
        newLead.Phone = leadfields.get('Phone');
        newLead.Roof_Type__c = leadfields.get('Roof_Type__c');
        if(leadfields.get('Status')!=null){
            newLead.Status = leadfields.get('Status');
        }else{
            newLead.Status = 'New';
        }
        if(leadfields.get('Location__c')!=null){
            newLead.Location__c = leadfields.get('Location__c');
        }else{
            //newLead.Location__c = 'UNKNOWN';
        }
        if(leadfields.get('SPE__c')!=null){
            newLead.SPE__c = leadfields.get('SPE__c');
        }else{
            //newLead.SPE__c = 'UNKNOWN';
        }
        if(leadfields.get('Mobile_Phone__c')!=null){
            newLead.Mobile_Phone__c = leadfields.get('Mobile_Phone__c');
        }else{
            //newLead.Mobile_Phone__c = leadfields.get('Phone');
        }
        newLead.LeadSource = 'Inbound Email';
        newLead.Description = plaintextbody;
        newLead.OwnerId = thisconfig.Owner__c;
      // Insert a new lead
      insert newLead;    
        
        CampaignMember newcampaign = new CampaignMember(LeadId = newLead.id, CampaignId = thisconfig.Campaign__c);
        insert newcampaign;
        result.success = true;       
      System.debug('New Lead record: ' + newLead );   
    } else {
      System.debug('Incoming email duplicates existing Lead record(s): ' + leads );    
    }
    // Set the result to true. No need to send an email back to the user      
    // with an error message   


    // Return the result for the Apex Email Service 

    }else{  result.success = false;
    }
   return result;                                                        
  }
}