Configuration TestUsing {

param (
 [Parameter()] 
 [ValidateNotNull()] 
 [PSCredential]$Credential = (Get-Credential -Credential Administrator)
)

 node $AllNodes.Where({$_.Role -eq 'DC'}).NodeName {
    
  $DomainCredential = New-Object `
   -TypeName System.Management.Automation.PSCredential `
   -ArgumentList ("$($node.DomainName)\$($Credential.UserName)", `
    $Credential.Password)

  script CreateNewGpo {
   Credential = $DomainCredential
   TestScript = {
    if ((get-gpo -name "Test GPO" `
                 -domain $Using:Node.DomainName `
                 -ErrorAction SilentlyContinue) -eq $Null)
    {
     return $False
    } else {
     return $True
    }
   } #Test
   
   SetScript = {
    new-gpo -name "Test GPO" -Domain $Using:Node.DomainName
   } #Set
   
   GetScript = {
    $GPO= (get-gpo -name "Test GPO" -Domain $Using:Node.DomainName)
    return @{Result = $($GPO.DisplayName)}
    
   } #Get   
 } #Script
} #Node
} #Configuration

TestUsing -OutputPath "C:\Using Example" -ConfigurationData ".\mj.psd1"