 clear

*============================================================================================================================
* Use Input-Ouput matrix, nominal use file to figure out the total intermediate input used by each manufacturing industry
* ============================================================================================================================

* Note: summing by column gives the intermediate input of the industry (represented in that column) 

note: Sum of column gives the total intermediate input by each industry 

 cd "K:\FirstChapter\InputOutput\NOMINAL_USE"
 
  forvalues i=99/110 ///
 {
	clear 
	cd "K:\FirstChapter\InputOutput\NOMINAL_USE"
	insheet using use`i'.csv
	
	rename v# v#, renumber //Renumbering so that sector 1 is v1 as opposed to v2
	drop v170-v196 // Dropping govt and special industries and final demand
	drop if sector>6 & sector<16
	drop if sector>92 & sector<104
	drop if sector>114 & sector <120
	drop if sector>129
	
foreach var of varlist v1-v169 ///
{
	egen TotalInput`var'=sum(`var') // GIVES THE TOTAL INTERMEDIATE INPUT USED BY EACH INDUSTRY
}

keep sector TotalInputv1-TotalInputv169  //Only keeping total input at the industry level; TotalInputv1 is the total input by industry/sector 1
	
	cd "K:\FirstChapter\InputOutput"
	save materialnomuse`i'.dta,replace
}
 
 
 
 *================================================================
 * Merging the total intermediate inputs at the industry level
 *================================================================
 forvalues i=99/110 ///
 {
	clear
	cd "K:\FirstChapter\InputOutput\NOMINAL_USE"
	insheet using use`i'.csv
	cd "K:\FirstChapter\InputOutput"
	merge m:m sector using materialnomuse`i'.dta
	drop _merge
	drop if sector>=170 //Dropping the Value Added row and Government Industries
	rename v# v#, renumber //Renumbering so that sector 1 is v1 as opposed to v2
	drop v170-v196 // Dropping govt and special industries and final demand
	cd "K:\FirstChapter\InputOutput"
	save nomuse`i'.dta,replace
 }
 
 
 *=====================================================
 * Merge sector with NAICS concordance
 *======================================================
 forvalues i=99/110 ///
{
	cd "K:\FirstChapter\InputOutput"
	use nomuse`i'.dta
	sort sector
	cd "K:\FirstChapter\ConcordanceFiles"
	merge m:m sector using concIONAICS
	drop _merge
	rename naics NAICS
	
	cd "K:\FirstChapter\InputOutput"
	save IOmergedNAICS`i'.dta, replace
}

cd "K:\FirstChapter\Programs\New Final Programs"



