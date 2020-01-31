clear

*=======================================
*          INDUSTRY IMPORTS
*=======================================

cd "K:\FirstChapter\Import"

forvalues i=99/110 ///
{
	cd "K:\FirstChapter\Import"
	use imp`i'.dta
	gen newN=string(naics)
	gen newNAICS=substr(newN,1,4)
	collapse (sum) gen_val_yr, by(newNAICS year) // Calculating imports by industry and year)
	rename gen_val_yr Imports
	rename newNAICS NAICS
	cd "K:\FirstChapter\ImportExport"
	save import`i'.dta,replace
}


*=================================================
* 	              INDUSTRY EXPORTS
*===================================================
clear
cd "K:\FirstChapter\Export"


forvalues i=99/110 ///
{
	cd "K:\FirstChapter\Export"
	use exp`i'.dta
	gen newN=string(naics)
	gen newNAICS=substr(newN,1,4)
	collapse (sum) all_val_yr, by(newNAICS year)  // Calculating exports by industry and year
	rename all_val_yr Exports
	rename newNAICS NAICS
	cd "K:\FirstChapter\ImportExport"
	save export`i'.dta,replace
 }
 
 
*====================================================
* 	INDUSTRY PRODUCTION
*=====================================================
clear


cd "K:\FirstChapter\Productivity Database"
use naics5809.dta
gen newN=string(naics)
gen newNAICS=substr(newN,1,4)
gen yr=mod(year,100)
replace yr=yr+100 if yr<10
drop if yr<90 
gen Production=vship*1000000
collapse (sum) Production, by (newNAICS yr)   // Calculating total production by industry and year
rename newNAICS NAICS
rename yr year
sort year
save newProd.dta,replace

* CREATING PRODUCTION ON YEARLY BASIS 

use newProd.dta

forvalues i=99/109 ///
{
	use newProd.dta
	keep if year==`i'
	save Prod`i'.dta,replace
}

*====================================================
* 	MERGE IMPORT, EXPORT, AND PRODUCTION ON YEARLY BASIS
*=========================================================

clear
cd "K:\FirstChapter\ImportExport"
forvalues i=99/110 ///
{
	use import`i'.dta
	merge m:m NAICS using export`i'.dta
	drop _merge
	save impexp`i'.dta, replace
 }

 
clear
forvalues i=99/109 ///
{
	cd "K:\FirstChapter\ImportExport"
	use impexp`i'.dta
	cd "K:\FirstChapter\Productivity Database"
	merge m:m NAICS using Prod`i'.dta
	cd "K:\FirstChapter\ImportExport"
	gen DomSupply= Production + Imports - Exports
	gen ImpDivSupply= Imports/DomSupply
	drop _merge
	*keep if NAICS>=3110 & NAICS<3400
	sort NAICS
    save imexprod`i'.dta, replace
 }
 
cd "K:\FirstChapter\Programs\New Final Programs"


