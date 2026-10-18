@RestResource(urlMapping = '/Account/*')
global class DemoWebservice {
    @HttpGet
    global static String getAccountDataeById(){
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String message = '';
        String accId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        if(accId.length() != 15 && accId.length() != 18)
        {
            response.statusCode = 400;
            message = 'This is an invalid Id. Please provide a valid Id';
            return message;
        }
        List<Account> lstOfAccountToReturn = [SELECT Id, Name, Phone, Industry FROM Account WHERE Id =:accId];
        if(lstOfAccountToReturn.isEmpty())
        {
            response.statusCode = 404;
            message = 'There is no Account with provided Id';
            return message;
        }
        return JSON.serialize(lstOfAccountToReturn);
        
    }
    
    @HttpPost
    global static String createAccountRecord(String	acc_name, String fax, String phone)
    {
        RestResponse response = RestContext.response;
        if(String.isBlank(fax))
        {
            response.statusCode = 400;
            return 'Fax field cannot be left empty';
        }
        else if(String.isBlank(acc_name))
        {
            response.statusCode = 400;
            return 'Account name field cannot be left empty';
        }
        try
        {
            Account recOfAccount = new Account();
            recOfAccount.Name = acc_name;
            recOfAccount.Fax = fax;
            recOfAccount.Phone = phone;
            insert recOfAccount;
            response.statusCode = 201;
            return 'The Account record got successfully created with Id' + String.valueOf(recOfAccount.Id);
        }
        catch(Exception ex)
        {
            response.statusCode = 500;
            return ex.getMessage();
        }
    }
    
    @HttpDelete
    global static String deleteAccRec()
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String message = '';
        String accId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        if(accId.length() != 15 && accId.length() != 18)
        {
            response.statusCode = 400;
            message = 'This is an invalid Id. Please provide a valid Id';
            return message;
        }
        List<Account> lstOfAccountToReturn = [SELECT Id, Name, Phone, Industry FROM Account WHERE Id =:accId];
        if(lstOfAccountToReturn.isEmpty())
        {
            response.statusCode = 404;
            message = 'There is no Account with provided Id';
            return message;
        }
        try{
            delete lstOfAccountToReturn;
            response.statusCode = 202;
            return 'The Account record got successfully deleted with Id ' + accId;
        }
        catch(Exception ex)
        {
            response.statusCode = 500;
            return ex.getMessage();
        }
    }
    
    @HttpPut
    global static String updateAccountRecord(String	acc_name, String fax, String phone)
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String accId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        if(accId.length() != 15 && accId.length() != 18)
        {
            response.statusCode = 400;
            return 'This is an invalid Id. Please provide a valid Id';
            
        }
        
        if(String.isBlank(fax))
        {
            response.statusCode = 400;
            return 'Fax field cannot be left empty';
        }
        
        if(String.isBlank(acc_name))
        {
            response.statusCode = 400;
            return 'Account name field cannot be left empty';
        }
        
        List<Account> lstOfAccount = [SELECT Id, Name, Fax, Phone FROM Account WHERE Id = :accId];
        
        if(lstOfAccount.isEmpty())
        {
            response.statusCode = 404;
            return 'There is no Account with provided Id';
        }
        
        try
        {
            Account recOfAccount =  lstOfAccount[0];
            recOfAccount.Name = acc_name;
            recOfAccount.Fax = fax;
            recOfAccount.Phone = phone;
            update recOfAccount;
            response.statusCode = 200;
            return 'The Account record got successfully updated with Id' + String.valueOf(recOfAccount.Id);
        }
        catch(Exception ex)
        {
            response.statusCode = 500;
            return ex.getMessage();
        }
    }
    
    
    @HttpPatch
    global static String updatePatchAccountRecord(String acc_name, String fax, String phone)
    {
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String accId = request.requestURI.subString(request.requestURI.lastIndexOf('/')+1);
        if(accId.length() != 15 && accId.length() != 18)
        {
            response.statusCode = 400;
            return 'This is an invalid Id. Please provide a valid Id';
            
        }
        List<Account> lstOfAccount = [SELECT Id, Name, Fax, Phone FROM Account WHERE Id = :accId];
        
        if(lstOfAccount.isEmpty())
        {
            response.statusCode = 404;
            return 'There is no Account with provided Id';
        }
        
        try
        { 
            Account recOfAccount = lstOfAccount[0];
            
            // Update only fields provided in request
            if(acc_name != null)
            {
                recOfAccount.Name = acc_name;
            }
            
            if(fax != null)
            {
                recOfAccount.Fax = fax;
            }
            
            if(phone != null)
            {
                recOfAccount.Phone = phone;
            }
            
            update recOfAccount;
            response.statusCode = 200;
            return 'The Account record got successfully updated with Id' + String.valueOf(recOfAccount.Id);
        }
        catch(Exception ex)
        {
            response.statusCode = 500;
            return ex.getMessage();
        }
    }
    
}