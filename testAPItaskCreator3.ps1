
$ApiKey = Get-Content "e:\SD\apikey.txt";
$ApiRoot = "https://sysadmin.barnabasfund.net/api/v3";
$SDLink = ($ApiRoot + "/tasks?format=json&");
    
     $status = @{};
     $status.Add("name","Open");
     
          
     $request = @{};
     $request.Add("id","833");
     
     $owner = @{};
     $owner.Add("id","178");
     $owner.Add("name","John Tandy");
     $owner.Add("email_id","john.tandy@barnabasfund.org");
     
     $prority =@{};
     $prority.Add("name","Low");
             
 
     $detail = @{};
     $detail.Add("title","SSL for westminster-institute");
     $detail.Add("description","Buy new SSL for domain from Namecheap"); 
     $detail.Add("priority",$prority);
     $detail.Add("status",$status);   
     $detail.Add("owner",$owner);   
 
  
  
     $detail.Add("request",$request);   
     $detail.Add("associated_entity", "request");
 
 

     $operation = @{};     
     $operation.Add("task",$detail);
 
      
   $input_data = $operation | ConvertTo-Json

   $input_data




 

$SDLink = $SDLink + "INPUT_DATA=$input_data&TECHNICIAN_KEY=$ApiKey"


 

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

   
         $result =Invoke-WebRequest -Method POST -Uri $SDLink
         $result