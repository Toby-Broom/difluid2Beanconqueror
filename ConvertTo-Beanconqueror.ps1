param (
    [string]$File,
    [switch]$force = $false,
    [switch]$JSON = $false,
    [switch]$NoTime = $false
    )

function New-BCBrew (){

$data= [ordered]@{}
$data['grind_size'] = ""
$data['grind_weight'] = 0
$data['method_of_preparation'] = ""
$data['mill'] = ""
$data['mill_speed'] = 0
$data['mill_timer'] = 0
$data['pressure_profile'] = ""
$data['bean'] = ""
$data['brew_temperature_time'] = 0
$data['brew_temperature'] = 0
$data['brew_time'] = 0
$data['brew_quantity'] = 0
$data['brew_quantity_type'] = "GR"
$data['note'] = ""
$data['rating'] = 0
$data['coffee_type'] = ""
$data['coffee_concentration'] = ""
$data['coffee_first_drip_time'] = 0
$data['coffee_blooming_time'] = 0
$data['attachments'] = @()
$data['config'] = [ordered]@{}
$data['config']['uuid'] = ""
$data['config']['unix_timestamp'] = 0
$data['tds'] = 0
$data['brew_beverage_quantity'] = 0
$data['brew_beverage_quantity_type'] = "GR"
$data['brew_time_milliseconds'] = 0
$data['brew_temperature_time_milliseconds'] = 0
$data['coffee_first_drip_time_milliseconds'] = 0
$data['coffee_blooming_time_milliseconds'] = 0
$data['coordinates'] = [ordered]@{}
$data['coordinates']['accuracy'] = $NULL
$data['coordinates']['altitude'] = $NULL
$data['coordinates']['altitudeAccuracy'] = $NULL
$data['coordinates']['heading'] = $NULL
$data['coordinates']['latitude'] = $NULL
$data['coordinates']['longitude'] = $NULL
$data['coordinates']['speed'] = $NULL
$data['cupping'] = [ordered]@{}
$data['cupping']['body'] = 0
$data['cupping']['brightness'] = 0
$data['cupping']['clean_cup'] = 0
$data['cupping']['complexity'] = 0
$data['cupping']['cuppers_correction'] = 0
$data['cupping']['dry_fragrance'] = 0
$data['cupping']['finish'] = 0
$data['cupping']['flavor'] = 0
$data['cupping']['sweetness'] = 0
$data['cupping']['uniformity'] = 0
$data['cupping']['wet_aroma'] = 0
$data['cupping']['notes'] = ""
$data['cupped_flavor'] = [ordered]@{}
$data['cupped_flavor']['predefined_flavors'] = [ordered]@{}
$data['cupped_flavor']['custom_flavors'] = @()
$data['method_of_preparation_tools'] = @()
$data['bean_weight_in'] = 0
$data['favourite'] = $FALSE
$data['best_brew'] = $FALSE
$data['water'] = ""
$data['vessel_name'] = ""
$data['vessel_weight'] = 0
$data['flow_profile'] = ""
$data['reference_flow_profile'] = [ordered]@{}
$data['reference_flow_profile']['type'] = "NONE"
$data['reference_flow_profile']['uuid'] = ""
$data['preparationDeviceBrew'] = [ordered]@{}
$data['preparationDeviceBrew']['type'] = "NONE"
$data['customInformation'] = [ordered]@{}
$data['customInformation']['visualizer_id'] = ""

$data

}

If (!(Test-Path $File)){break}

$InputFile = Get-ItemProperty $File

$BrewData = New-BCBrew

$BrewData['config']['uuid'] = (New-Guid).Guid

$bean = (Get-ItemProperty $File).Name.Split('_')[1].Split('.')[0]

Switch($bean){
    'Kander' {$BrewData['bean'] = "d34097dd-2739-4646-bf52-116cc29fa5c5"}
    'Dark' {$BrewData['bean'] = "0287e4c9-bfb2-4122-bac5-e7bada249ccf"}
    'Taioba' {$BrewData['bean'] = "b89f1441-713d-4c2f-8cbb-e3bcece058c7"}
    'Brazil' {$BrewData['bean'] = "49c92416-72b5-420f-b2ad-3e27010de7df"}
    'El Diviso' {$BrewData['bean'] = "e78656dd-51f1-4f97-963b-40e942def2f6"}
    'Daterra' {$BrewData['bean'] = "df5f3d13-a5db-4d88-a178-cd7b5b106bf9"}
    'Pearl' {$BrewData['bean'] = "2d168909-5244-4932-b59e-9b85da834651"}
    'Pink Bourbon' {$BrewData['bean'] = "ec5db534-ab1a-417e-9286-afcdb5099f23"}
    'Visconti' {$BrewData['bean'] = "5c2b10ec-5277-4791-943d-b947b6693136"}
    'Vilcabamba' {$BrewData['bean'] = "3e795734-5bc5-4be3-b7f3-a990152ea992"}
    'Bukoba1' {$BrewData['bean'] = "a1e2c623-a42f-4a2b-b831-5402328895ab"}
    'Nantic' {$BrewData['bean'] = "9b5afc7c-2a92-4048-ac26-0fbd85aa3b70"}
    'Kereicoondah' {$BrewData['bean'] = "cc874308-71c8-488a-8a69-3ca88a9a35cc"}
    'Bukoba' {$BrewData['bean'] = "b0f15e57-4387-4fb7-a2d4-dabfc974cfd2"}
    'Jansen' {$BrewData['bean'] = "d497c8a1-3b6d-4216-8b90-5e82e52dd4dc"}
    'Wilton Benitez' {$BrewData['bean'] = "e3babcc5-12e4-4bd9-828b-6d7c260e3ec0"}
    'Desta' {$BrewData['bean'] = "e5ec85f5-adbf-4239-95b4-84dacdb5c6dd"}

    default {break}
}

$DiData = (Get-Content $File)

if (($DiData.Split("[").Count -eq 5) -xor ($DiData.Split("[").Count -eq 6)){
    $headders = $DiData.Split("[")[0].Split(",")
    $meta = $DiData.Split("[")[1].Trim().Split(",") + $DiData.Split("[")[4].Split("]")[1].Split(",")
    $Flow_Chart_Time = $DiData.Split("[")[2].Split("]")[0].Split(", ")
    If ($NoTime){}
    Else{$BrewData['brew_time'] = (New-TimeSpan -Minutes $Flow_Chart_Time[$Flow_Chart_Time.Length-1].Split(':')[0] -Seconds $Flow_Chart_Time[$Flow_Chart_Time.Length-1].Split(':')[1]).TotalSeconds -as [int]}
    $BrewData['tds'] = $meta[15] -as [float]
}
elseif (($DiData.Split("[").Count -eq 3) -xor ($DiData.Split("[").Count -eq 2)){
    $headders = $DiData.Split("`r`n")[0].Split(",")
    $meta = $DiData.Split("`r`n")[1].Trim().Split(",")
    $BrewData['tds'] = $meta[13] -as [float]
}

$BrewData['config']['unix_timestamp'] = ($meta[0] / 1000) -as [Long]

if ($meta[0] -as [Long] -lt 1716194347565){
    $BrewData['method_of_preparation'] = "eb42f58a-35fd-4886-8154-3012e397506b" #Gaggia Classic Pro Eco
    $BrewData['pressure_profile'] = "Flat 9 bar" 
}
else {$BrewData['method_of_preparation'] = "8b4a2a9e-f20e-4623-8ab1-62485246ef3d"} #Gaggiuino 

$BrewData['grind_weight'] = $meta[6] -as [float]
$BrewData['brew_temperature'] = $meta[8] -as [int]
$BrewData['brew_beverage_quantity'] = $meta[9] -as [float]

Switch ($meta[11]){
    'G2024010709143867092300593334' {$BrewData['mill'] = "ed6b03a0-ab2d-4ceb-9b09-ea4d570bd200"} #Rancilio Rocky
    'G2024020410450067092526630115' {$BrewData['mill'] = "ed6b03a0-ab2d-4ceb-9b09-ea4d570bd200"} #Rancilio Rocky
    'G2024050310050367092573868129' {$BrewData['mill'] = "621aa54b-559c-4567-a1c6-7af0411811e1"} #DF64 SSP HU

    default {break}
}

$BrewData['grind_size'] = $meta[12]

$NewPath = $InputFile.FullName.Split('_')[0] + '.json'

If ($JSON){ConvertTo-Json $BrewData}
Else{
     if (
     ($BrewData.brew_time -In 10..40) -and
     ($BrewData.brew_beverage_quantity -In 30..50)
     )
     {
     [void](New-item -Path $NewPath -ItemType file -Value (ConvertTo-Json $BrewData))
     }
 elseif($force){
     [void](New-item -Path $NewPath -ItemType file -Value (ConvertTo-Json $BrewData))
 }
}