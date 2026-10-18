public class ContactAgentAction {
 
    public class InputRequest {
        @InvocableVariable(required=true)
        public String contactName;
    }
    
    public class OutputResponse {
        @InvocableVariable
        public String contactDetails;
        
        @InvocableVariable
        public String accountDetails;
        
        @InvocableVariable
        public String message;
    }
    
    @InvocableMethod(label = 'Get Contact with Account Details')
    public static List<OutputResponse> getContactDetails(List<InputRequest> lstOfRequest) {
        List<OutputResponse> lstOfOutputResponse= new List<OutputResponse>(); 
        OutputResponse response = new OutputResponse();
       
        InputRequest request = lstOfRequest[0];
        
        List<COntact> lstOfContact = [SELECT Id, Name, Email, Phone, Title, Department, Account.Name, Account.Industry, Account.Phone, Account.Website, Account.AnnualRevenue FROM Contact WHERE Name LIKE : ('%' + request.contactName + '%') LIMIT 1];
        
        if(!lstOfContact.isEmpty()) {
            Contact recOfCOntact = lstOfContact[0];
            response.contactDetails = 
                'Name : '+ recOfCOntact.Name +
                '\n Title: '+recOfCOntact.Title +
                '\n Email: '+recOfCOntact.Email + 
                '\n Phone: '+recOfCOntact.Phone + 
                '\n Department '+recOfCOntact.Department;
            
            if(recOfCOntact.AccountId != null) {
                response.AccountDetails = 
                    'Account Name : '+recOfCOntact.Account.Name +
                    '\n Industry : '+recOfCOntact.Account.Industry + 
                    '\n Phone : '+recOfCOntact.Account.Phone + 
                    '\n Webside : '+recOfCOntact.Account.Website + 
                    '\n Annual Revenue : '+recOfCOntact.Account.AnnualRevenue;
            }else {
                response.message = 'No Account Associated with this Contact';
            }
            response.message = 'Contact Found Successfully';
        }else{
            response.message = 'No Contact Found';
            response.contactDetails = '';
            response.accountDetails = '';
        }
        lstOfOutputResponse.add(response);
        return lstOfOutputResponse;
             
    }
}