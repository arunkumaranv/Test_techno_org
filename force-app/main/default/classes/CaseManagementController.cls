public without sharing class CaseManagementController {
    @InvocableMethod(label='Case Details'
                     description='Return Case Details, when user ask for it, for example user can say what is the status of the case 100')
    public static List<caseResponse> getDetails(List<CaseRequest> caseReq) {

        List<caseResponse> lstResponse = new List<caseResponse>();
        caseResponse objRes = new caseResponse();
        objRes.aCaseOptions = new AvailableCases();
        objRes.aCaseOptions.caseOptions = new List<Cases>();
         

        List<Case> lstCases = [SELECT Id, Status, CaseNumber, ClosedDate, Description, Subject, Contact.Name, Account.Name, Priority, 
                               Type, Reason  FROM Case WHERE CaseNumber =: caseReq[0].filters.caseNumber];
        for(Case objCase: lstCases) {
            Cases newCase = new Cases(objCase.Id, objCase.Status, objCase.CaseNumber, objCase.Subject, objCase.Description, 
                                      objCase.Priority, objCase.Type, objCase.Account.Name, objCase.Contact.Name,
                                      objCase.Reason, URL.getOrgDomainURL().toExternalForm()+'/'+objCase.Id);
         
            objRes.aCaseOptions.caseOptions.add(newCase);
        }
        lstResponse.add(objRes);

        return lstResponse;
     }
    
     public class CaseRequest {
        @InvocableVariable
        public CaseFilter filters; 
     }
     public class CaseFilter {
        @InvocableVariable
        public string caseNumber;
     }

     public class caseResponse {
        @InvocableVariable
        public AvailableCases aCaseOptions;
     }

     public class AvailableCases {
        public List<Cases> caseOptions;
     }

     public class Cases {
        @InvocableVariable
        public String id;
        @InvocableVariable
        public String caseStatus;
        @InvocableVariable
        public String caseNumber;
        @InvocableVariable
        public String caseSubject;
        @InvocableVariable
        public String caseDesc;
        @InvocableVariable
        public String casePriority;
        @InvocableVariable
        public String caseType;
        @InvocableVariable
        public String accName;
        @InvocableVariable
        public String conName;
        @InvocableVariable
        public String caseReason;
        @InvocableVariable
        public String caseLink;


        public Cases(String id, String caseStatus, String  caseNumber, String caseSubject, String caseDesc, String casePriority, String caseType, String accName, 
                    String conName, String caseReason, String caseLink) {
            this.id = id;
            this.caseStatus = caseStatus;
            this.caseNumber = caseNumber;
            this.caseSubject = caseSubject;
            this.caseDesc = caseDesc;
            this.casePriority = casePriority;
            this.caseType = caseType;
            this.accName = accName;
            this.conName = conName;
            this.caseReason = caseReason;
            this.caseLink = caseLink;
        }
     }   
}