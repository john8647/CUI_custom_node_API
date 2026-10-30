
$ApiKey = Get-Content "e:\SD\apikey.txt";
$ApiRoot = "https://sysadmin.barnabasfund.net/api/v3";
$SDLink = ($ApiRoot + "/tasks?format=json&");
    
     $status = @{};
     $status.Add("name","Open");
     
 
     
     $owner = @{};
     $owner.Add("id","178");
     $owner.Add("name","John Tandy");
     $owner.Add("email_id","john.tandy@barnabasfund.org");
     
     $prority =@{};
     $prority.Add("name","Low");
             
 
     $detail = @{};
     $detail.Add("title","Update Checker (Grange) licence key");
      
     $detail.Add("priority",$prority);
     $detail.Add("status",$status);   
     $detail.Add("owner",$owner);   
 
  
  
 
 
 

     $operation = @{};     
     $operation.Add("task",$detail);
 
      
   $input_data = $operation | ConvertTo-Json

   $input_data




 

$SDLink = $SDLink + "INPUT_DATA=$input_data&TECHNICIAN_KEY=$ApiKey"


 

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

   
         $result =Invoke-WebRequest -Method POST -Uri $SDLink
         $result