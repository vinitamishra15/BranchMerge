# Create change request in ServiceNow
              $servicenowInstance = "$(servicenowInstance)"
              $changeRequestUrl = "$servicenowInstance/api/now/table/change_request"
              $auth = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes("$(servicenowUser):$(servicenowPassword)"))

              # Change Request body (customize based on your ServiceNow change request schema)
              $changeRequestBody = @{
                short_description = "Automated Change Request for Deployment in Production"
                description = "Deployment to production environment"
                category = "Software"
                type = "Normal"
                # Add other fields as needed
              } | ConvertTo-Json

              # Make HTTP POST request to create change request
              $changeResponse = Invoke-RestMethod -Uri $changeRequestUrl -Method Post -Headers @{
                  Authorization = "Basic $auth"
                  "Content-Type" = "application/json"
              } -Body $changeRequestBody

              # Extract change request sys_id and state
              $changeRequestSysId = $changeResponse.result.sys_id
              Write-Host "Created Change Request with sys_id: $changeRequestSysId"
              Write-Host "CR Number: $changeResponse.result.number"

              # Store the sys_id as a pipeline variable for next steps
              Write-Host "##vso[task.setvariable variable=changeRequestSysId]$changeRequestSysId"
