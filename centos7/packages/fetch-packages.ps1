# NOTE: THIS IS RUN ON HOST SYSTEM
#  This package works for CentOS 7 or RHEL 7

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

@("manage", "reporting") | Foreach {
  ##### Local Variables
  $PACKAGE = $JSON_DATA[$_]["package"]
  $PACKAGE_URL = $ExecutionContext.InvokeCommand.ExpandString($JSON_DATA[$_]["url"])
  ##### Download Locally if file does not exist
  if (-Not $(Test-Path $PACKAGE)) {
    "Downloading $PACKAGE"
    (New-Object System.Net.WebClient).DownloadString("$PACKAGE_URL") > "$PACKAGE"
  }
}