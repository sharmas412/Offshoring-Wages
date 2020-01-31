* In this program :1) Merge March data with Occupation skill data,  2) Merge the files in (1) with Industry data

*===================================================
* Merge Cleaned up March file with Occupation Data
*====================================================

clear
cd "K:\FirstChapter\Final March Supplement\2002"

forvalues i=96/102 ///
{
use `i'CleanMarch.dta
drop if Occupation==0
merge m:m Occupation using "K:\FirstChapter\OccupationONET\Stata file\Census1990OccupationSkillRobust.dta"
keep if _merge==3
drop _merge
save `i'OccupationMarch.dta,replace
}


clear
cd "K:\FirstChapter\Final March Supplement\2002"
forvalues i=103/109 ///
{
use `i'CleanMarch.dta
drop if Occupation==0
merge m:m Occupation using "K:\FirstChapter\OccupationONET\Stata file\Census2002OccupationSkillRobust.dta"
keep if _merge==3
drop _merge
save `i'OccupationMarch.dta,replace
}

*==============================================
* Merge the previous file in concordance with NAICS
*==============================================
clear

forvalues i=96/102{
	cd "K:\FirstChapter\Final March Supplement\2002"

	use `i'OccupationMarch.dta
	cd "K:\FirstChapter\ConcordanceFiles"
	merge m:m Industry using 90censusTO2007NAICS
	drop _merge
	cd "K:\FirstChapter\Final March Supplement\2002"
    rename NAICS07 NAICS
	*drop if HourlyWage<0.5 // Cut off point?
	*drop if HourlyWage>100 // cut off point?
	*keep if 3100<=NAICS & NAICS<=3400
	save IndustryMergedMarch`i'.dta, replace
}

forvalues i=103/109{
	cd "K:\FirstChapter\Final March Supplement\2002"

	use `i'OccupationMarch.dta
	cd "K:\FirstChapter\ConcordanceFiles"
	merge m:m Industry using 02CensusTO2007NAICS
	drop _merge
	cd "K:\FirstChapter\Final March Supplement\2002"
    rename NAICS07 NAICS
	*drop if HourlyWage<0.5 // cut off point?
	*drop if HourlyWage>100 // Cut off point?
	*keep if 3100<=NAICS & NAICS<=3400
	save IndustryMergedMarch`i'.dta, replace
}


*====================================================================MAIN ONE/FINAL MERGE=======================================
clear

forvalues i=100/109 /// Starting from 100 because 99 doesn't have the lag values of Offshoring and TFP
{
	cd "K:\FirstChapter\Final March Supplement\2002"
	use IndustryMergedMarch`i'.dta
	cd "K:\FirstChapter\IndustryData"
	merge m:m NAICS using AllIndustry`i'.dta
	keep if _merge==3
	drop _merge
	cd "K:\FirstChapter\Final March Supplement\2002"
	save AllMergedMarch`i'.dta,replace
}

	



*=============================================================================
* Append all years into one large pooled cross sectional file from 1999-2009
*============================================================================
clear
cd "K:\FirstChapter\Final March Supplement\2002"
use AllMergedMarch100.dta
forvalues i=101/109 ///
{
	append using AllMergedMarch`i'	
}
save UncleanedFinalData.dta,replace

cd "K:\FirstChapter\Programs\New Final Programs"
