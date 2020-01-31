/* IN THIS DO FILE
1) IMPORT OF SERVICES
2) EXPORT OF SERVICES
3) OUTPUT OF SERVICE
4) IMPORT SHARE OF SERVICES
*/

*=============================================================
* IMPORT OF SERVICES, YEARLY FILES
*============================================================
clear
cd "K:\FirstChapter\Services"

use importServices.dta
drop maintenanceandrepairservicesnie transport travelforallpurposesincludingedu chargesfortheuseofintellectualpr governmentgoodsandservicesnie var12-var20
gen Total =total *1000000
gen InsImport  =insuranceservices *1000000 
gen FinImport= financialservices*1000000
gen TelImport=telecommunicationscomputerandinf *1000000
gen BusImport= otherbusinessservices *1000000
drop telecommunicationscomputerandinf insuranceservices financialservices otherbusinessservices total
rename period yr
save ImpServices.dta, replace

*YEARLY FILES

forvalues i=1/14{
clear
use ImpServices.dta
keep in `i'
local s=`i'+98
save `s'ImportServices.dta,replace
}

*==============================================================
*	EXPORT OF SERVICES, THEN CREATE YEARLY FILES
*===============================================================

clear
cd "K:\FirstChapter\Services"
use exportServices.dta
drop maintenanceandrepairservicesnie transport travelforallpurposesincludingedu chargesfortheuseofintellectualpr governmentgoodsandservicesnie
gen Total= total *1000000
gen InsExport=  insuranceservices *1000000 
gen FinExport= financialservices* 1000000
gen TelExport= telecommunicationscomputerandinf *1000000 
gen BusExport= otherbusinessservices* 1000000
drop insuranceservices financialservices telecommunicationscomputerandinf otherbusinessservices total
rename period yr
save ExpServices.dta, replace

*YEARLY FILES
forvalues i=1/14{
clear
use ExpServices.dta
keep in `i'
local s=`i'+98
save `s'ExportServices.dta,replace
}

*============================================================
*	OUTPUT OF SERVICES
*================================================================
clear
cd "K:\FirstChapter\InputOutput\NOMINAL_USE"
 
forvalues i=99/110 ///
 {
	clear
	cd "K:\FirstChapter\InputOutput\NOMINAL_USE"
	insheet using use`i'.csv
	
	
	rename v# v#, renumber //Renumbering so that sector 1 is v1 as opposed to v2
	egen output1 =rowtotal(v1-v196)
	generate output = output1 *1000000
	drop v1-v196
	cd "K:\FirstChapter\InputOutput"
	save ServiceOutput`i'.dta,replace
 }
 
 
clear
 forvalues i=99/110 ///
{
	use ServiceOutput`i'.dta
	drop if sector<104 |sector>128
	egen FinanceOutput=sum(output) if sector==110 | sector==111 |sector==114
	egen TelOutput=sum(output) if sector>=104 & sector<=109
	egen InsuranceOutput=sum(output) if sector==112 | sector==113
	egen BusinessOutput=sum(output) if sector>=120 & sector<=128
	egen Finaloutput=rowmax(TelOutput InsuranceOutput BusinessOutput FinanceOutput)
	keep if sector==104 | sector==110 | sector==112 | sector==120
	keep sector Finaloutput

xpose, clear
rename v1 TelOutput
rename v2 FinOutput
rename v3 InsOutput
rename v4 BusOutput
drop in 1
gen yr=`i'
save SerOut`i'.dta,replace
}


*=========================================================
* CALCULATING IMPORT SHARE
*=========================================================
clear
cd "K:\FirstChapter\Services"

forvalues i=99/110 ///
{
	use `i'ImportServices.dta
	merge m:m yr using `i'ExportServices.dta
	drop _merge
	drop yr
	gen yr=`i'
	save `i'ImpExpServices.dta,replace
}


forvalues i=99/110 ///
{
	cd "K:\FirstChapter\Services"
	use `i'ImpExpServices.dta
	cd "K:\FirstChapter\InputOutput"
	merge m:m yr using SerOut`i'.dta
	drop _merge

	gen FinSupply=FinOutput+FinImport-FinExport
	gen InsSupply= InsOutput +InsImport - InsExport
	gen BusSupply= BusOutput + BusImport - BusExport
	gen TelSupply= TelOutput + TelImport - TelExport
	gen TelImportShare = TelImport/TelSupply
	gen FinImportShare= FinImport/FinSupply
	gen InsImportShare = InsImport/InsSupply
	gen BusImportShare= BusImport/BusSupply

save ServiceImportShare`i'.dta,replace

	keep TelImportShare FinImportShare InsImportShare BusImportShare 
	xpose, clear
	gen sector=.
	replace sector =104 in 1
	replace sector = 110 in 2
	replace sector=112 in 3
	replace sector=120 in 4
	rename v1 ImportShare
gen yr=`i'
save ServiceImportShare`i'.dta,replace
}

cd "K:\FirstChapter\Programs\New Final Programs"
