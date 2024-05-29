# difluid2Beanconqueror

It converts the csv files (generated with version 4.0.3 of the DiFluid Café App) to the JSON format of Beanconqueror (Used by the app 7.2.1)

I wanted to migrate data from DiFluid Café to Beanconqueror so I wrote this script.

I had some unusual data that I wanted to check so there is check that the duration of the extraction is in the range of 10 to 40 seconds and the mass of the collected coffee is in the range of 30 to 50 g.

# Usage

ConvertTo-Beanconqueror.ps1 -File -JSON -force -NoTime

The switch -File the path of that csv file that should be converted e.g. C:\User\files\BrewRecord_bean.csv

The switch -JSON if you want a preview of what the data will look like.

The switch -force , this will ignore unusual checks and export the data anyway.

The switch -NoTime Also to manage some unusal data e.g. if my shot was under 10 s, then I wanted for force the to a duration of 0 s.

You can combine the switches.

> [!WARNING]
> Since DiFluid App does not store beans in exported data, I edited the BrewRecord file name to be BrewRecord_bean, in the Beanconqueror app I manually created the bean and there is a static lookup table of the beans parsed from the file name.

> [!CAUTION]
> The DiFluid App allows to export multiple shots in to one file this is not supported

> [!WARNING]
> Since DiFluid App store the grinders in a format like 'G2000000000000000000000000000' then I also created a look table to convert the DiFluid ID to the GUID of the grinder that was manually created in Beanconqueror

> [!WARNING]
> You will need to merge the created JSON files in to the exported Beanconqueror.json


## Example Usage

Command Line: ConvertTo-Beanconqueror.ps1 -File C:\User\files\BrewRecord_bean.csv

Output : C:\User\files\BrewRecord.json

Command Line: ConvertTo-Beanconqueror.ps1 -File C:\User\files\BrewRecord_bean.csv -JSON

Output : {
  "grind_size": "7",
  "grind_weight": 18.0,
  "method_of_preparation": "eb42f58a-35fd-4886-8154-3012e397506b",
  "mill": "ed6b03a0-ab2d-4ceb-9b09-ea4d570bd200",
  "mill_speed": 0,
  "mill_timer": 0, .............

Command Line: ConvertTo-Beanconqueror.ps1 -File C:\User\files\BrewRecord_bean.csv -force

Input: 	1716194803207,May 20th 2024 Brew,User,Espresso,g,°C,17,0,93,47,,G2024050310050367092573868129,15,

Output : C:\User\files\BrewRecord.json, with unsual numbers

Command Line: ConvertTo-Beanconqueror.ps1 -File C:\User\files\BrewRecord_bean.csv -NoTime

Input: 	..... [00:00, 00:01, 00:01, 00:01, 00:01]

Output : C:\User\files\BrewRecord.json, with time set to 0





