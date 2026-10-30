
$ApiKey = Get-Content "e:\SD\apikey.txt";

$ApiRoot = "https://sysadmin.barnabasfund.net/api/v3";

 


$Uri = ($ApiRoot + "/request");
    # Build a Hash table which we can convert to JSON
    $details = @{};
    $details.Add("OPERATION_NAME","ADD_REQUEST");
    $details.Add("requester","John Tandy");
    $details.Add("subject","Sharperlight not working"); 
    $details.Add("category","Software"); 
    $details.Add("description","No data requests");
    $details.Add("requesttemplate","Default Request");
    $details.Add("priority","Low");
    $details.Add("site","UK");
    $details.Add("group","Network");
    $details.Add("technician","John Tandy");
    $details.Add("level","IT - Support");
    $details.Add("status","open");
    $details.Add("service","Email");
     
      $detail = @{};
     $detail.Add("details",$details);

       $operation = @{};
     $operation.Add("operation",$detail);
     

   $input_data = $operation | ConvertTo-Json

   $input_data


$Uri = $Uri + "?format=json&OPERATION_NAME=ADD_REQUEST&INPUT_DATA=$input_data&TECHNICIAN_KEY=$ApiKey"
 #Invoke-RestMethod -Method POST -Uri $Uri


  
     [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
   
         $result =Invoke-WebRequest -Method POST -Uri $Uri 
         $result

        $LastRequestObject = ConvertFrom-Json –InputObject $result


write-host $LastRequestObject.requests.id