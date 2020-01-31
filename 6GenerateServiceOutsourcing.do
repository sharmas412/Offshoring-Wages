clear
 
cd "K:\FirstChapter\InputOutput"

forvalues i=99/110 ///
{
	use serviceTotalInputs`i'.dta
	cd "K:\FirstChapter\InputOutput"
	drop _merge
	merge m:m sector using ServiceImportShare`i'.dta
	save serviceGenerateOutsourcing`i'.dta,replace
}


forvalues i=99/110 ///
{
	use serviceGenerateOutsourcing`i'.dta


	foreach var of varlist v1-v169 ///
	{
		gen AllTerm`var'= Fterm`var' * ImportShare
	}

	foreach var of varlist v1-v169 ///
	{
		egen serviceOutsourcing`var'=sum(AllTerm`var')
	}
save serviceGenerateOutsourcing`i'.dta,replace
}


*============================================================================

clear
forvalues i=99/110 ///
{
	cd "K:\FirstChapter\InputOutput"
	use serviceGenerateOutsourcing`i'.dta
	keep serviceOutsourcingv1-serviceOutsourcingv169 //OutSv2-OutSv170
	save serviceSecondGenerateOutsourcing`i'.dta, replace
	use serviceSecondGenerateOutsourcing`i'

	xpose,clear
	drop v2-v4 //might be v2-v225
	rename v1 ServiceOutsourcing
	replace ServiceOutsourcing = ServiceOutsourcing *100
	gen sector=_n

	cd "K:\FirstChapter\ConcordanceFiles"
	merge m:m sector using concIONAICS
	drop _merge
	rename naics NAICS
	drop if NAICS=="NA"
	destring (NAICS),replace
	keep if 3100<=NAICS & NAICS<=3400 // Save only for manufacturing Industry
	cd "K:\FirstChapter\ImportExport"
	drop sector
	save ServiceOutsourcing`i'.dta,replace

}

cd "K:\FirstChapter\ImportExport"
forvalues i=99/110 ///
{
	use ServiceOutsourcing`i'.dta
	gen year=`i'
	egen MeanSerOut=mean(ServiceOutsourcing)
	gen HighServiceOutsourcing=0
	gen LowServiceOutsourcing=0
	replace HighServiceOutsourcing=1 if ServiceOutsourcing>=MeanSerOut
	replace LowServiceOutsourcing=1 if ServiceOutsourcing<MeanSerOut
	save ServiceOutsourcing`i'.dta,replace
}


cd "K:\FirstChapter\Programs\New Final Programs"
