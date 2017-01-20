[DSCLocalConfigurationManager()]

Configuration LCM_Pull {
    
    Node CLI1 {

        Settings {
            ConfigurationMode = 'ApplyAndAutoCorrect'
            RefreshMode = 'Pull'
            }

        ConfigurationRepositoryWeb PullServer {
            ServerURL = 'http://pull:8080/PsDscPullserver.svc'
            AllowUnsecureConnection = $True
            RegistrationKey = '0f9ae841-785d-4a2d-8cdf-ecae01f44cdb'
            ConfigurationNames = @('TimeZoneConfig')
            }

        ResourceRepositoryWeb PullServerModules {
            ServerURL = 'http://pull:8080/PsDscPullserver.svc'
            AllowUnsecureConnection = $True
            RegistrationKey = '0f9ae841-785d-4a2d-8cdf-ecae01f44cdb'
            }
    }
}

LCM_Pull
