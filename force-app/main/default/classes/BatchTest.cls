global class BatchTest implements Database.Batchable<sObject>, Database.Stateful {
    
     public static String name ='Arun';
    
    global Database.QueryLocator Start(Database.BatchableContext bc) {
        
        name ='kumaran';
        
        String strQuery = 'Select Id, Name from Account limit 100';
        
        return Database.getQueryLocator(strQuery);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> lstRecords) {
      /*  System.debug('enterted to finish method');
        System.debug('Size of the batch:::'+lstRecords.size());
        System.debug('Acccunt Id:'+lstRecords[0].Id);
      
        System.debug('name:::'+name);
        List<Account> lstAcc;
       //List<Contact> LstContact = [SELECT Id, Name, AccountId FROM Contact];
        for(Account objAcc : lstRecords) {
            Account objCon = new Account();
            objCon.Id = objAcc.Id;
            objCon.Description = 'The changes has been updated only on tda';
            lstAcc.add(objCon);
         
          //System.debug('final list:::'+srList);
 
            update objCon;
        }
        
    }
    
    global void finish(Database.BatchableContext bc) {
       /* System.debug('entered to Finish method');
        List<AsyncAPexJob> lstJobs = [SELECT Id, NumberofErrors, ApexClass.Id from AsyncAPexJob Where bc.JobId = ]*/
       // List<Id> lstIds = new List<Id>{'006Ie000002ls82IAA', '006Ie000002ls82IAA'};
      //  FutureTestClass.getDetails(lstIds);
    }
    
    
    
  
}