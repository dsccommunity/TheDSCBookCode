Configuration PullServer {

Import-DscResource -ModuleName xPSDesiredStateConfiguration -ModuleVersion 5.1.0.0

    Node Pull {
        
        WindowsFeature DSCService {
            Name = "DSC-Service"
            Ensure = 'Present'
        }

        xDSCWebService Pullserver {
            Ensure = 'Present'
            EndpointName = 'PSDSCPullServer'
            Port = '8080'  
            PhysicalPath = "$env:SystemDrive\inetpub\wwwroot\PSDSCPullServer"
            ModulePath = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules" 
            ConfigurationPath = "$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration" 
            State = "Started"
            DependsOn = "[WindowsFeature]DSCService"
            UseSecurityBestPractices = $false
            CertificateThumbprint = "AllowUnencryptedTraffic"
        }

        File RegistrationKey {
            Ensure = 'Present'
            DestinationPath = "$env:PROGRAMFILES\WindowsPowershell\DscService\registrationKeys.txt"
            Contents = '0f9ae841-785d-4a2d-8cdf-ecae01f44cdb'
            Type = 'File'
            }
        
    }
}
            
PullServer