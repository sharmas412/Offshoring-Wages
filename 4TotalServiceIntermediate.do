*====================================================================================
* Program to find total intermediate service inputs in the manufacturing industry
*=====================================================================================

clear
cd "K:\FirstChapter\InputOutput\NOMINAL_USE"
 
 forvalues i=99/110 ///
 {
	clear
	cd "K:\FirstChapter\InputOutput\NOMINAL_USE"
	insheet using use`i'.csv
	
	rename v# v#, renumber //Renumbering so that sector 1 is v1 as opposed to v2
	drop v170-v196 // Dropping govt and special industries and final demand
	*drop if sector>=7 & sector<=14
	*drop if sector ==93 | sector==94
	drop if sector<16
	drop if sector>92 & sector<104
	drop if sector>114 & sector <120
	drop if sector>129
	
foreach var of varlist v1-v169 ///
{
	egen TotalServiceInput`var'=sum(`var')
}

	keep sector TotalServiceInputv1-TotalServiceInputv169
	
	cd "K:\FirstChapter\InputOutput"
	save servicenomuse`i'.dta,replace
}
 
 
 forvalues i=99/110 ///
{
	clear
	cd "K:\FirstChapter\InputOutput\NOMINAL_USE"
	insheet using use`i'.csv
	cd "K:\FirstChapter\InputOutput"
	merge m:m sector using servicenomuse`i'.dta
	drop if sector>128
	drop if sector<104
	drop if sector>114 & sector<120
	rename v# v#, renumber //Renumbering so that sector 1 is v1 as opposed to v2
	drop v170-v196 // Dropping govt and special industries and final demand
	*drop if sector>92 // MIght have to comment this line
	*drop if sector<16 //MIght have to comment this lined
	*drop v171-v197
	save servicenomuse`i'.dta,replace
}
 
 
 
forvalues i=99/110 ///
{
	use servicenomuse`i'.dta

foreach var of varlist v1-v169 ///
{

	egen Telecom`var'=sum(`var') if sector>=104 & sector<=109
	egen Finance`var'=sum(`var') if sector==110 | sector==111 | sector==114
	egen Insurance`var'=sum(`var') if sector==112 | sector==113
	egen Business`var'=sum (`var') if sector>=120 & sector<=128
}

foreach var of varlist v1-v169 ///
{
	egen input`var'=rowmax(Telecom`var' Finance`var' Insurance`var' Business`var')
}

	keep if sector==104 | sector==110 | sector==112 | sector==120


foreach var of varlist v1-v169 ///
{
	gen  Fterm`var'= input`var'/TotalServiceInput`var'
}

	save serviceTotalInputs`i'.dta,replace
}




/*
keep sector Ftermv1-Ftermv169 
xpose, clear
rename v1 Telecom
rename v2 Finance
rename v3 Insurance
rename v4 Business
drop in 1
gen sector=_n
save servicenon.dta,replace

*/

cd "K:\FirstChapter\Programs\New Final Programs"




