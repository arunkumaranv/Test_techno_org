public class AccountHandler {
    
    public static void updateAccIndustry(List<Account> lstAcc, Map<Id, Account> oldMapAcc) {
        
        
        Set<Id> setAccIds = new Set<Id>();
        Map<Id, String> mapAccIndustry = new Map<Id, String>();
        List<Account> lstUpdate = new List<Account>();
        
        
        if(!lstAcc.isEmpty()) {
            
            for( Account objAcc : lstAcc) {
                
                if(!oldMapAcc.isEmpty()) {
                    
                    if(objAcc.industry != oldMapAcc.get(objAcc.Id).Industry && objAcc.parentId != null) {
                        
                        mapAccIndustry.put(objAcc.ParentId, objAcc.industry);
                    }
                    
                }
            }
        }
        System.debug('Accounts:::'+mapAccIndustry);
        
        if(!mapAccIndustry.isEMpty()) {
            
            List<Account> fetchAcc = [SELECT Id, Name, ParentId, Industry from Account WHERE ParentId IN : mapAccIndustry.keySet()];
          // List<Account> fetchAcc = [SELECT Id, Name, Industry  from Account WHERE Id IN : mapAccIndustry.keySet()];
            
            for(Account newAcc : fetchAcc) {
                System.debug('print the new values::'+newAcc);
                
                if(mapAccIndustry.containsKey(newAcc.parentId)) {
                    Account updateAcc = new Account();
                    updateAcc.Id = newAcc.parentId;
                    updateAcc.Industry = mapAccIndustry.get(newAcc.ParentId);
                    //updateAcc.Parent.Industry = mapAccIndustry.get(newAcc.ParentId);                    
                    lstUpdate.add(updateAcc);
                    
                }
                
            }
            SYstem.debug('final update:::'+lstUpdate);
            update lstUpdate;
        }   
    }
    
    Public Static void preventAccCreation(List<Account> lstNewAcc) {
        Set<Id> AccIds = new Set<Id>();
        Map<Id, String> mapAccName = new Map<Id, String>();
        
        
        if(!lstNewAcc.isEmpty()) {
            for(Account objAcc : lstNewAcc)  {
                if(objAcc.Name != null) {
                    System.debug('Account Name:::'+objAcc.Name);
                    mapAccName.put(objAcc.Id, objAcc.Name);
                }
            }
        }
        System.debug('MapAccName:::'+ mapAccName);
        
      //List<Account>
      //
       Map<Id, Account> mapAccount = new Map<Id, Account>([SELECT Id, Name from Account Order by CreatedDate Desc limit 10]);
        System.debug('getAccDetails::'+mapAccount);
    // List<Account> lstAccount = [SELECT Id, Name from Account Order by CreatedDate Desc limit 10];
       // System.debug('getAccDetails::'+lstAccount);
        
        for(Account newAcc : lstNewAcc)
            if(!mapAccount.containsKey(newAcc.Id) && mapAccName.get(newAcc.Id) == newAcc.Name) {
               newAcc.addError('duplicate not allowed');
            }
    }
}