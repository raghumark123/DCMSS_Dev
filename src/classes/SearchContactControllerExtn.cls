public class SearchContactControllerExtn {

 //Constructor Function. The campaign id is captured in this function */
public SearchContactControllerExtn(ApexPages.StandardController controller)
{
 //cid=System.currentPageReference().getParameters().get('id');
}
/* Variable declarations */

Public String cid;                                                            // Stores Contact Id
public List<cContact> contactList {get; set;}                                 // Wrapper class which stores contact data and a boolean flag.
public List<PricebookEntry> PricebookEntryList{get; set;}                    //Wrapper class which stores a product selected from UI and returns its pricing
Public List<Product2> prodList{get;set;}
public Boolean selectAllCheckbox {get; set;}                                  // Stores checkbox data.
public boolean errormsg=false;  												// Error msg. When no contact has been selected.                                            
String ConId;
String userinput;                                                             //Contact Email
String userinp;                                                               //Contact Last Name
String MobilePhone; 
String Phone;                                                            
String FirstName;                                                                                                                              
String MailingAddr;                                                             
String Membership_ID;                                                             
String Devotee_ID;                                                               
String Pymnt_Type;                                                             
Decimal Pymnt_Amt;                                                             
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
String Receipt_Num;                                                             



Public boolean displayboxes;

Public List<Contact> results = new List<Contact>();                                     // Contact search results.
Public List<Contact> selectedContactsstep2 = new List<Contact>();                         // Selcted Contacts

/* End of Variable declarations */

/* Getter and setter methods for getting the user input ie. Contact name and email from the UI */

public String getuserinput(){return userinput;}
public void setuserinput(String userinput){this.userinput=userinput;}
public String getuserinp(){return userinp;}
public void setuserinp(String userinp){this.userinp=userinp;}
public String selectedServices;
public String getselectedServices(){return selectedServices;}
public void setselectedServices(String selectedServices){this.selectedServices=selectedServices;}
public Integer selectedQty;
public Integer getselectedQty(){return selectedQty;}
public void setselectedQty(Integer selectedQty){this.selectedQty = selectedQty;}
public String selectedPT;
public String getselectedPT(){return selectedPT;}
public void setselectedPT(String selectedPT){this.selectedPT=selectedPT;}
public String CCName;
public String getCCName(){return CCName;}
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
/*End of Getter and Setter methods */


  
/* Method to Search the contact database to fetch the query results */
public List<Contact> contactsearch()
{
     errormsg=false;
     if(userinput == '' || userinp == '' || (userinput !='' && !Pattern.matches('[a-zA-Z0-9._-]+@[a-zA-Z]+.[a-zA-Z]{2,4}', userinput)) ) {

        errormsg=true; 

        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'Check your email format. Both email and last name are required.'));

        return null;

   }
     contactList = new List<cContact>();
     //for(Contact c : [select Account.Name,Name,FirstName,LastName,Email,title,Id,MobilePhone from Contact where Email like :+'%'+userinput+'%'])
     for(Contact c : [select Id,Name,FirstName,LastName,Email,MobilePhone,Phone,MailingAddress from Contact where LastName =: userinp AND Email =: userinput LIMIT 10])
     {
         contactList.add(new cContact(c));
     }

 return null;
}
/* End of method */

/* Method to Search the contact database to fetch the query results */
public void getPriceMethod()
{
     List<Product2> prodList =[SELECT Id FROM Product2 WHERE Name =: selectedServices Limit 1];
     String PBE_ID='01s4C000000LXBy';
    // Boolean INTMPL=true;
    // prodList = database.Query('select Id from Product2 where name = '+'\''+selectedServices+'\'');
   // PricebookEntryList = database.Query('select UnitPrice from PriceBookEntry where Pricebook2Id =: PBE_ID AND Product2Id =: prodList AND InTemple__c =: INTMPL  LIMIT 1');
    PricebookEntryList = database.Query('select ProductCode,UnitPrice,TotPrice__c from PriceBookEntry where Pricebook2Id =: PBE_ID AND Product2Id =: prodList LIMIT 1');
    PricebookEntryList[0].TotPrice__c=PricebookEntryList[0].UnitPrice*Integer.ValueOf(selectedQty);
}
/* End of method */


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


/* Method to fetch the selected records from Step 2 */
public PageReference processSelected()
{

  List<Contact> selectedContacts = new List<Contact>();
  if (contactList!= null)
  {
     for(cContact cCon : getresults()){
        if(cCon.selected == true){
             selectedContacts.add(cCon.con);
             FirstName=selectedContacts[0].FirstName;
         }
     }
        
     selectedContactsstep2=selectedContacts;
  }
 /* return error message if no contact is selected */
 if (selectedcontacts.size()==0)
 {
     errormsg=true;
     return null;
 }
 else
 {
     errormsg=false;
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step3');
     p.setRedirect(false);
     return p;
 }

}
public List<SelectOption> getItems()
{
 List<SelectOption> options = new List<SelectOption>();
 options.add(new SelectOption('YES','YES'));
 options.add(new SelectOption('NO','NO'));
 return options;
}

public List<SelectOption> getTmplServOptions() {
        List<SelectOption> TmplServOptions = new List<SelectOption>();
      //  TmplServOptions.add(new SelectOption('','-None-'));
        TmplServOptions.add(new SelectOption('ABHISHEKAM','Abhishekam'));
        TmplServOptions.add(new SelectOption('PUSHPANJALI','Pushpanjali'));
        TmplServOptions.add(new SelectOption('ASHTOTHARAM ARCHANA','Ashtotharam Archana'));
        TmplServOptions.add(new SelectOption('VEHICLE POOJA','Vehicle Pooja'));
        TmplServOptions.add(new SelectOption('SATYANARAYANA POOJA','Satyanarayana Pooja'));
        TmplServOptions.add(new SelectOption('TEMPLE SATYANARAYANA POOJA','Temple Satyanarayana Pooja'));
        TmplServOptions.add(new SelectOption('NAAMAKARANAM','Naamakaranam'));
        TmplServOptions.add(new SelectOption('NIRA PARA','Nira Para'));
        TmplServOptions.add(new SelectOption('NISHCHITARTHAM','Nishchitartham'));
        TmplServOptions.add(new SelectOption('PANNA PARA','Panna Para'));
        TmplServOptions.add(new SelectOption('TEMPLE ABHISHEKAM','Temple Abhishekam'));
        TmplServOptions.add(new SelectOption('TEMPLE VIDYAARAMBAM','Temple Vidyaarambam'));
        TmplServOptions.add(new SelectOption('VIDYAARAMBAM','Vidyaarambam'));
        TmplServOptions.add(new SelectOption('ANNAPRAASANAM','Annapraasanam'));
         
        return TmplServOptions;
    }
public List<SelectOption> getServQty() {
        List<SelectOption> ServQty = new List<SelectOption>();
      //  TmplServOptions.add(new SelectOption('','-None-'));
        ServQty.add(new SelectOption('1','1'));
        ServQty.add(new SelectOption('2','2'));
        ServQty.add(new SelectOption('3','3'));
        ServQty.add(new SelectOption('4','4'));
        ServQty.add(new SelectOption('5','5'));
        ServQty.add(new SelectOption('6','6'));
        ServQty.add(new SelectOption('7','7'));
        
        return ServQty;
    }
    
public List<SelectOption> getTmplPTOptions()
{
 List<SelectOption> TmplPTOptions = new List<SelectOption>();
  TmplPTOptions.add(new SelectOption('NONE','-None-',true));
  TmplPTOptions.add(new SelectOption('CREDIT CARD','CREDIT CARD'));
  TmplPTOptions.add(new SelectOption('CASH','CASH'));
  TmplPTOptions.add(new SelectOption('CHEQUE','CHEQUE'));
 return TmplPTOptions;
}

public List<SelectOption> getTmplCEM() {
        List<SelectOption> TmplCEM = new List<SelectOption>();
        TmplCEM.add(new SelectOption('NONE','-None-',true));
        TmplCEM.add(new SelectOption('1','1'));
        TmplCEM.add(new SelectOption('2','2'));
        TmplCEM.add(new SelectOption('3','3'));
        TmplCEM.add(new SelectOption('4','4'));
        TmplCEM.add(new SelectOption('5','5'));
        TmplCEM.add(new SelectOption('6','6'));
        TmplCEM.add(new SelectOption('7','7'));
        TmplCEM.add(new SelectOption('8','8'));
        TmplCEM.add(new SelectOption('9','9'));
        TmplCEM.add(new SelectOption('10','10'));
        TmplCEM.add(new SelectOption('11','11'));
        TmplCEM.add(new SelectOption('12','12'));
        
        return TmplCEM;
    }
public List<SelectOption> getTmplCEYOptions() {
        List<SelectOption> TmplCEYOptions = new List<SelectOption>();
        TmplCEYOptions.add(new SelectOption('NONE','-None-',true));
        TmplCEYOptions.add(new SelectOption('16','16'));
        TmplCEYOptions.add(new SelectOption('17','17'));
        TmplCEYOptions.add(new SelectOption('18','18'));
        TmplCEYOptions.add(new SelectOption('19','19'));
        TmplCEYOptions.add(new SelectOption('20','20'));
        TmplCEYOptions.add(new SelectOption('21','21'));
        TmplCEYOptions.add(new SelectOption('22','22'));
        
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

/*Lunh's algorithm for credit card validation
public boolean CCValidation(String CCNumber){
Integer sum = 0;
Integer len = CCNumber.length();
for(Integer i=len-1;i>=0;i--){
Integer num = Integer.ValueOf(CCNumber.substring(i,i+1));
if ( math.mod(i , 2) == math.mod(len, 2) )
{
Integer n = num * 2;
sum += (n / 10) + ( math.mod(n, 10));
}
else{
sum += num;
}
}
return ( math.mod( sum, 10) == 0 );
}*/
public PageReference submitPayment()
{
	Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step7');
     //Pagereference p=page.PS_TemplSvcs_Step6;
     p.setRedirect(false);
     return p;
}
public PageReference validatePayment()
{
	errormsg=false;
   if(CCName == '' || CCNum == '' || CCCVC == '' || selectedExpYr == null || selectedExpMnth == null){
   	errormsg=true;
     ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'One or more of the required payment field(s) are blank. Please provide complete information'));
    
   }
     // if(CCValidation(string.valueof(CCNum)) == false)
     //  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Credit card number is not in proper format. Please re-enter'));
 
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
      Pattern p1 = Pattern.compile('(?:\\d[ -]?){16,16}');
      //Matcher pm1 = p1.matcher(string.valueof(CCNum));
      Matcher pm1 = p1.matcher(CCNum);
      if(!pm1.matches() && CCNum != ''){
      	errormsg=true;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Credit card number should be 16 digits only Dash and space in-between allowed. Please re-enter'));
      }
      Pattern p2 = Pattern.compile('(?:\\d[ -]?){3,3}');
      //Matcher pm2 = p2.matcher(string.valueof(CCCVC));
      Matcher pm2 = p2.matcher(CCCVC);
      if(!pm2.matches() && CCCVC != ''){
      	errormsg=true;
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'CVC Code should be 3 digits only'));
      }
      if(errormsg==false){
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step6');
     //Pagereference p=page.PS_TemplSvcs_Step6;
     p.setRedirect(false);
     return p;
     }
     else
    return null;
}  
 
/* Method to fetch the selected records from Step 2 */
public PageReference capturePayment()
{
    // Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step4');
     Pagereference p=page.PS_TemplSvcs_Step4;
     
     if(selectedPT=='CREDIT CARD') {
    
     }
    if(selectedPT=='CHEQUE'){
     p=page.PS_TemplSvcs_Step5;
    
     
    	
     }
     if(selectedPT=='CASH'){
     p=page.PS_TemplSvcs_Step6;
     
    	
     }
     p.setRedirect(false);
     return p;
}  

public PageReference processStep2()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step2');
     p.setRedirect(false);
     return p;

}   

}