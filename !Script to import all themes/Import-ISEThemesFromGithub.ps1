# The below PowerShell commands import all 37 themes from https://github.com/marzme/PowerShell_ISE_Themes into the PowerShell ISE

# List of the ends of the URLs of each of the raw ps1xml theme files in the repo
$ThemeURLEnds = @(
    "Ambient/Ambient.StorableColorTheme.ps1xml"
    "Ambients/Ambients.StorableColorTheme.ps1xml"
    "Aquatic/Aquatic.StorableColorTheme.ps1xml"
    "Base16_Tomorrow/Base16_Tomorrow.StorableColorTheme.ps1xml"
    "Black_Pastel/Black_Pastel.StorableColorTheme.ps1xml"
    "DependOnMe/DependOnMe.StorableColorTheme.ps1xml"
    "Dracula_JetBrains/Dracula_JetBrains.StorableColorTheme.ps1xml"
    "Flare_v1/Flare_v1.StorableColorTheme.ps1xml"
    "GEdit_Original/GEdit_Original.StorableColorTheme.ps1xml"
    "Havenjark/Havenjark.StorableColorTheme.ps1xml"
    "Monokai/Monokai.StorableColorTheme.ps1xml"
    "Navy_Ocean/Navy_Ocean.StorableColorTheme.ps1xml"
    "Nightvale/Nightvale.StorableColorTheme.ps1xml"
    "Notepad%2B%2B_Like/Notepad%2B%2B_Like.StorableColorTheme.ps1xml"
    "Oblivion/Oblivion.StorableColorTheme.ps1xml"
    "Obsidian/Obsidian.StorableColorTheme.ps1xml"
    "Ocean_Deep/Ocean_Deep.StorableColorTheme.ps1xml"
    "Paper_Rose/Paper_Rose.StorableColorTheme.ps1xml"
    "Pastel/Pastel.StorableColorTheme.ps1xml"
    "Placidity/Placidity.StorableColorTheme.ps1xml"
    "Plastic_Code_Wrap/Plastic_Code_Wrap.StorableColorTheme.ps1xml"
    "Python_Idle_Tango/Python_Idle_Tango.StorableColorTheme.ps1xml"
    "Railscast/Railscast.StorableColorTheme.ps1xml"
    "RecognEyes/RecognEyes.StorableColorTheme.ps1xml"
    "Retta/Retta.StorableColorTheme.ps1xml"
    "Roboticket/Roboticket.StorableColorTheme.ps1xml"
    "Solarized/Solarized.StorableColorTheme.ps1xml"
    "Solarized_Light/Solarized_Light.StorableColorTheme.ps1xml"
    "Space_Gray/Space_Gray.StorableColorTheme.ps1xml"
    "Sublime_Text_2/Sublime_Text_2.StorableColorTheme.ps1xml"
    "Tomorrow_Night/Tomorrow_Night.StorableColorTheme.ps1xml"
    "VS2013_Dark/VS2013_Dark.StorableColorTheme.ps1xml"
    "Vibrant_Ink/Vibrant_Ink.StorableColorTheme.ps1xml"
    "Vim_Dark/Vim_Dark.StorableColorTheme.ps1xml"
    "Vim_Dessert/Vim_Dessert.StorableColorTheme.ps1xml"
    "Wombat/Wombat.StorableColorTheme.ps1xml"
    "Zenburn/Zenburn.StorableColorTheme.ps1xml"
)

# Start of the URL to each of the raw ps1xml theme files in the repo
$URLStart = "https://raw.githubusercontent.com/marzme/PowerShell_ISE_Themes/master/"

# Test if the ISE Themes registry key path exists, and create it if it doesn't
$ISEThemesRegPath = 'HKCU:\Software\Microsoft\PowerShell\3\Hosts\PowerShellISE\ColorThemes'
if (!(Test-Path $ISEThemesRegPath)) {New-Item -Path $ISEThemesRegPath -Force | Out-Null}

# For each theme, get the raw XML contents, extract the theme name from the XML, and import the theme into the ISE Themes by creating and populating the relevant registry key
foreach ($ThemeURL in $ThemeURLEnds) {

    # Construct full URL
    $CurrentThemeURL = $URLStart + $ThemeURL

    # Retrieve the raw contents of the current theme's .ps1xml file directly from GitHub
    [string]$StringXML = (Invoke-WebRequest $CurrentThemeURL).Content
    [xml]$XMLTheme = $StringXML

    # Import the theme to the PowerShell ISE by creating and populating the relevant registry key
    Write-Verbose "Importing $($XMLTheme.StorableColorTheme.Name)..." -Verbose
    Set-ItemProperty $ISEThemesRegPath -Name $XMLTheme.StorableColorTheme.Name -Value $StringXML -Type String
}
