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
public boolean errormsg=false;                                                // Error msg. When no contact has been selected.
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
public String selectedQty;
public String getselectedQty(){return selectedQty;}
public void setselectedQty(String selectedQty){this.selectedQty = selectedQty;}

//public String getuserinput2(){return userinput2;}
//public void setuserinput2(String userinput2){this.userinput2=userinput2;}


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
    PricebookEntryList = database.Query('select ProductCode,UnitPrice from PriceBookEntry where Pricebook2Id =: PBE_ID AND Product2Id =: prodList LIMIT 1');
    
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
     p.setRedirect(true);
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
 
/* Method to fetch the selected records from Step 2 */
public PageReference processPayment()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step5');
     p.setRedirect(false);
     return p;

}  

public PageReference processStep2()
{
     //String id=System.currentpagereference().getparameters().get('id');
     Pagereference p=new Pagereference ('/apex/PS_TemplSvcs_Step2');
     p.setRedirect(true);
     return p;

}   

}