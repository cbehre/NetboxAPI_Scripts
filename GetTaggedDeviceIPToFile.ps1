
$apiUrl = "https://NETBOX_URL/api/dcim/devices/?tag=TAG_NAME"
$apiToken = "__API_KEY__"

$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Token $apiToken")

$response = Invoke-WebRequest -Uri $apiUrl -Headers $headers -Method Get 

if ($response.StatusCode -lt 300)
{
    $data = $response.Content | ConvertFrom-Json
    $ipv4List =  $data.results.primary_ip4.display
    $ipv4List | Out-File -encoding utf8 -FilePath "C:\TaggedDeviceIPs.txt"
}