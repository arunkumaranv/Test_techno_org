public class CreateCaseForm {
    
    @InvocableMethod(label='Case Input From' description='Get the case input details from the user')
    public static List<caseResponse> createCaseForms(List<CaseRequest> caseInputReq) {
        
        List<caseResponse> results = new List<caseResponse>();
        caseResponse objRes = new caseResponse();
        objRes.displayResponse = new finalCaseResponse();  
        objRes.displayResponse.newCases = new List<Cases>();  
        List<Case> lstCases = new List<Case>();
        Case newCase = new Case();
        System.debug('case input request:::'+caseInputReq);
        System.debug('inputs case:::'+caseInputReq[0].inputs);
        System.debug('inputs case:::'+caseInputReq[0].inputs.caseSubject);
        
        
        if(caseInputReq[0].inputs.caseNumber != null) {
            lstCases = [SELECT Id, Status, CaseNumber, ClosedDate, Description, Subject, Contact.Name, Account.Name, Priority, 
                        Type, Reason, Origin FROM Case WHERE CaseNumber =: caseInputReq[0].inputs.caseNumber];
        }
        
        if( lstCases == null) {
            System.debug('entered to the insert operation');
            // newCase.ContactId = objContact.Id;
            newCase.Priority = caseInputReq[0].inputs.casePriority;
            newCase.Subject = caseInputReq[0].inputs.caseSubject;
            newCase.Description = caseInputReq[0].inputs.description;
            newCase.Status = caseInputReq[0].inputs.caseStatus;
            newCase.Origin = caseInputReq[0].inputs.caseOrigin;
            lstCases.add(newCase);
        } else if((caseInputReq[0].inputs.caseStatus != null || caseInputReq[0].inputs.caseOrigin != null 
                   || caseInputReq[0].inputs.casePriority != null || caseInputReq[0].inputs.caseSubject != null))  {
                       
                       System.debug('entered to the upsert operation');
                       newCase.Status = caseInputReq[0].inputs.caseStatus;
                       newCase.Origin = caseInputReq[0].inputs.caseOrigin;
                       newCase.Priority = caseInputReq[0].inputs.casePriority;
                       newCase.Subject = caseInputReq[0].inputs.caseSubject;
                       newCase.Description = caseInputReq[0].inputs.description;
                       lstCases.add(newCase);
                   }
        
        System.debug('lst of cases:::'+lstCases);
        System.debug('lst of cases:::'+lstCases.size());
        
        if(lstCases.size() > 0) {
            upsert lstCases;
            System.debug('lst of cases::::'+lstCases[0].CaseNumber);
            
        }
        if(lstCases != null && lstCases.size() > 0) {
            Cases objCase = new Cases(lstCases[0].Id , lstCases[0].CaseNumber, lstCases[0].Priority, lstCases[0].Subject,
                                      lstCases[0].Description, lstCases[0].Status, lstCases[0].Origin);
            objRes.displayResponse.newCases.add(objCase);
            results.add(objRes);
        }
        return results;
    }
    
    public class CaseRequest {
        @InvocableVariable
        public CaseInputs inputs;
    }  
    
    public class CaseInputs {
        @InvocableVariable
        public String caseNumber;
        @InvocableVariable
        public String contactName;  
        @InvocableVariable
        public String casePriority; 
        @InvocableVariable 
        public String caseSubject;
        @InvocableVariable 
        public String description;
        @InvocableVariable
        public String caseStatus;
        @InvocableVariable
        public String caseOrigin;
    }
    
    public class caseResponse {
        @InvocableVariable
        public finalCaseResponse displayResponse;
    }
    
    public class finalCaseResponse {
        @InvocableVariable
        public List<Cases> newCases;
    }
    
    public class Cases{
        @InvocableVariable
        public String caseId;
        @InvocableVariable
        public String caseNumber;
        @InvocableVariable
        public String casePriority; 
        @InvocableVariable 
        public String caseSubject;
        @InvocableVariable 
        public String description;
        @InvocableVariable
        public String caseStatus;
        @InvocableVariable
        public String caseOrigin;
        
        
        public Cases(String caseId, String caseNumber, String casePriority, String caseSubject, String description, String caseStatus, 
                     String caseOrigin) {
                   this.caseId = caseId;            
                   this.caseNumber = caseNumber;
                   this.casePriority = casePriority;
                   this.caseSubject = caseSubject;
                   this.description = description;
                   this.caseStatus = caseStatus;
                   this.caseOrigin = caseOrigin;
            }
    }
}