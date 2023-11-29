$ConfigFilePath = "C:\Program Files (x86)\Palo Alto Networks\User-ID Agent\UserIDAgentConfig.xml"
$apiToken = "_API_KEY_"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Authorization", "Token $apiToken")


$apiUrlUser = "https://NETBOX_URL/api/ipam/prefixes/?tag=__USER_TAG__&limit=10000"
$apiUrlGP = "https://NETBOX_URL/api/ipam/prefixes/?tag=__VPN_TAG__&limit=10000"


$responseUser = Invoke-WebRequest -Uri $apiUrlUser -Headers $headers
$responseGP = Invoke-WebRequest -Uri $apiUrlGP -Headers $headers

$strNewNetEntries = ""

if ($responseUser.StatusCode -lt 300)
{

  if ($responseUser.StatusCode -lt 300)
  {
    foreach ($prefix in ($responseUser.Content | ConvertFrom-Json).results)
    {
      $strNewNetEntries += "<net-entry name=""" + $prefix.site.name + " - " + $prefix.description  + """ address=""" + $prefix.prefix + """ include=""1""/>"
    }
  }

  if ($responseGP.StatusCode -lt 300)
  {
    foreach ($prefix in ($responseGP.Content | ConvertFrom-Json).results)
    {
      $strNewNetEntries += "<net-entry name=""" + $prefix.site.name + " - " + $prefix.description  + """ address=""" + $prefix.prefix + """ include=""1""/>"
    }
  }

  # Get the current config file into a string
  $strConfigText = Get-Content $ConfigFilePath -Raw 
  
  $intStart =  $strConfigText.IndexOf("<include-exclude-settings>") + 26
  $intEnd =  $strConfigText.IndexOf("</include-exclude-settings>")

  $strCurrentNetEntries = $strConfigText.Substring($intStart, $intEnd - $intStart)


  $xml_current = New-Object XML
  $xml_current.LoadXml($strConfigText)
    
  $xml_new = New-Object XML
  $xml_new.LoadXml($strConfigText.Replace($strCurrentNetEntries, $strNewNetEntries))


  if ($xml_current.OuterXml -ne $xml_new.OuterXml)
  {
    $xml_new.Save($ConfigFilePath)
    
    Restart-Service "UserIDService"
  }
}