public class CaseRetrievalController {
   
    @InvocableMethod(label='Retrieve Cases'  description='Fetch all the cases from the system')
    public static List<CaseResponse> getCases(List<CaseRequest> caseReq) {

        List<CaseResponse> lstresponse = new List<CaseResponse>();
        CaseResponse res = new CaseResponse();
        res.lstCases = new AvailableCases();
        res.lstCases.caseOptions = new List<CaseDetails>();

        for(Case objCase : [SELECT Id, Status, CaseNumber, ClosedDate, Description, Subject, Contact.Name, Account.Name, Priority, 
                            Type FROM Case WHERE Status != null AND Account.Name != null AND Contact.Name != null AND Priority != null 
                            AND Subject != null AND Type != null LIMIT 100
                            ]) {
         
           CaseDetails newCase = new CaseDetails();
           newCase.caseId = objCase.Id;
           newCase.caseNum = objCase.CaseNumber;
           newCase.caseStatus = objCase.Status;
           newCase.contactName = objCase.Contact.Name;
           newCase.accName = objCase.Account.Name;
           newCase.caseType = objCase.Type;
           newCase.casePriority = objCase.Priority;
           newCase.caseSubject = objCase.Subject;
           newCase.urlLink = URL.getOrgDomainURL().toExternalForm()+ '/'+objCase.Id;
           res.lstCases.caseOptions.add(newCase);
                        
            }
            lstresponse.add(res);

            return lstresponse;

    }

    public class CaseRequest {
        @InvocableVariable public string caseNumber;
    }

    public class CaseResponse {
        @InvocableVariable 
        public AvailableCases lstCases;
    }

    public class AvailableCases {
        @InvocableVariable
        public List<CaseDetails> caseOptions;
    }
    public class CaseDetails {
        @InvocableVariable public String caseId;
         @InvocableVariable public String caseNum;
        @InvocableVariable public String caseStatus;
        @InvocableVariable public String contactName;
        @InvocableVariable public String accName;
        @InvocableVariable public String caseType;
        @InvocableVariable public String casePriority;
        @InvocableVariable public String caseSubject;
        @InvocableVariable public String urlLink;
    }
}