@isTest(SeeAllData=true)
public class TestSearchContactControllerExtn2 {
    static PageReference pref;
 
public static testMethod void testsubmitPayment(){
       
        Contact cont =[SELECT Id, FirstName,LastName,Email FROM Contact where FirstName='Raghu' and LastName='Rao'];
        ApexPages.StandardController stdCont = new ApexPages.StandardController(cont);
        SearchContactControllerExtn ext = new SearchContactControllerExtn(stdCont); 
        pref=Page.PS_TemplSvcs_Step4;
        Test.setCurrentPage(pref);
             
        ext.selectedPT='Credit Card';
        ext.CCName='Test Customer';
        ext.CCNum='4242424242424242';
        ext.CCCVC='000';
        ext.selectedExpYr=19;
        ext.selectedExpMnth=09;
        ext.userinput=cont.Email;
        ext.Pymnt_Amt=126.0;
        bt_stripe__Stripe_Settings__c settings = bt_stripe__Stripe_Settings__c.getOrgDefaults();
        settings.bt_stripe__Disable_All_Triggers__c = true;
        upsert settings;
        
        ext.testrun=true;
        
        
         try {
        ext.submitPayment();
        }
        catch(Exception e){
             //Boolean expectedExceptionThrown =  e.getMessage().contains('Check date is back dated') ? true : false;
             //system.assertEquals(expectedExceptionThrown,true);  
             system.assertEquals(e.getMessage(),null); 
             
             } 
       // ext.assertNotEquals(ext.paymentGatewayId,null);
        system.assertEquals(ext.teststr,'Success'); 
        
        
      }
  }