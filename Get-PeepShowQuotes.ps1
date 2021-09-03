param (
    [Parameter(Mandatory= $false)]
    [String] $SearchTerm,

    [Parameter(Mandatory= $false)]
    [String] $Character,

    [Parameter(Mandatory= $false)]
    [String] $Season,

    [Parameter(Mandatory= $false)]
    [String] $Episode
)

$Headers = @{
    'Content-Type' = "application/json;charset=UTF-8"
    'kbn-xsrf' = "true"
}

# Constructing the REST request
$Body = @'
{

'@ 
if ($Character) {

   $Body += @'
   "person" : "
'@ + $Character + @'
 ",

'@ 
}
if ($SearchTerm) {
    
   $Body += @'
   "searchTerm" : "
'@ + $SearchTerm + @'
",

'@  
}
if ($Season) {
    
   $Body += @'
   "seriesNumber" : "
'@ + $Season + @'
",

'@  

}

if ($Episode) {

   $Body += @'
   "episodeNumber" : "
'@ + $Episode + @'
",

'@  

}

$Body += @'
}
'@

$RestMethod = Invoke-RestMethod -Uri "https://api.peepquote.com/search" -Method "GET" -Headers $Headers -Body $Body

Write-Output $RestMethod
Write-Host $Body