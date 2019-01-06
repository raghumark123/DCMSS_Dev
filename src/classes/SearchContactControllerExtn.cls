public class SearchContactControllerExtn {

 //Constructor Function. The campaign id is captured in this function */
public SearchContactControllerExtn(ApexPages.StandardController controller)
{
 //cid=System.currentPageReference().getParameters().get('id');
}
/* Variable declarations */

Public String cid;                                                            // Stores Contact Id
public List<cContact> contactList {get; set;}                                 // Wrapper class which stores contact data and a boolean flag.
//public List<dDevotee> devoteeList {get; set;}
public List<PricebookEntry> PricebookEntryList{get; set;}               //Wrapper class which stores a product selected from UI and returns its pricing
public List<PricebookEntry> OptyItem{get;set;} //Opportunity Product Item - Shopping Cart 
public List<Product2> prodList{get;set;}
public List<PriceBook2> pbList{get;set;}
public List<DCMSS_POS_Set__c> mcs{get;set;}
public Boolean selectAllCheckbox {get; set;}                                  // Stores checkbox data.
public boolean errormsg=false;                                                  // Error msg. When no contact has been selected.                                            
String ConId;
public String userinput;                                                             //Contact Email
public String userinp; 
public String userfirstname;
public String street='NA';
public String city='NA';
public String zip='77777';
public String state='NA';
public String phone='999-999-9999';
public Decimal DonationAmt; 
public String DonationDesc;                                         
public String FirstTestContactName; //Contact Last Name
String MobilePhone;                                                            
public String FirstName;  
public String LastName;
public String DevoteeFirstName;   
public String DevoteeLastName;   
public String DevoteeName;                                                                                                               
String MailingAddr;                                                             
String Membership_ID;                                                             
String Devotee_ID;                                                               
String Pymnt_Type;  
String Opty_Type='';
public Decimal Pymnt_Amt;                                                           
Integer Pymnt_Qty;                                                                
String Pymnt_Chq_No;                                                             
Date Pymnt_Dt;                                                             
Decimal Pymnt_Total_Amt;                                                                
String Pymnt_Service_Chg;                                                             
String Recpt_No;                                                             
String Pymnt_Bank;                                                                
Integer Pymnt_Card_No; 
String Pymnt_Card_Type;                                                             
Date Pymnt_Card_Exp_Dt;                                                             
Integer Pymnt_Card_Cd;                                                                
String Pymnt_Gateway;                                                             
public String Receipt_Num;                                                             
public String ContactId;
public String ContactEmail;
public String ContactStreet;
public String ContactPhone;
public String ConAcctId;
public String DevoteeId;
public String customerID;
public String traID;
public String pmID;
public Id OptyId;
public Id DevotId;
public Date dt_CHKDt;
public Id PymntId;
public Id transID;
public boolean testrun=false;
public String teststr;
public boolean displayboxes;

public List<Contact> results = new List<Contact>();                                     // Contact search results.
public List<Contact> selectedContactsstep2 = new List<Contact>();                         // Selcted Contacts
public List<DCMSS_Devotee__c> dresults = new List<DCMSS_Devotee__c>();                                     // Devotee search results.
public List<DCMSS_Devotee__c> selectedDevoteesstep2 = new List<DCMSS_Devotee__c>();                         // Selcted Devotees
//List<OpportunityLineItem> OptyProdList = new List<OpportunityLineItem>();
/* End of Variable declarations */

/* Getter and setter methods for getting the user input ie. Contact name and email from the UI */

public String getuserinput(){return userinput;}
public void setuserinput(String userinput){this.userinput=userinput;}
public String getuserinp(){return userinp;}
public void setuserinp(String userinp){this.userinp=userinp;}
public String getuserfirstname(){return userfirstname;}
public void setuserfirstname(String userfirstname){this.userfirstname=userfirstname;}
public String getstreet(){return street;}
public void setstreet(String street){this.street=street;}

public String getcity(){return city;}
public void setcity(String city){this.city=city;}
public String getzip(){return zip;}
public void setzip(String zip){this.zip=zip;}
public String getstate(){return state;}
public void setstate(String state){this.state=state;}
public String getphone(){return phone;}
public void setphone(String phone){this.phone=phone;}
public String selectedServices;
public String getselectedServices(){return selectedServices;}
public void setselectedServices(String selectedServices){this.selectedServices=selectedServices;}
public String selectedQty;
public String getselectedQty(){return selectedQty;}
public void setselectedQty(String selectedQty){this.selectedQty = selectedQty;}
public Decimal GrandTotal=0.0;
public Decimal getGrandTotal(){return GrandTotal;}
public void setGrandTotal(Decimal GrandTotal){this.GrandTotal = GrandTotal;}
public String selectedPT;
public String getselectedPT(){return selectedPT;}
public void setselectedPT(String selectedPT){this.selectedPT=selectedPT;}
public String CCName;
public String getCCName(){
    if(UserType=='Member')
    CCName=Name;
    else if (UserType=='Devotee' && DevoteeId != null)
    CCName=DevoteeName;
    return CCName;}
public void setCCName(String CCName){this.CCName=CCName;}
public String CCNum; 
public String getCCNum(){return CCNum;}
public void setCCNum(String CCNum){this.CCNum=CCNum;}
public Integer selectedExpMnth;
public Integer getselectedExpMnth(){return selectedExpMnth;}
public void setselectedExpMnth(Integer selectedExpMnth){this.selectedExpMnth=selectedExpMnth;}
public Integer selectedExpYr;
public Integer getselectedExpYr(){return selectedExpYr;}
public void setselectedExpYr(Integer selectedExpYr){this.selectedExpYr=selectedExpYr;}
public String CCCVC; 
public String getCCCVC(){return CCCVC;}
public void setCCCVC(String CCCVC){this.CCCVC=CCCVC;}
public String Name;  
public String getName(){return Name;}
public void setName(String Name){this.Name=Name;}
public String BankName;
public String getBankName(){
    return BankName;}
public void setBankName(String BankName){this.BankName=BankName;}
public String VolunteerCode;
public String getVolunteerCode(){
    return VolunteerCode;}
public void setVolunteerCode(String VolunteerCode){this.VolunteerCode=VolunteerCode;}
public String CHKNum; 
public String getCHKNum(){return CHKNum;}
public void setCHKNum(String CHKNum){this.CHKNum=CHKNum;}
public String CHKDate; 
public String getCHKDate(){return CHKDate;}
public void setCHKDate(String CHKDate){this.CHKDate=CHKDate;}
public String UserType;
public String getUserType(){return UserType;}
public Boolean Donor=false;
public Boolean getDonor(){return Donor;}
public void setDonor(Boolean Donor){this.Donor=Donor;}
public Boolean Event=false;
public Boolean getEvent(){return Event;}
public void setEvent(Boolean Event){this.Event=Event;}
public Decimal getDonationAmt(){return DonationAmt;}
public void setDonationAmt(Decimal DonationAmt){this.DonationAmt=DonationAmt;}
public String getDonationDesc(){return DonationDesc;}
public void setDonationDesc(String DonationDesc){this.DonationDesc=DonationDesc;}
/*End of Getter and Setter methods */
public String getReceipt_Num(){return Receipt_Num;}
public String stripeTransId;
public String getstripeTransId(){return stripeTransId;}
public String lfourdigit;
public String getlfourdigit(){return lfourdigit;}
Set<Id> Ids= new Set<Id>();
public Map<Id,Integer> CartList = New Map<Id,Integer>();
/* Method to Search the contact database to fetch the query results */
public List<Contact> contactsearch()
{
     
     errormsg=false;
     if(userinput == '' || userinp == '') {

        errormsg=true; 

        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Last Name and Email are required.'));

        return null;

   }
   if (userinput !='' && !Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', userinput)){
    errormsg=true; 
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please enter proper email address'));
   }
   
 
     contactList = new List<cContact>();
     for(Contact c : [select Id,Name,FirstName,LastName,Email,MobilePhone,Phone,MailingAddress,MailingStreet,npo02__Household__c from Contact where LastName =: userinp AND Email =: userinput LIMIT 1])
     {
         contactList.add(new cContact(c));
     }
     if(contactList.size()==0){
        for(Contact c : [select Id,Name,FirstName,LastName,Email,MobilePhone,Phone,MailingAddress,MailingStreet,npo02__Household__c from Contact where LastName =: userinp OR Email =: userinput LIMIT 20])
        {
         contactList.add(new cContact(c));
        }
     }
     if(contactList.size() != 0)
     FirstTestContactName=contactList[0].con.LastName;
     else
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Member found !! Please check the information and try again!'));
 return null;
}
/* End of method */
/* Method to Search the devotee database to fetch the query results */

public PageReference devoteesearch()
{
     errormsg=false;
     if(userinput == '' || userinp == '' || userfirstname == '' || street == ''  || city == '' || zip =='' || state =='' || phone=='') {

        errormsg=true; 

        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'First Name, Last Name, Email, Address and Phone are required.'));

        return null;

   }
   if (userinput !='' && !Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', userinput)){
    errormsg=true; 
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please enter proper email address'));
    return null;
   }
   if (phone !='' && !Pattern.matches('^(?=.*?[1-9])[0-9()-]+$', phone)){
    errormsg=true;
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please enter phone in proper format'));
    return null;
   }
   if (phone !='' && !Pattern.matches('\\D*?(\\d\\D*?){10}', phone)){
    errormsg=true; 
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'US phone numbers should be in this format: (999) 999-9999.'));
   }
   if(zip !='' && !Pattern.matches('\\d{5}(-\\d{4})?',zip)){
    errormsg=true; 
    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Please enter US Zip in  99999 or 99999-9999 format'));
   }
   
   for(Contact cont : [select Id,Name,FirstName,LastName,Email,MobilePhone,Phone,MailingStreet,MailingAddress,npo02__Household__c from Contact where LastName =: userinp AND Email =: userinput AND FirstName =: userfirstname LIMIT 1])
     {
             UserType='Member';
             ContactId=cont.Id;
              //Added by Hareesh 12/6/2017
             FirstName=cont.FirstName;
             LastName=cont.LastName;
             Name=cont.Name;
             ConAcctId=cont.npo02__Household__c;
             ContactEmail=cont.Email;
             ContactStreet=cont.MailingStreet;
             ContactPhone=cont.phone;
            //End by Hareesh 12/6/2017
         
      }
     //Added User Type condition by Hareesh 12/6/2017
     if(DevoteeId==null && UserType=='Devotee') {
     for(DCMSS_Devotee__c d : [select Id,First_Name__c,Last_Name__c,Email__c,Phone__c,Address__c from DCMSS_Devotee__c where Last_Name__c =: userinp AND Email__c =: userinput AND First_Name__c =: userfirstname LIMIT 1])
     {
             DevoteeFirstName=d.First_Name__c;
             DevoteeLastName=d.Last_Name__c;
             DevoteeId=d.Id;
             DevoteeName=DevoteeFirstName+' '+DevoteeLastName;
         
      }
      for(DCMSS_Devotee__c d : [select Id,First_Name__c,Last_Name__c,Email__c,Phone__c,Address__c from DCMSS_Devotee__c where Last_Name__c =: userinp AND Email__c =: userinput LIMIT 1])
     {
             DevoteeFirstName=userfirstname;
             DevoteeLastName=d.Last_Name__c;
             DevoteeId=d.Id;
             DevoteeName=DevoteeFirstName+' '+DevoteeLastName;
         
      }
      
     }//end of if(DevoteeId==null)
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
      if(Event==true){
          List<DCMSS_POS_Set__c> mcs = DCMSS_POS_Set__c.getall().values();
          if (mcs[0].Current_Event__c == 'Rama Navami')
            p=page.PS_TemplSvcs_Step12; 
          else if (mcs[0].Current_Event__c == 'Ganesha Chaturthi')
            p=page.PS_TemplSvcs_Step13; 
          else if (mcs[0].Current_Event__c == 'Vijaya Dasami')
            p=page.PS_TemplSvcs_Step14; 
          else if (mcs[0].Current_Event__c == 'Pratishtha Din')
            p=page.PS_TemplSvcs_Step15;
          else
          p=page.PS_TemplSvcs_Step10;
      }
     
     p.setRedirect(false);
     return p;
  
}
/* End of method */

/* Method to Search the product database to fetch the price results */
public void getPriceMethod()
{
    
    
     selectedServices = apexpages.currentpage().getparameters().get('posselect'); 
     if(selectedQty == null || selectedQty == ''){selectedQty='1';}
     List<Product2> prodList =[SELECT Id FROM Product2 WHERE Name =: selectedServices Limit 1];
     if(prodList.size() ==0)
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Product not found ! Please check if Product record is present !!'));
     List<PriceBook2> pbList=[SELECT Id from PriceBook2 WHERE Name=:'Temple Services 2016' Limit 1];
    if(pbList.size() ==0)
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'PriceBook entry not found ! Please check if Pricebook is setup !!'));
    PricebookEntryList = database.Query('select Id,ProductCode,UnitPrice,TotPrice__c,Qty__c,Description__c from PriceBookEntry where Pricebook2Id =: pbList AND Product2Id =: prodList LIMIT 1');
    if(PricebookEntryList.size() ==0)
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Product or Pricebook is not set up.!!'));
   PricebookEntryList[0].TotPrice__c=PricebookEntryList[0].UnitPrice*Integer.ValueOf(selectedQty);
    PricebookEntryList[0].Qty__c=Integer.ValueOf(selectedQty);
    Pymnt_Amt=PricebookEntryList[0].TotPrice__c;
    //Ids.add(PricebookEntryList[0].Id);
    //CartList.put(PricebookEntryList[0].Id,Integer.ValueOf(selectedQty));   
}
/* End of method */
public void getPriceMethod2()
{
    errormsg=false; 
    selectedQty = apexpages.currentpage().getparameters().get('selq');
    if(selectedServices == null || selectedServices == ''){
       selectedServices='Abhishekam';
       if(Event==true)
           selectedServices='Sai Satya Vratam';
    
    }
    else {
    List<Product2> prodList =[SELECT Id FROM Product2 WHERE Name =: selectedServices Limit 1];
    if(prodList.size() ==0)
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Product not found ! Please check if Product record is present !!'));
    List<PriceBook2> pbList=[SELECT Id from PriceBook2 WHERE Name=:'Temple Services 2016' Limit 1];
    if(pbList.size() ==0)
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'PriceBook entry not found ! Please check if Pricebook is setup !!'));
    PricebookEntryList = database.Query('select Id,ProductCode,UnitPrice,TotPrice__c,Qty__c,Description__c from PriceBookEntry where Pricebook2Id =: pbList AND Product2Id =: prodList LIMIT 1');
    if(PricebookEntryList.size() ==0)
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Product or Pricebook is not set up.!!'));
    PricebookEntryList[0].TotPrice__c=PricebookEntryList[0].UnitPrice*Integer.ValueOf(selectedQty);
    PricebookEntryList[0].Qty__c=Integer.ValueOf(selectedQty);
    Pymnt_Amt=PricebookEntryList[0].TotPrice__c;
     //Ids.add(PricebookEntryList[0].Id); 
     //CartList.put(PricebookEntryList[0].Id,Integer.ValueOf(selectedQty));
    }
}
/* End of method */
/*Method to add the current PricebookEntryList record to the Opportunity Product record list*/
public void Add2Cart(){
      if (PricebookEntryList != null && PricebookEntryList.size() > 0 ) {
      Ids.add(PricebookEntryList[0].Id); 
      CartList.put(PricebookEntryList[0].Id,Integer.ValueOf(selectedQty));
      OptyItem = database.Query('select Id,ProductCode,UnitPrice,TotPrice__c,Qty__c,Description__c,Product_Desc__c from PriceBookEntry where Id in :Ids');
      Integer i=0;
      GrandTotal=0.0;
      for(PriceBookEntry PBE : OptyItem ){
        OptyItem[i].Qty__c=CartList.get(PBE.Id);
        if(OptyItem[i].ProductCode=='Donation') {
            OptyItem[i].UnitPrice=DonationAmt;
            OptyItem[i].TotPrice__c=DonationAmt*OptyItem[i].Qty__c;
            OptyItem[i].Product_Desc__c=DonationDesc;
        
        }
        else {
            OptyItem[i].TotPrice__c=OptyItem[i].UnitPrice*OptyItem[i].Qty__c;
            OptyItem[i].Product_Desc__c=OptyItem[i].Description__c;
        }
        GrandTotal=GrandTotal+OptyItem[i].TotPrice__c;
        Pymnt_Amt=GrandTotal;
        i++;
      }
      PricebookEntryList.clear();
     } 
}
/*End of Add2Cart*/
/*Method to delete the current PricebookEntryList record from the Opportunity Product record list*/
public void DelFmCart(){
      Integer i=0;
      if ( PricebookEntryList !=null && PricebookEntryList.size() > 0 && CartList.size() > 0) {
      for(PriceBookEntry PBE : OptyItem ){

      if(PricebookEntryList[0].Id == OptyItem[i].Id ) {
        GrandTotal=GrandTotal-OptyItem[i].TotPrice__c;
        Pymnt_Amt=GrandTotal;
        OptyItem[i].Qty__c=10;
      }
      i++;
        
      
      }

      Integer j = 0;
      while (j < OptyItem.size())
      {
        if(OptyItem[j].Qty__c == 10)
        {
          OptyItem.remove(j);
          Ids.remove(PricebookEntryList[0].Id);
          CartList.remove(PricebookEntryList[0].Id);
        }else
        {
            
          j++;
        }
      }
      PricebookEntryList.clear();

      }
}
/*End of DelFmCart*/
/* Method for returning the contact search results to the UI */
public List<cContact> getresults()
{
 return contactList;

}
/* End of Method */

/* Wrapper class to contain contact record and a boolean flag */
public class cContact
{
 public Contact con {get; set;}
 public Boolean selected {get; set;}

 /*This is the contructor method. When we create a new cContact object we pass a
 Contact that is set to the con property. We also set the selected value to false*/
 public cContact(Contact c)
 {
     con = c;
     selected = false;
 }
}
/* end of Wrapper class */

/* Method to fetch the selected Member records from Step 2 */

public PageReference processSelectedContact()
{

  List<Contact> selectedContacts = new List<Contact>();
  if (contactList!= null)
  {
     for(cContact cCon : getresults()){
        if(cCon.selected == true){
             selectedContacts.add(cCon.con);
             FirstName=selectedContacts[0].FirstName;
             LastName=selectedContacts[0].LastName;
             Name=selectedContacts[0].Name;
             ContactId=selectedContacts[0].Id;
             ConAcctId=selectedContacts[0].npo02__Household__c;
             ContactEmail=selectedContacts[0].Email;
             ContactStreet=selectedContacts[0].MailingStreet;
             ContactPhone=selectedContacts[0].phone;
             if (userinput !='' && !Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', userinput)) {
              userinput=ContactEmail;

             }
         }
     }
        
     selectedContactsstep2=selectedContacts;
  }
 /* return error message if no contact is selected */
 if (selectedContacts.size()==0)
 {
     errormsg=true;
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No Contact Record Selected !!'));
     return null;
 }
 else
 {
     errormsg=false;
     
     Pagereference p=page.PS_TemplSvcs_Step3;
     

     if(Event==true){
         List<DCMSS_POS_Set__c> mcs = DCMSS_POS_Set__c.getall().values();
         if (mcs[0].Current_Event__c == 'Rama Navami')
            p=page.PS_TemplSvcs_Step12; 
        else if (mcs[0].Current_Event__c == 'Ganesha Chaturthi')
            p=page.PS_TemplSvcs_Step13; 
        else if (mcs[0].Current_Event__c == 'Vijaya Dasami')
            p=page.PS_TemplSvcs_Step14; 
        else if (mcs[0].Current_Event__c == 'Pratishtha Din')
            p=page.PS_TemplSvcs_Step15;
         else
            p=page.PS_TemplSvcs_Step10;
     }
     p.setRedirect(false);
     return p;
 }

}

/*public List<SelectOption> getItems()
{
 List<SelectOption> options = new List<SelectOption>();
 options.add(new SelectOption('YES','YES'));
 options.add(new SelectOption('NO','NO'));
 return options;
}*/
    
public List<SelectOption> getTmplPTOptions()
{
 List<SelectOption> TmplPTOptions = new List<SelectOption>();
  TmplPTOptions.add(new SelectOption('NONE','-None-',true));
  TmplPTOptions.add(new SelectOption('Credit Card','CREDIT CARD'));
  TmplPTOptions.add(new SelectOption('Check','CHECK'));
  TmplPTOptions.add(new SelectOption('Cash','CASH'));
 return TmplPTOptions;
}

public List<SelectOption> getTmplCEM() {
        List<SelectOption> TmplCEM = new List<SelectOption>();
        TmplCEM.add(new SelectOption('NONE','-None-',true));
        TmplCEM.add(new SelectOption('01','01'));
        TmplCEM.add(new SelectOption('02','02'));
        TmplCEM.add(new SelectOption('03','03'));
        TmplCEM.add(new SelectOption('04','04'));
        TmplCEM.add(new SelectOption('05','05'));
        TmplCEM.add(new SelectOption('06','06'));
        TmplCEM.add(new SelectOption('07','07'));
        TmplCEM.add(new SelectOption('08','08'));
        TmplCEM.add(new SelectOption('09','09'));
        TmplCEM.add(new SelectOption('10','10'));
        TmplCEM.add(new SelectOption('11','11'));
        TmplCEM.add(new SelectOption('12','12'));
        
        return TmplCEM;
    }
public List<SelectOption> getTmplCEYOptions() {
        List<SelectOption> TmplCEYOptions = new List<SelectOption>();
        TmplCEYOptions.add(new SelectOption('NONE','-None-',true));
        TmplCEYOptions.add(new SelectOption('18','18'));
        TmplCEYOptions.add(new SelectOption('19','19'));
        TmplCEYOptions.add(new SelectOption('20','20'));
        TmplCEYOptions.add(new SelectOption('21','21'));
        TmplCEYOptions.add(new SelectOption('22','22'));
        TmplCEYOptions.add(new SelectOption('23','23'));
        TmplCEYOptions.add(new SelectOption('24','24'));
        TmplCEYOptions.add(new SelectOption('25','25'));
        TmplCEYOptions.add(new SelectOption('26','26'));
        TmplCEYOptions.add(new SelectOption('27','27'));
        TmplCEYOptions.add(new SelectOption('28','28'));
        return TmplCEYOptions;
    }    
/* return error message if no contact is selected */
public boolean geterrormsg()
{
 return errormsg;
}


/* Method to cancel the entire process */
public Pagereference Cancel()
{
        Pagereference p =new Pagereference('/'+cid);
        return p;
}

public PageReference submitPayment()
{
    // You need to select a Payment Gateway.
        // It is important to set the paymentGatewayId property on all object instances.

        bt_stripe__Payment_Gateway__c[] pgList = [SELECT Id
                                                    FROM bt_stripe__Payment_Gateway__c
                                                    WHERE bt_stripe__Default__c = true];


        // It is a good practice to put your p360 action in a try block. If something goes wrong,
        // the API throws a bt_stripe.P360_API_v1.P360_Exception exception

        try {

            // You can initialize object instances using factory methods.
            
            bt_stripe.P360_API_v1.Customer c = bt_stripe.P360_API_v1.customerFactory();
            c.paymentGatewayId = pgList[0].Id;
            c.name = CCName;
            c.email = userinput;

            // After setting all the required properties you can call the action methods.
            if(testrun==false)
            c.registerCustomer();

            bt_stripe.P360_API_v1.PM pm = bt_stripe.P360_API_v1.paymentMethodFactory();
            pm.paymentGatewayId = pgList[0].Id;

            // Some properties are object instances. For example a bt_stripe.P360_API_v1.Customer object instance.

            pm.customer = c;
            pm.cardHolderName = CCName;
            pm.cardNumber = CCNum;
            pm.cardExpYear = string.valueof(selectedExpYr);
            pm.cardExpMonth = string.valueof(selectedExpMnth);
            pm.cvv = CCCVC;
            if(testrun==false)
            pm.registerPM();

            
            bt_stripe.P360_API_v1.Tra t = bt_stripe.P360_API_v1.transactionFactory();
            t.paymentGatewayId = pgList[0].Id;
            t.pm = pm;
            if (Donor==true)
            Pymnt_Amt=DonationAmt;
            t.amount = Pymnt_Amt;
            if(testrun==false)
            t.capture();

            // It is important to call the commitWork() method after calling the action methods.
            // If you not call this method, the data IS NOT SAVED as SOQL in records.
            // Also, as this is a DML action, you can not do any HTTP callouts after this point.
            if(testrun==false) {
            bt_stripe.P360_API_v1.commitWork();
            //get Transaction Record Id
            transID = t.record.Id;
            stripeTransId=t.record.bt_stripe__Transaction_Id__c;
            }
            else {
             teststr='Success';
            }
            

        } catch(bt_stripe.P360_API_v1.P360_Exception e) {
            // Do something on errors
            system.debug(e.getMessage());
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,e.getMessage()));
        }
    //Generate Receipt function call here
         
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step8');
     //Pagereference p=page.PS_TemplSvcs_Step6;
     p.setRedirect(false);
     return p;
}
public PageReference processPayment()
{
    errormsg=false;
    if(selectedPT == 'Credit Card') {
        if(CCName == '' || CCNum == '' || CCCVC == '' || selectedExpYr == null || selectedExpMnth == null){
    errormsg=true;
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'One or more of the required payment field(s) are blank. Please provide complete information'));
    
   }
 
      Integer curr_year =  Date.Today().Year();
      Integer curr_month = Date.Today().Month();
      String s1=string.valueof(curr_year).right(2);
      Integer Year1= Integer.valueof(s1);
      
      if(CCName != '' &&  CCNum != '' && CCCVC != '' && selectedExpYr <= Year1){
       if(selectedExpMnth < curr_month){
        errormsg=true;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Credit Card expired. Please enter another card number'));
      }
      }
      //Pattern p1 = Pattern.compile('(?:\\d[ -]?){19,19}');
      Pattern p1 = Pattern.compile('^[0-9]{15}(?:[0-9]{1})?$');
      Matcher pm1 = p1.matcher(CCNum);
      if(!pm1.matches() && CCNum != ''){
        errormsg=true;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Credit card number should be 19 digits only Dash and space in-between allowed. Please re-enter'));
      }
      Pattern p2 = Pattern.compile('^[0-9]{3,4}$');
      Matcher pm2 = p2.matcher(CCCVC);
      if(!pm2.matches() && CCCVC != ''){
        errormsg=true;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'CVC Code should be 3 or 4 digits only'));
      }
      if(errormsg==false){
      lfourdigit='**** **** ****'+CCNum.right(4);
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step6');
     p.setRedirect(false);
     return p;
     }
    } //End of if(selectedPT == 'Credit Card')
   if(selectedPT == 'Check') {
       List<DCMSS_POS_Set__c> mcs = DCMSS_POS_Set__c.getall().values();
       system.debug('POS CUSTOM SETTINGS is ::'+mcs[0].POS_Verification_Code__c);
          boolean textField = false;
          if (mcs[0].POS_Verification_Code__c == VolunteerCode) {
            textField = true;
          }
        //system.assertEquals(textField, true);
          if(textField == false){
              errormsg=true;
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Volunteer Code is empty or incorrect. Please contact a Front Desk Volunteer to enter the corect code. If Volunteer is not present then we accept only Credit Card payment for now.'));
            }
    if((BankName == '' || CHKNum == '' || CHKDate == '') && textField == true){
    errormsg=true;
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'One or more of the required check fields are blank. Please provide complete information'));
    
   }
  Pattern p1 = Pattern.compile('(0?[1-9]|1[012])/(0?[1-9]|[12][0-9]|3[01])/((19|20)\\d\\d)');
      Matcher pm1 = p1.matcher(CHKDate);
      if(!pm1.matches() && CHKDate != '' && textField == true){
        errormsg=true;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please provide the date with the format MM/DD/YYYY'));
      }
      
      if(CHKDate != '' && textField == true) {
      dt_CHKDt=setStringToDateFormat(CHKDate);
      Integer daysahead=Date.today().daysBetween(dt_CHKDt);
      Integer daysbehind=dt_CHKDt.daysBetween(Date.today());
      
      if(BankName != '' &&  CHKNum != '' && (daysahead > 182) || daysbehind > 182){
        errormsg=true;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Check date is back dated or front dated more than 6 months. Please correct the date'));
      }
      }
      
      
      
      if(errormsg==false && textField == true){
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step8');
     p.setRedirect(false);
     return p;
     }
   }//end of if(selectedPT == 'Check')
     
    return null;
}  //end of processPayment()


public PageReference genReceipt()
{
    Id RecId = [Select Id, Name from RecordType where name = 'Membership' limit 1].Id;
    Opty_Type='Services';
    if (Donor==true){
        Pymnt_Amt=DonationAmt;
        GrandTotal=DonationAmt;
        selectedServices='Donation';
        selectedQty='1';
        Opty_Type='Donation';
    }
   // if(VolunteerCode != null || VolunteerCode !='' ){
        if (SelectedPT =='Cash') {
        List<DCMSS_POS_Set__c> mcs = DCMSS_POS_Set__c.getall().values();
        boolean textField = false;
            if (mcs[0].POS_Verification_Code__c == VolunteerCode) {
              textField = true;
            }
            //system.assertEquals(textField, true);
            if(textField == false){
                errormsg=true;
               ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Volunteer Code is empty or incorrect. Please contact a Front Desk Volunteer to enter the corect code. If Volunteer is not present then we accept only Credit Card payment for now.'));
               Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step8');
               p.setRedirect(false);
               return p; 
              }
        }//if(VolunteerCode != null || VolunteerCode !='' ){
    if(UserType=='Devotee'){
        
        if(DevoteeId==null){
            //Insert a new Devotee record
            DCMSS_Devotee__c newDevot = new DCMSS_Devotee__c(
            First_Name__c = userfirstname,
            Last_Name__c = userinp,
            Email__c = userinput,
            Address__c = street+' '+city+' '+state+' '+zip,
            Phone__c = phone);
            insert newDevot;
            DevotId=newDevot.Id;
            //Insert a new Opportunity Record
            Opportunity newOpp = new Opportunity(
            DCMSS_Devotee_Id__c = DevotId,
            Name = userfirstname+' '+userinp + '-Temple Services'+System.now(),
            CloseDate = System.today(),
            StageName = 'Posted',
            RecordTypeId = RecId,
            Type__c =Opty_Type,
            Amount = Pymnt_Amt);
            //Description ='Services purchased : ' + selectedServices +'  Quantity purchased : '+ Integer.ValueOf(selectedQty)
            insert newOpp;
            OptyId=newOpp.Id;
            opportunity OptyRec =[Select Receipt__c from Opportunity where Id =:OptyId limit 1];
            Receipt_Num=OptyRec.Receipt__c;
            //Insert Opty Line items for services and events only not for donations
            if(Donor != true) {
            opportunitylineitem[] oli = new opportunitylineitem[0];
            Integer i=0;
            for(PriceBookEntry PBE : OptyItem ){
                oli.add(new opportunitylineitem(
                opportunityid=OptyId,
                unitprice=OptyItem[i].UnitPrice,
                quantity=OptyItem[i].Qty__c,
                pricebookentryid=OptyItem[i].Id,
                Description=OptyItem[i].Description__c)); 
                i++;
              }
              insert oli;
            }//end of if(Donor <> True)
        }
        else {
            //Update Devotee First Name if Blank
            DCMSS_Devotee__c devoteeToUpdate;
            Boolean DevoteeChng= false;
            devoteeToUpdate = [select Id,First_Name__c,Last_Name__c,Email__c,Phone__c,Address__c from DCMSS_Devotee__c where Id =:DevoteeId limit 1];
            if(devoteeToUpdate.First_Name__c == null){
                devoteeToUpdate.First_Name__c=userfirstname;
                DevoteeChng= true;
                
            }
           // String mystring='NA NA NA ';
            if(street != 'NA' || city !='NA' || state != 'NA' || zip != '77777'){
                devoteeToUpdate.Address__c=street+' '+city+' '+state+' '+zip;
               DevoteeChng= true; 
            }
            //String mystring2='999-999-9999';
            if(phone != '999-999-9999'){ 
                devoteeToUpdate.Phone__c=phone;
               DevoteeChng= true;  
            }
            if (DevoteeChng== true)
                update devoteeToUpdate;
            
            //Insert a new Opportunity Record
            Opportunity newOpp = new Opportunity(
            DCMSS_Devotee_Id__c = DevoteeId,
            Name = userfirstname+' '+ + DevoteeLastName+'-Temple Services'+System.now(),
            CloseDate = system.today(),
            StageName = 'Posted',
            RecordTypeId = RecId,
            Type__c =Opty_Type,
            Amount = Pymnt_Amt);
            //Description ='Services purchased : ' + selectedServices +'  Quantity purchased : '+ Integer.ValueOf(selectedQty)
            insert newOpp;
            OptyId=newOpp.Id;
            opportunity OptyRec =[Select Receipt__c from Opportunity where Id =:OptyId limit 1];
            Receipt_Num=OptyRec.Receipt__c;
            if(Donor != true){
             //Insert Opty Line items
            
            opportunitylineitem[] oli = new opportunitylineitem[0];
            Integer i=0;
            for(PriceBookEntry PBE : OptyItem ){
                oli.add(new opportunitylineitem(
                opportunityid=OptyId,
                unitprice=OptyItem[i].UnitPrice,
                quantity=OptyItem[i].Qty__c,
                pricebookentryid=OptyItem[i].Id,
                Description=OptyItem[i].Description__c)); 
                i++;
              }
              insert oli;
              }//end of if(Donor != true)
        }
    }           
    else {
    //Member record operations 
    //Insert a new Opportunity Record
    Opportunity newOpp = new Opportunity(
    npsp__Primary_Contact__c = ContactId,
    AccountId=ConAcctId,
    Name = FirstName+' '+LastName+' ' + '-Temple Services'+System.now(),
    CloseDate = system.today(),
    StageName = 'Posted',
    RecordTypeId = RecId,
    Type__c =Opty_Type,
    Amount = Pymnt_Amt);
    //Description ='Services purchased : ' + selectedServices +'  Quantity purchased : '+ Integer.ValueOf(selectedQty)
    insert newOpp;
    OptyId=newOpp.Id;
    opportunity OptyRec =[Select Receipt__c from Opportunity where Id =:OptyId limit 1];
    Receipt_Num=OptyRec.Receipt__c;
    if(Donor !=true){
    //Insert Opty Line items
            opportunitylineitem[] oli = new opportunitylineitem[0];
            Integer i=0;
            for(PriceBookEntry PBE : OptyItem ){
                oli.add(new opportunitylineitem(
                opportunityid=OptyId,
                unitprice=OptyItem[i].UnitPrice,
                quantity=OptyItem[i].Qty__c,
                pricebookentryid=OptyItem[i].Id,
                Description=OptyItem[i].Description__c)); 
                i++;
              }
              insert oli;
        }// end of if(Donor !=true)
    Contact conRec=[Select Id,Email,MailingStreet,MailingCity,MailingState,MailingPostalCode,Phone from Contact where Id =:ContactId limit 1];
    if(ContactEmail ==null) {
        
        conRec.Email=userinput;
         update conRec;
    }
    }   
    if(selectedPT=='Cash'){

           npe01__OppPayment__c pymntRec = [Select Id,npe01__Payment_Method__c,npe01__Check_Reference_Number__c,npe01__Custom_Payment_Field__c,DCMSS_Check_Date__c from npe01__OppPayment__c where npe01__Opportunity__c =: OptyId limit 1];
            PymntId=pymntRec.Id;
            pymntRec.npe01__Payment_Method__c='Cash';
            update pymntRec;    
           
         }  //if(selectedPT=='Cash')
    else if(selectedPT=='Check'){
    
            npe01__OppPayment__c pymntRec = [Select Id,npe01__Payment_Method__c,npe01__Check_Reference_Number__c,npe01__Custom_Payment_Field__c,DCMSS_Check_Date__c from npe01__OppPayment__c where npe01__Opportunity__c =: OptyId limit 1];
            PymntId=pymntRec.Id;
            pymntRec.npe01__Payment_Method__c='Check';
            pymntRec.npe01__Check_Reference_Number__c=CHKNum;
            pymntRec.npe01__Custom_Payment_Field__c=BankName;
            pymntRec.DCMSS_Check_Date__c=dt_CHKDt;
            update pymntRec;
        }//if(selectedPT=='Check')
    else {
        //selectedPT=='Credit Card'
    
            npe01__OppPayment__c pymntRec = [Select Id,npe01__Payment_Method__c from npe01__OppPayment__c where npe01__Opportunity__c =: OptyId limit 1];
            PymntId=pymntRec.Id;
            pymntRec.npe01__Payment_Method__c='Credit Card';
            update pymntRec;    
            if(testrun==false){
            //Fetch the Transaction record to associate with payment record.
            bt_stripe__Transaction__c transRec =[Select Id,DCMSS_Payment__c from bt_stripe__Transaction__c where  Id =: transID limit 1];
            transRec.DCMSS_Payment__c=PymntId;
            update transRec;
            }
            
    }   
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step9');
     p.setRedirect(false);
     return p;  
    }
        

/* Method to fetch the selected records from Step 2 */
public PageReference capturePayment()
{
    errormsg=false;
     if(Donor==false && (GrandTotal== 0.0)) {

        errormsg=true; 

        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Shopping Cart is empty. Please select some item or add Donation.'));

        return null;

   }
    // Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step4');
     Pagereference p=page.PS_TemplSvcs_Step4;
     

     if(selectedPT=='Cash'){
    p=page.PS_TemplSvcs_Step8;
    // p=page.PS_TemplSvcs_Step4;
        
     }
     p.setRedirect(false);
     return p;
}  
public PageReference gotoMemberReg()
{
    UserType='Member';
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step2');
    //Pagereference p=page.PS_TemplSvcs_Step3;
    p.setRedirect(false);
     return p;
}

public PageReference gotoTemplSvcs()
{
    //UserType='Member';
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step1');
    //Pagereference p=page.PS_TemplSvcs_Step3;
    p.setRedirect(false);
     return p;
}

public PageReference gotoRecvDonation()
{
    Donor=true;
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step1');
    //Pagereference p=page.PS_TemplSvcs_Step3;
    p.setRedirect(false);
     return p;
}
public PageReference gotoAddDonation()
{
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step16');
    p.setRedirect(false);
     return p;
}

public PageReference AddDonationToCart()
{
    if(DonationAmt !=null && DonationAmt > 0.0) {
    List<Product2> prodList =[SELECT Id FROM Product2 WHERE Name = 'Donation' Limit 1];
    List<PriceBook2> pbList=[SELECT Id from PriceBook2 WHERE Name=:'Temple Services 2016' Limit 1];
    PricebookEntryList = database.Query('select Id,ProductCode,UnitPrice,TotPrice__c,Qty__c,Description__c from PriceBookEntry where Pricebook2Id =: pbList AND Product2Id =: prodList LIMIT 1');
    Ids.add(PricebookEntryList[0].Id); 
    CartList.put(PricebookEntryList[0].Id,1);
    OptyItem = database.Query('select Id,ProductCode,UnitPrice,TotPrice__c,Qty__c,Description__c,Product_Desc__c from PriceBookEntry where Id in :Ids');
      Integer i=0;
      GrandTotal=0.0;
      for(PriceBookEntry PBE : OptyItem ){
        OptyItem[i].Qty__c=CartList.get(PBE.Id);
        if(OptyItem[i].ProductCode=='Donation') {
        OptyItem[i].UnitPrice=DonationAmt;
        OptyItem[i].TotPrice__c=DonationAmt*OptyItem[i].Qty__c;
        OptyItem[i].Product_Desc__c=DonationDesc;
        
        }
        else {
        OptyItem[i].TotPrice__c=OptyItem[i].UnitPrice*OptyItem[i].Qty__c;
        OptyItem[i].Product_Desc__c=OptyItem[i].Description__c;
        }
        GrandTotal=GrandTotal+OptyItem[i].TotPrice__c;
        
        Pymnt_Amt=GrandTotal;
        i++;
      }
      PricebookEntryList.clear();
    }//End of Donation Amt !=null
    //DonationAmt=null;
    //DonationDesc='';
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
    p.setRedirect(false);
     return p; 
    
}
public PageReference DelDonationFromCart()
{
    List<Product2> prodList =[SELECT Id FROM Product2 WHERE Name = 'Donation' Limit 1];
    List<PriceBook2> pbList=[SELECT Id from PriceBook2 WHERE Name=:'Temple Services 2016' Limit 1];
    PricebookEntryList = database.Query('select Id,ProductCode,UnitPrice,TotPrice__c,Qty__c,Description__c from PriceBookEntry where Pricebook2Id =: pbList AND Product2Id =: prodList LIMIT 1');
    Integer i=0;
      if ( PricebookEntryList !=null && PricebookEntryList.size() > 0 && CartList.size() > 0) {
      for(PriceBookEntry PBE : OptyItem ){

      if(OptyItem[i].ProductCode=='Donation') {
        GrandTotal=GrandTotal-OptyItem[i].TotPrice__c;
        Pymnt_Amt=GrandTotal;
        OptyItem[i].Qty__c=10;
      }
      i++;
        
      
      }

      Integer j = 0;
      while (j < OptyItem.size())
      {
        if(OptyItem[j].Qty__c == 10)
        {
          OptyItem.remove(j);
          Ids.remove(PricebookEntryList[0].Id);
          CartList.remove(PricebookEntryList[0].Id);
        }else
        {
            
          j++;
        }
      }
      PricebookEntryList.clear();
      DonationAmt=null;
      DonationDesc='';
      }
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
    p.setRedirect(false);
     return p;
}
public PageReference gotoWalkIn()
{
    UserType='Devotee';
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step2');
    //Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
    //Pagereference p=page.PS_TemplSvcs_Step10;
    p.setRedirect(false);
     return p;
}
public PageReference gotoEventSvcs()
{
    Event=true;
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step1');
    //Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
    //Pagereference p=page.PS_TemplSvcs_Step10;
    p.setRedirect(false);
     return p;
}
public PageReference gotoEventSvcs2()
{
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
    List<DCMSS_POS_Set__c> mcs = DCMSS_POS_Set__c.getall().values();
         if (mcs[0].Current_Event__c == 'Rama Navami')
            p=page.PS_TemplSvcs_Step12; 
        else if (mcs[0].Current_Event__c == 'Ganesha Chaturthi')
            p=page.PS_TemplSvcs_Step13; 
        else if (mcs[0].Current_Event__c == 'Vijaya Dasami')
            p=page.PS_TemplSvcs_Step14; 
        else if (mcs[0].Current_Event__c == 'Pratishtha Din')
            p=page.PS_TemplSvcs_Step15;
        else
          p=page.PS_TemplSvcs_Step10;
        
    p.setRedirect(false);
     return p;
}
public PageReference gotoGuestBook()
{
    //UserType='Devotee';
    Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step11');
    //Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
    //Pagereference p=page.PS_TemplSvcs_Step10;
    p.setRedirect(false);
     return p;
}

private Date setStringToDateFormat(String myDate) {
   String[] myDateOnly = myDate.split('/');
  // String[] strDate = myDateOnly[0].split('/');
   Integer myIntDate = integer.valueOf(myDateOnly[1]);
   Integer myIntMonth = integer.valueOf(myDateOnly[0]);
   Integer myIntYear = integer.valueOf(myDateOnly[2]);
   Date d = Date.newInstance(myIntYear, myIntMonth, myIntDate);
   return d;
}

public PageReference processStep2()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step2');
     p.setRedirect(false);
     return p;

}   
public PageReference processStep3()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
 
    /* [8/12/2017 Rajesh] replacing this with the navigation based on Event set up in POS setting
     if(Event==true)
         p=page.PS_TemplSvcs_Step10; 
    */
 
       if(Event==true){
          List<DCMSS_POS_Set__c> mcs = DCMSS_POS_Set__c.getall().values();
          if (mcs[0].Current_Event__c == 'Rama Navami')
            p=page.PS_TemplSvcs_Step12; 
          else if (mcs[0].Current_Event__c == 'Ganesha Chaturthi')
            p=page.PS_TemplSvcs_Step13; 
          else if (mcs[0].Current_Event__c == 'Vijaya Dasami')
            p=page.PS_TemplSvcs_Step14;
          else if (mcs[0].Current_Event__c == 'Pratishtha Din')
            p=page.PS_TemplSvcs_Step15;
          else
          p=page.PS_TemplSvcs_Step10;
      }
         
     p.setRedirect(false);
     return p;

} 
public PageReference gotoOffsiteSvcs()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3_OS');
     p.setRedirect(false);
     return p;

}
public PageReference gobacktoPage3()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
     p.setRedirect(false);
     return p;

}

public PageReference processStep4()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step4');
     p.setRedirect(false);
     return p;

}
public PageReference gotoStep1()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step1');
     p.setRedirect(true);
     return p;

}   
public PageReference gotoStep0()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step0');
     p.setRedirect(true);
     return p;

}  
}