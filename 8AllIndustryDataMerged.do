*============
* Material offshoring
*=======================
clear
cd "K:\FirstChapter\ImportExport"
use MaterialOutsourcing99.dta
forvalues i=100/109 ///
{
	append using MaterialOutsourcing`i'
}
cd "K:\FirstChapter\IndustryData"
save IndustryMaterialOutsourcing.dta, replace


*====================
* Service Offshoring
*=========================
clear
cd "K:\FirstChapter\ImportExport"
use ServiceOutsourcing99.dta
forvalues i=100/109 ///
{
	append using ServiceOutsourcing`i'
}
cd "K:\FirstChapter\IndustryData"
save IndustryServiceOutsourcing.dta, replace

*========================================
* Merge Service and Material Offshoring
*========================================
clear
cd "K:\FirstChapter\IndustryData"
use IndustryServiceOutsourcing.dta
merge m:m NAICS year using IndustryMaterialOutsourcing.dta
keep if _merge==3
drop _merge


sort NAICS 
by NAICS: gen lagMatOut=MatOutsourcing[_n-1]
by NAICS: gen lagSerOut=ServiceOutsourcing[_n-1]
save IndsutryMatServOutsourcing.dta,replace


*===============================================
*Merge with Industry TFP and R&D Data
*================================================
clear
cd "K:\FirstChapter\IndustryData"
use IndsutryMatServOutsourcing.dta
merge m:m NAICS using "K:\FirstChapter\Productivity Database\IndustryRnDTFP.dta"
keep if _merge==3
drop _merge
order NAICS year MatOutsourcing lagMatOut ServiceOutsourcing lagSerOut TFP lagTFP RnD lagRnD
save AllIndustryData.dta,replace


*===============YEARLY FILES FOR ALL INDUSTRY DATA=======================
forvalues i=99/109 ///
{
	use AllIndustryData.dta
	keep if year==`i'
	save AllIndustry`i'.dta,replace
}

cd "K:\FirstChapter\Programs\New Final Programs"


