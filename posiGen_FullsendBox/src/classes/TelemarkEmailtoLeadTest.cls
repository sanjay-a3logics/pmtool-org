/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seealldata=true)
private class TelemarkEmailtoLeadTest {
/*    static Specialty_Code__c spc;
    
    static{
        acc = createTestAccount();
    }
*/

	static testMethod void TestinboundAppointment(){
       // create a new email and envelope object
		Messaging.InboundEmail email = new Messaging.InboundEmail() ;
		Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
       
       // setup the data for the email
		email.subject = 'PosiGen Appointment Request';
		email.fromAddress = 'someaddress@email.com';
		email.plainTextBody = 'Address ';
		email.plainTextBody = email.plainTextBody + ' 413 Helis dr. ';
		email.plainTextBody = email.plainTextBody + ' Roof Type ';
		email.plainTextBody = email.plainTextBody + ' composition_shingle ';
		email.plainTextBody = email.plainTextBody + ' Average Energy Bill ';
		email.plainTextBody = email.plainTextBody + ' 290.0 ';
		email.plainTextBody = email.plainTextBody + ' Name ';
		email.plainTextBody = email.plainTextBody + ' john mills ';
		email.plainTextBody = email.plainTextBody + ' Email ';
		email.plainTextBody = email.plainTextBody + ' branmil5@bellsouth.net<mailto:branmil5@bellsouth.net> ';
		email.plainTextBody = email.plainTextBody + ' Phone Number ';
		email.plainTextBody = email.plainTextBody + ' 5049202125 ';
		email.plainTextBody = email.plainTextBody + ' Image ';
		email.plainTextBody = email.plainTextBody + ' http://posigen.com/addresses/413Helisdr.70094_642.jpg ';
      
      // add an Binary attachment
		Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
		attachment.body = blob.valueOf('my attachment text');
		attachment.fileName = 'textfileone.txt';
		attachment.mimeTypeSubType = 'text/plain';
		email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

      // add an Text atatchment
  
		Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
		attachmenttext.body = 'my attachment text';
		attachmenttext.fileName = 'textfiletwo3.txt';
		attachmenttext.mimeTypeSubType = 'texttwo/plain';
		email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
      
      
      // call the email service class and test it with the data in the testMethod
		TelemarkEmailtoLead  testInbound=new TelemarkEmailtoLead ();
		testInbound.handleInboundEmail(email, env);
	}
   
	static testMethod void TestinBoundanswerquick(){
       // create a new email and envelope object
		Messaging.InboundEmail email = new Messaging.InboundEmail() ;
		Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
       
		// setup the data for the email
		email.subject = 'new messages for 2807';
		email.fromAddress = 'someaddress@email.com';
		email.plainTextBody = ' Green Grants - Account 2807  ';
		email.plainTextBody = email.plainTextBody + ' =========================== ';
		email.plainTextBody = email.plainTextBody + ' Oper: CMF                                                  Date: 07/23/2013  ';
		email.plainTextBody = email.plainTextBody + ' Order Number: 2400004239                                   Time: 19:37:11 ';
		email.plainTextBody = email.plainTextBody + ' Is Emergency:  ';
		email.plainTextBody = email.plainTextBody + ' Reason: 1-SALES                                  Disposition: 1-MESSAGE/ORDER ';
		email.plainTextBody = email.plainTextBody + ' Name: Monique Soileaux ';
		email.plainTextBody = email.plainTextBody + ' Phone: 337-466-1106 ';
		email.plainTextBody = email.plainTextBody + ' Address: 1710 Yukon St, Eunice, LA 70535 ';
		email.plainTextBody = email.plainTextBody + ' How Heard: ON LINE ';
		email.plainTextBody = email.plainTextBody + ' Residential or Commercial: 1-RESIDENTIAL ';
		email.plainTextBody = email.plainTextBody + ' Message: NEEDS TO KNOW MORE INFORMATION ON THE SOLAR PANELS. PLEASE CALL ';
		email.plainTextBody = email.plainTextBody + '  ';
		email.plainTextBody = email.plainTextBody + '  ';
		email.plainTextBody = email.plainTextBody + ' Message # 1                         ';           
		email.plainTextBody = email.plainTextBody + ' =================================== ';
      
      // add an Binary attachment
		Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
		attachment.body = blob.valueOf('my attachment text');
		attachment.fileName = 'textfileone.txt';
		attachment.mimeTypeSubType = 'text/plain';
		email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };      
  
      // add an Text atatchment  
		Messaging.InboundEmail.TextAttachment attachmenttext = new Messaging.InboundEmail.TextAttachment();
		attachmenttext.body = 'my attachment text';
		attachmenttext.fileName = 'textfiletwo3.txt';
		attachmenttext.mimeTypeSubType = 'texttwo/plain';
		email.textAttachments =   new Messaging.inboundEmail.TextAttachment[] { attachmenttext };
      
      
      // call the email service class and test it with the data in the testMethod
      TelemarkEmailtoLead  testInbound=new TelemarkEmailtoLead ();
      testInbound.handleInboundEmail(email, env);
   }
}