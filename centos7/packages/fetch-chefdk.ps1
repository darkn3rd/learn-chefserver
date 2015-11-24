# NAME: fetch-cheddk.ps1
# AUTHOR: Joaquin Menchaca
# CREATED: 2015-11-23
#
# PURPOSE: Downloads Chef Development Kit from Opscode
# DEPENDENCIES:
#  * Windows NT 6.1+ (Windows 7+) with PowerShell 1.0+
#  * System.web.extensions assembly for JSON parsing
#  * Global Configuration - global.json
# NOTES:
#  * This script should be run on the host system (Windows NT 6.1+)

##### JSON PARSER FUNCTION (PowerShell 2.0 compatible)
Function ConvertFromJson2($jsonString) {
    add-type -assembly system.web.extensions
    $ser = New-Object System.Web.Script.Serialization.JavaScriptSerializer
    return $ser.DeserializeObject($jsonString)
}

##### Fetch Global Data
$CONFIG="..\.config"
$JSON_STR = $(Get-Content $CONFIG\global.json)
$JSON_DATA = ConvertFromJson2($JSON_STR)

##### Local Variables
$PACKAGE = $JSON_DATA["devkit"]["package"]
$PACKAGE_URL = $ExecutionContext.InvokeCommand.ExpandString($JSON_DATA["devkit"]["url"])

##### Download Locally if file does not exist
if (-Not $(Test-Path $PACKAGE)) {
  (New-Object System.Net.WebClient).DownloadString("$PACKAGE_URL") > "$PACKAGE"
}
