*===================================================================================================
*	MERGE IMPORT,EXPORT AND PRODUCTION WITH THE INPUT-OUTPUT (TOTAL INTERMEDIATE OUTPUT) FILES
*====================================================================================================
clear
forvalues i=99/109 ///
{
	cd "K:\FirstChapter\InputOutput"
	use IOmergedNAICS`i'.dta, replace 
	sort NAICS
	cd "K:\FirstChapter\ImportExport"
	merge m:m NAICS using imexprod`i'.dta
	destring NAICS, replace
	*keep if NAICS>=3111 & NAICS<=3399
	
	*drop if sector<16
	*drop if sector>92
	drop _merge
	drop if sector>169
	save allmergedIO`i'.dta, replace
}

*=================================================================================
* GENERATE THE FIRST TWO TERMS OF OUTSOURCING 
*===================================================================================
clear
forvalues i=99/109 ///
{
	cd "K:\FirstChapter\ImportExport"
	use allmergedIO`i'.dta
		foreach var of varlist v1-v169 ///
			{
				gen FTerm`var'= `var'/TotalInput`var'
				gen AllTerm`var'= FTerm`var' * ImpDivSupply
			}

		foreach var of varlist v1-v169 ///
			{
				egen Outsourcing`var'= sum(AllTerm`var')
			}
			
save MainOutsourcing`i'.dta,replace
}

*============================================================================================
* FINALIZE MATERIAL OUTSOURCING BY INDUSTRY , YEARLY FILES
*==========================================================================================
clear
forvalues i=99/109 ///
{

	cd "K:\FirstChapter\ImportExport"
	use MainOutsourcing`i'.dta
	keep Outsourcingv1-Outsourcingv169 //OutSv2-OutSv170
	save SecondGenerateOutsourcing`i'.dta, replace

	xpose,clear
	drop v2-v169 //might be v2-v225
	rename v1 MatOutsourcing
	replace MatOutsourcing = MatOutsourcing *100
	gen sector=_n

	cd "K:\FirstChapter\ConcordanceFiles"
	merge m:m sector using concIONAICS
	drop _merge
	rename naics NAICS
	drop if NAICS=="NA"
	destring (NAICS),replace
	keep if sector>=16 & sector<=92 // Save only for manufacturing Industry
	
	cd "K:\FirstChapter\ImportExport"
	save MaterialOutsourcing`i'.dta,replace
}


*=========================================================================================
* 	DIVIDE INDUSTRY INTO HIGH MATERIAL OUTSOURCING AND LOW MATERIAL OUTSOURCING INDUSTRIES
*==============================================================================================
cd "K:\FirstChapter\ImportExport"
forvalues i=99/109 ///
{
use MaterialOutsourcing`i'.dta
gen year=`i'
egen MeanMatOut=mean(MatOutsourcing)
gen HighMatOut=0
gen LowMatOut=0
replace HighMatOut=1 if MatOutsourcing>=MeanMatOut
replace LowMatOut=1 if MatOutsourcing<MeanMatOut

save MaterialOutsourcing`i'.dta, replace
}

	
cd "K:\FirstChapter\Programs\New Final Programs"

