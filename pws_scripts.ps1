function createCR {
    $url = "https://dev212832.service-now.com/api/now/table/change_request"
    $auth = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("admin:tt!rSy25Y^SK"))
    $headers = @{
        "Authorization" = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("admin:tt!rSy25Y^SK"))
        "Content-Type"  = "application/json"
    }
    $body = @{
        "short_description" = "Azure Pipeline Success: $(Build.DefinitionName)"
        "description"       = "Pipeline succeeded for build $(Build.BuildId)"
        "category"          = "Software"
        "type"              = "Normal"
        "priority"          = "4"
        "assignment_group"  = "Change Management"
    } | ConvertTo-Json
    Write-Host "URI: $url"
    Write-Host "Auth: $auth"
    Write-Host "headers: $headers"
    Write-Host "body: $body"
    $response = Invoke-RestMethod -Uri $url -Method Post -Headers $headers -Body $body
    $changeRequestId = $response.result.sys_id
    Write-Host "Change Request created with SysID: $changeRequestId"
}

