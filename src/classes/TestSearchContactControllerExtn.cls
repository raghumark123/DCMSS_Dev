@isTest
public class TestSearchContactControllerExtn {
    static PageReference pref;
    static Contact contactObj;
    static Product2 Prod2Obj;
    static PriceBookEntry pbeObj;
    static PriceBook2 PriceBookObj;
    static DCMSS_Devotee__c DevoteeObj;
    static PriceBookEntry standardPBE;
    static PriceBook2 standardPB;
   public static testMethod void testcontactsearch(){ 
        contactObj =new contact();
        contactObj.FirstName='TestContact';
        contactObj.LastName='TestContact';
        contactObj.Email='TestContact@TestContact.com';
        insert contactObj;
        
        DevoteeObj =new DCMSS_Devotee__c();
        DevoteeObj.First_Name__c='TestDevotee';
        DevoteeObj.Last_Name__c='TestDevotee';
        DevoteeObj.Email__c='TestDevotee@TestDevotee.com';
        insert DevoteeObj;  
        
        Prod2Obj =new Product2();
        Prod2Obj.Name='Abhishekam';
        Prod2Obj.IsActive = true;
        insert Prod2Obj; 
        
        PriceBookObj=new PriceBook2();
        PriceBookObj.Name='Temple Services 2016';
        PriceBookObj.IsActive=true;
        insert PriceBookObj;
       
        
        ID standardPBID = Test.getStandardPricebookId(); 
        standardPBE = new PriceBookEntry();
        standardPBE.Pricebook2Id=standardPBID;
        standardPBE.Product2Id= Prod2Obj.Id;
        standardPBE.UnitPrice=126.0;
        standardPBE.IsActive = true;
        standardPBE.UseStandardPrice = false;
        insert standardPBE;
        
        pbeObj = new PriceBookEntry();
        pbeObj.Pricebook2Id= PriceBookObj.Id;
        pbeObj.Product2Id= Prod2Obj.Id;
        pbeObj.UnitPrice=126.0;
        pbeObj.IsActive = true;
        pbeObj.UseStandardPrice = false;
        insert pbeObj;  
    
        String surl;        
        ApexPages.StandardController stdCont = new ApexPages.StandardController(contactObj);
        SearchContactControllerExtn ext = new SearchContactControllerExtn(stdCont); 
        
        pref=Page.PS_TemplSvcs_Step2;
        pref.getParameters().put('id',contactObj.id);
        Test.setCurrentPage(pref);

        ext.userinput='';
        ext.userinp=contactObj.LastName;
       
        
        try {
        ext.contactsearch();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Last Name and Email are required.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }

        ext.userinput=contactObj.Email;
        ext.userinp='';

        try {
        ext.contactsearch();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Last Name and Email are required.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
             
        // simulate the contact last name/email entry
        ext.userinp = contactObj.LastName;
        
        
        ext.contactsearch();
        System.assertEquals('TestContact',ext.FirstTestContactName);
        surl=pref.getUrl();
        System.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step2');

        ext.userinput ='testtest.com';
        try {
        ext.contactsearch();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Please enter proper email address') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
             
          
       ext.userinput = contactObj.Email;
       try {   
       ext.processSelectedContact();
       }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('No Contact Record Selected !!') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
       
       ext.contactList.get(0).selected=true;
       ext.processSelectedContact();
       system.assertEquals(ext.ContactEmail,'testcontact@testcontact.com');
        
        
        pref=Page.PS_TemplSvcs_Step3;
        pref.getParameters().put('id',contactObj.id);
        Test.setCurrentPage(pref);
            
        pref=Page.PS_TemplSvcs_Step3;
        pref.getParameters().put('posselect','Abhishekam');
        Test.setCurrentPage(pref);

        ext.getPriceMethod();
        System.assertEquals(126.0,ext.Pymnt_Amt);

        pref=Page.PS_TemplSvcs_Step3;
        pref.getParameters().put('selq','2');
        pref.getParameters().put('posselect','Abhishekam');
        Test.setCurrentPage(pref);

        ext.getPriceMethod();
        ext.getPriceMethod2();
        System.assertEquals(252.0,ext.Pymnt_Amt);

        ext.capturePayment();
        surl=pref.getUrl();
        System.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step3');
       
        pref=Page.PS_TemplSvcs_Step4;
        Test.setCurrentPage(pref);

        ext.selectedPT='Credit Card';
        ext.CCName='Test Customer';
        ext.CCNum='';
        ext.CCCVC='000';
        ext.selectedExpYr=19;
        ext.selectedExpMnth=09;

        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('payment field(s) are blank.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        ext.CCNum='4242424242424242';
        ext.selectedExpYr=16;
        ext.selectedExpMnth=09;
        
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Credit Card expired.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        ext.CCNum='424242424242424242';
        ext.selectedExpYr=19;
        ext.selectedExpMnth=09;
        
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('16 digits only Dash and space in-between allowed.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        
        ext.CCNum='4242424242424242';
        ext.CCCVC='00';
    
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('CVC Code should be 3 digits only') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        ext.selectedPT='Check';
        ext.BankName='';
        ext.CHKNum='';
        ext.CHKDate='05/01/2017';
            
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('One or more of the required check fields are blank.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        ext.CHKNum='12345678';
        ext.CHKDate='15/05/2017';
            
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('date with the format MM/DD/YYYY') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
             
        ext.CHKDate='02/07/2016';
            
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Check date is back dated') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }  
                
        ext.CHKDate='05/01/2017';
        ext.processPayment();
        System.assertEquals(pref.getUrl(),'/apex/ps_templsvcs_step4');
        
        pref=Page.PS_TemplSvcs_Step4;
        pref.getParameters().put('id',contactObj.id);
        Test.setCurrentPage(pref);
        
        ext.getTmplCEM();
        System.assertEquals(ext.getTmplCEM().size(),13);
        
        ext.getTmplPTOptions();
        System.assertEquals(ext.getTmplPTOptions().size(),3);
        
        ext.getTmplCEYOptions();
        System.assertEquals(ext.getTmplCEYOptions().size(),8);

        
        //DEVOTEE TEST SECTION
        pref=Page.PS_TemplSvcs_Step2;
        pref.getParameters().put('id',contactObj.id);
        Test.setCurrentPage(pref);


        ext.userinput='';
        ext.userinp='';
       
        
        try {
        ext.devoteesearch();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Last Name and Email are required.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
             
             
        //Simulate devotee last name and email entry
        ext.userinput = DevoteeObj.Email__c;
        ext.userinp = DevoteeObj.Last_Name__c;
        
        
        ext.devoteesearch();
        System.assertEquals('TestDevotee', ext.DevoteeLastName);
        surl=pref.getUrl();
        System.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step2');
        
        
        ext.userinput ='testtest.com';
        try {
        ext.devoteesearch();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Please enter proper email address') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
                 
        pref=Page.PS_TemplSvcs_Step3;
        pref.getParameters().put('posselect','Abhishekam');
        ext.selectedQty=null;
        Test.setCurrentPage(pref);

        ext.getPriceMethod();
        System.assertEquals(126.0,ext.Pymnt_Amt);

        pref=Page.PS_TemplSvcs_Step3;
        pref.getParameters().put('selq','2');
        pref.getParameters().put('posselect','Abhishekam');
        Test.setCurrentPage(pref);

        ext.getPriceMethod();
        ext.getPriceMethod2();
        System.assertEquals(252.0,ext.Pymnt_Amt);

        ext.capturePayment();
        surl=pref.getUrl();
        System.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step3');


        pref=Page.PS_TemplSvcs_Step4;
        Test.setCurrentPage(pref);


        ext.selectedPT='Credit Card';
        ext.CCName='Test Customer';
        ext.CCNum='';
        ext.CCCVC='000';
        ext.selectedExpYr=19;
        ext.selectedExpMnth=09;

        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('payment field(s) are blank.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        ext.CCNum='4242424242424242';
        ext.selectedExpYr=16;
        ext.selectedExpMnth=09;
        
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Credit Card expired.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        ext.CCNum='424242424242424242';
        ext.selectedExpYr=19;
        ext.selectedExpMnth=09;
        
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('16 digits only Dash and space in-between allowed.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        
        ext.CCNum='4242424242424242';
        ext.CCCVC='00';
    
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('CVC Code should be 3 digits only') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        ext.selectedPT='Check';
        ext.BankName='';
        ext.CHKNum='';
        ext.CHKDate='05/01/2017';
            
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('One or more of the required check fields are blank.') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
        
        ext.CHKNum='12345678';
        ext.CHKDate='15/05/2017';
            
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('date with the format MM/DD/YYYY') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }
             
        ext.CHKDate='02/07/2016';
            
        try {
        ext.processPayment();
        }
        catch(Exception e){
             Boolean expectedExceptionThrown =  e.getMessage().contains('Check date is back dated') ? true : false;
             system.assertEquals(expectedExceptionThrown,true);  
             }  
                
        ext.CHKDate='05/01/2017';
        ext.processPayment();
        System.assertEquals(pref.getUrl(),'/apex/ps_templsvcs_step4');

        
        
    }
      
     
   
}