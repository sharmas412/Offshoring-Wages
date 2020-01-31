/* THINGS IN THIS PROGRAM
1) CALCULATE R&D OF INDUSTRY AND ITS LAG
2) CALCULATE TFP OF INDUSTRY AND ITS LAG
3) MERGE THEM TOGETHER
*/

*==========================================
*	FIND R&D OF INDSTRY AND ITS LAG; R&D DEFINED AS REAL PRICE OF INVESTMENT; CALCULATED AS : SEE TEMPESTI DISSERTATION
*============================================
clear
use "K:\FirstChapter\Productivity Database\naics5809.dta"
keep naics year piinv
gen newN=string(naics)
gen newNAICS=substr(newN,1,4)
drop naics newN
rename newNAICS NAICS
keep if year>1998
sort NAICS
collapse piinv, by (NAICS year)
sort year
merge m:m year using "K:\FirstChapter\Productivity Database\pce.dta"
drop _merge
gen RnD=piinv/pce 
order NAICS year
sort NAICS year
by NAICS: gen lagRnD=RnD[_n-1]
gen yr=mod(year,100)
replace yr=yr+100 if yr<10
drop year
order NAICS yr
rename yr year
cd "K:\FirstChapter\Productivity Database"
save IndustryRnD.dta, replace

*=================================================
* FIND TFP AND ITS LAG BY INDUSTRY; tfP5
*=====================================================
clear
cd "K:\FirstChapter\Productivity Database"
use naics5809.dta
gen newN=string(naics)
gen newNAICS=substr(newN,1,4)
gen yr=mod(year,100)
replace yr=yr+100 if yr<10
drop if yr<99 
collapse tfp5, by (newNAICS yr)
rename newNAICS NAICS
rename yr year
rename tfp5 TFP
sort NAICS year
by NAICS: gen lagTFP=TFP[_n-1]
save IndustryTFP.dta,replace

*===================================================
* MERGE TFP AND R&D BY INDUSTRY
*===========================================
clear
cd "K:\FirstChapter\Productivity Database"
use IndustryTFP.dta
merge m:m NAICS using IndustryRnD.dta
drop _merge
destring (NAICS),replace
save IndustryRnDTFP.dta, replace


*=========================
*	YEARLY FILES
*===========================
clear
cd "K:\FirstChapter\Productivity Database"
use IndustryRnDTFP.dta

forvalues i=90/109 ///
{
	use IndustryRnDTFP.dta
	keep if year==`i'
	destring (NAICS),replace
	save TFP`i'.dta,replace
}

cd "K:\FirstChapter\Programs\New Final Programs"
