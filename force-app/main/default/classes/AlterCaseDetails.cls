public class AlterCaseDetails {

    @InvocableMethod(label = 'Modifiy Case Details'
                      description='Update the case details whenever the user wants to modify the case details')
    public static List<caseResponse> updateCaseInformation(List<CaseRequest> caseInputReq) {

        List<caseResponse> results = new List<caseResponse>();
        caseResponse objRes = new caseResponse();
        objRes.displayResponse = new finalCaseResponse();  
        objRes.displayResponse.newCases = new List<Cases>();  
        List<Case> lstCases = new List<Case>();

       if(caseInputReq != null) {
         lstCases = [SELECT Id, Status, CaseNumber, ClosedDate, Description, Subject, Contact.Name, Account.Name, Priority, 
                               Type, Reason, Origin FROM Case WHERE CaseNumber =: caseInputReq[0].inputs.caseNumber];
       }

       System.debug('lst of cases:::'+lstCases);
       
       if(lstCases.size() > 0) {
        
        CaseInputs objCaseInput = new CaseInputs();
        objCaseInput.casePriority = caseInputReq[0].inputs.casePriority;
        objCaseInput.caseSubject = caseInputReq[0].inputs.caseSubject;
        objCaseInput.caseStatus = caseInputReq[0].inputs.caseStatus;
        

        for(Case objCase: lstCases) {
            Cases newCase1 = new Cases(objCase.Id, objCase.CaseNumber,objCase.Priority, objCase.Subject, objCase.Description,
                                      objCase.Status,objCase.Origin);
             
            objRes.displayResponse.newCases.add(newCase1);
            results.add(objRes);
       }
       System.debug('lst of results:::'+results);
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

