/**
 * An apex page controller that supports self registration of users in communities that allow self registration
 */
public with sharing class CommunitiesSelfRegController {

    public String numericId {get; set;}    //Numeric_ID__c
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    
    public CommunitiesSelfRegController() {}
    
    private boolean isValidPassword() {
        return password == confirmPassword;
    }

    public PageReference registerUser() {
    
           // it's okay if password is null - we'll send the user a random password in that case
        if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }    

        RecordType personAcctRecType = [SELECT Id, Name FROM RecordType WHERE Name = 'Person Account' LIMIT 1];
        Account personAcct = [SELECT Id, Name, Numeric_ID__c, RecordTypeId, State__c FROM Account WHERE Numeric_ID__c =:numericId LIMIT 1];
        System.Debug(personAcct.Id);
        if (personAcct.Id != null) {
            String profileId = [SELECT Id FROM Profile WHERE Name = 'PGCustomer Community Login User' LIMIT 1].Id;
            String roleEnum = null; // To be filled in by customer.
            String accountId = personAcct.Id;
            System.Debug('>>>>Account Id is ' + accountId);
            
            Datetime myTs = Datetime.now();
            String myTsString = myTs.format('mmss');
            String userName = myTsString + email;
            String acctContact = [SELECT Id FROM Contact WHERE AccountId =:accountId LIMIT 1].Id;
    
            User u = new User();
            u.Username = userName;
            u.Email = email;
            u.FirstName = firstName;
            u.LastName = lastName;
            u.CommunityNickname = communityNickname;
            u.ProfileId = profileId;
            u.ContactId = acctContact;
            u.Alias = firstName.substring(0,1) + lastName.substring(0,1);
            u.LanguageLocaleKey = 'en_US';
            u.LocaleSidKey = 'en_US';
            u.TimeZoneSidKey = (personAcct.State__c == 'NY' | personAcct.State__c == 'CT')?'America/New_York':'America/Chicago';
            u.EmailEncodingKey = 'ISO-8859-1';
            
            try {
                Database.DMLOptions dlo = new Database.DMLOptions();
                dlo.EmailHeader.triggerUserEmail = true;
                Database.SaveResult sr = Database.insert(u, dlo);
            } catch (DmlException e) {
                System.debug(e);
                return null;
            }
            
            String userId = [SELECT Id FROM User WHERE Username =: userName AND ContactId =: acctContact].Id;
            if (userId != null) { 
                if (password != null && password.length() > 1) {
                    return Site.login(userName, password, null);
                }
                else {
                    PageReference page = System.Page.CommunitiesSelfRegConfirm;
                    page.setRedirect(true);
                    return page;
                }
            }   //if(userId != null)
            

        }   //if (personAcct.Id != null)
        return null;
    }    //public PageReference registerUser
}    //public with sharing class CommunitiesSelfRegController