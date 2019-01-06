@isTest
public class TestSearchContactControllerExtn3 {
    static PageReference pref;
    static Account acctObj;
    static Contact contactObj;
    static bt_stripe__Transaction__c transObj;
    static Product2 Prod2Obj;
    static PriceBookEntry pbeObj;
    static PriceBook2 PriceBookObj;
    static DCMSS_Devotee__c DevoteeObj;
    static PriceBookEntry standardPBE;
    static PriceBook2 standardPB;

    
    private static void init() {
      /*  acctObj=new account();
        acctObj.Name='Acme Co.';
        insert acctObj;*/
        
        contactObj =new contact();
        contactObj.FirstName='TestContact';
        contactObj.LastName='TestContact';
        contactObj.Email='TestContact@TestContact.com';
        //contactObj.npo02__Household__c= acctObj.Id;
        insert contactObj;
        
        
        
        DevoteeObj =new DCMSS_Devotee__c();
        DevoteeObj.First_Name__c='TestDevotee';
        DevoteeObj.Last_Name__c='TestDevotee';
        DevoteeObj.Email__c='TestDevotee@TestDevotee.com';
        DevoteeObj.Address__c='Test Address';
        DevoteeObj.Phone__c='777-777-7777';
        
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
 
       //[8/12/2017 Rajesh] Initialize custom settings to prevent test failures
        DCMSS_POS_Set__c settingsInstance = new DCMSS_POS_Set__c();
        settingsInstance.Name='POS Code';
        settingsInstance.POS_Verification_Code__c = '77777'; //'19711'; 
        settingsInstance.Current_Event__c = 'Rama Navami'; //'Ganesha Chaturthi';
        insert settingsInstance;
 
        
    }
     public static testMethod void testgotoMemberReg(){
        init();
        
        ApexPages.StandardController stdCont = new ApexPages.StandardController(contactObj);
        SearchContactControllerExtn ext = new SearchContactControllerExtn(stdCont); 
        
        //Member Navigation Tests
        pref=Page.PS_TemplSvcs_Step0;
        Test.setCurrentPage(pref);
        ext.gotoTemplSvcs();
        string surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step0');
        system.assertEquals(ext.Donor,false);
        
        ext.gotoRecvDonation();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step0');
        system.assertEquals(ext.Donor,true);
        
        ext.gotoEventSvcs();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step0');
        system.assertEquals(ext.Event,true);
        
        pref=Page.PS_TemplSvcs_Step1;
        Test.setCurrentPage(pref);
        
        ext.gotoMemberReg();
        system.assertEquals(ext.UserType,'Member');
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step1');
        
        pref=Page.PS_TemplSvcs_Step2;
        Test.setCurrentPage(pref);
        
        ext.gotoStep1();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step2');
        
        
        pref=Page.PS_TemplSvcs_Step3;
        Test.setCurrentPage(pref);
        
        ext.gotoStep1();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step3');
        
        pref=Page.PS_TemplSvcs_Step3;
        Test.setCurrentPage(pref);
        
        ext.gotoOffsiteSvcs();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step3');
        
        
        pref=Page.PS_TemplSvcs_Step3;
        Test.setCurrentPage(pref);
        
        ext.processStep2();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step3');
        
        pref=Page.PS_TemplSvcs_Step4;
        Test.setCurrentPage(pref);
        
        ext.processStep3();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step4');
        
        
        pref=Page.PS_TemplSvcs_Step4;
        Test.setCurrentPage(pref);
        
        ext.gotoStep1();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step4');
        
        pref=Page.PS_TemplSvcs_Step6;
        Test.setCurrentPage(pref);
        
        ext.processStep4();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step6');
        
        pref=Page.PS_TemplSvcs_Step6;
        Test.setCurrentPage(pref);
        
        ext.gotoStep1();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step6');
        
        pref=Page.PS_TemplSvcs_Step8;
        Test.setCurrentPage(pref);
        
        ext.processStep4();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step8');
        
        
        pref=Page.PS_TemplSvcs_Step8;
        Test.setCurrentPage(pref);
        
        ext.gotoStep1();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step8');
        
        pref=Page.PS_TemplSvcs_Step8;
        Test.setCurrentPage(pref);
        
        ext.gotoStep0();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step8');
        
        //Devotee Navigation Testing
        pref=Page.PS_TemplSvcs_Step0;
        ext.gotoTemplSvcs();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step0');
        system.assertEquals(ext.Donor,true);
        
        ext.gotoRecvDonation();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step0');
        system.assertEquals(ext.Donor,true);
        
        ext.gotoEventSvcs();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step0');
        system.assertEquals(ext.Event,true);
        
        pref=Page.PS_TemplSvcs_Step1;
        Test.setCurrentPage(pref);
        
        ext.gotoWalkIn();
        system.assertEquals(ext.UserType,'Devotee');
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step0');
        
        pref=Page.PS_TemplSvcs_Step3;
        Test.setCurrentPage(pref);
        
        ext.gotoStep1();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step3');
        
        pref=Page.PS_TemplSvcs_Step3;
        Test.setCurrentPage(pref);
        
        ext.processStep2();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step3');
        
        pref=Page.PS_TemplSvcs_Step4;
        Test.setCurrentPage(pref);
        
        ext.processStep3();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step4');
        
        pref=Page.PS_TemplSvcs_Step8;
        Test.setCurrentPage(pref);
        
        ext.processStep4();
        surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step8');
        
        
        
              
    }  
     public static testMethod void testgenReceipt(){
        
        init();
        
        ApexPages.StandardController stdCont = new ApexPages.StandardController(contactObj);
        SearchContactControllerExtn ext = new SearchContactControllerExtn(stdCont); 
        
        pref=Page.PS_TemplSvcs_Step2;
        pref.getParameters().put('id',contactObj.id);
        Test.setCurrentPage(pref);
        
        
        Test.startTest();
        // simulate the contact last name/email entry
        ext.userinput = DevoteeObj.Email__c;
        ext.userinp = DevoteeObj.Last_Name__c;
        ext.UserType='Devotee';
        ext.street='Test Street';
        ext.city='Test City';
        ext.state='TS';
        ext.zip='77777';
        ext.phone='777-777-7777';
        ext.Pymnt_Amt=126.0;
        ext.DevoteeId=null;
        ext.selectedPT='Check';
        ext.CHKNum='12345678';
        ext.BankName='BOA';
        ext.dt_CHKDt=Date.today();
         //  ext.selectedServices='Abhishekam';
      //  ext.selectedQty='1';
        
        pref=Page.PS_TemplSvcs_Step3;
        pref.getParameters().put('posselect','Abhishekam');
        Test.setCurrentPage(pref);

        ext.getPriceMethod();
        System.assertEquals(126.0,ext.Pymnt_Amt);

        ext.Add2Cart();
        ext.genReceipt();
        //System.assertEquals(pref.getUrl(),'/'+ext.contactObj.Id);
        //Check if the 
        system.assertNotEquals(ext.Receipt_Num,null);
        system.assertNotEquals(ext.PymntId,null);
        //system.assertNotEquals(ext.DevotId,null);
        
        ext.DevoteeId=DevoteeObj.Id;
        ext.genReceipt();
        system.assertNotEquals(ext.Receipt_Num,null);
        
        Contact contactToUpdate=[SELECT Id,FirstName,LastName,Email FROM Contact WHERE Id =: contactObj.Id];
        contactToUpdate.Email=null;
        
        update contactToUpdate;
        ext.userinput = 'TestContact2@TestContact2.com';
        ext.userinp = contactObj.LastName;
        ext.UserType='Member';
        ext.Pymnt_Amt=126.0;
        ext.ContactId=contactObj.Id;
        ext.ConAcctId=contactObj.npo02__Household__c;
        
        ext.ContactEmail=null;
        
        ext.genReceipt();
        system.assertNotEquals(ext.Receipt_Num,null);
        Contact afterUpdate=[SELECT Email from Contact where Id =: contactObj.Id];
        system.assertEquals('testcontact2@testcontact2.com', afterUpdate.Email);
        string surl=pref.getUrl();
        system.assertEquals(surl.substringBefore('?'),'/apex/ps_templsvcs_step3');
        Test.stopTest();
    }
   
    
    }