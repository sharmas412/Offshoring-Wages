
*===========================================================================================================================================================================
* Program to calculate skill based on skill level defined in ONET; different skills have IMPORTANCE and LEVEL; use different combinations of these for robustness check & get it ready to merge with CPS files
*============================================================================================================================================================================

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use Skills.dta


* USING 4 DIFFERENT SKILLS: READING COMPREHENSION, CRITICAL THINKING, COMPLEX PROBLEM SOLVING & JUDGMENT AND DECISION MAKING
keep if elementname=="Reading Comprehension" |elementname== "Critical Thinking" | elementname=="Complex Problem Solving" | elementname== "Judgment and Decision Making"
destring datavalue, replace

*==============================================
*MAIN SKILL VARIABLE: IMPORTANCE * LEVEL
*================================================
egen skillOne= prod(datavalue), by ( onetsoccode elementid)
egen SkillFirst=mean(skillOne), by( onetsoccode elementid)
egen OccSkillOne=sum(SkillFirst), by(onetsoccode)
replace OccSkillOne=OccSkillOne/2

*===========================================================
* ROBUSTNESS CHECK SECOND SKILL: IMPORTANCE^(2/3) * LEVEL^(1/3)
*===========================================================
gen skillTwo=.
replace skillTwo=datavalue^(2/3) if scaleid=="IM"
replace skillTwo=datavalue^(1/3) if scaleid=="LV"
egen SkillSecond=prod(skillTwo), by( onetsoccode elementid)
egen OccSkillTwo=sum(SkillSecond), by(onetsoccode)
replace OccSkillTwo=OccSkillTwo/2

*===========================================================
* ROBUSTNESS CHECK THIRD SKILL: IMPORTANCE^(1/3) * LEVEL^(2/3) , DIFFERENT WEIGHTS THAN SECOND
*===========================================================
gen skillThree=.
replace skillThree=datavalue^(1/3) if scaleid=="IM"
replace skillThree=datavalue^(2/3) if scaleid=="LV"
egen SkillThird=prod(skillThree), by( onetsoccode elementid)
egen OccSkillThree=sum(SkillThird), by(onetsoccode)
replace OccSkillThree=OccSkillThree/2

*================================= ONLY KEEP THE CALCULATED SKILLS AND OCCUPATION==========================
keep onetsoccode OccSkillOne OccSkillTwo OccSkillThree
collapse OccSkillOne OccSkillTwo OccSkillThree, by(onetsoccode)

*============================================================================================
* NEED TO CLASSIFY INTO HIGH, MEDIUM AND LOW SKILL BASED ON PERCENTILE; for all 3 measures of skill
*========================================================================================


egen pc25SkillOne=pctile(OccSkillOne),p(25)
egen pc50SkillOne=pctile(OccSkillOne),p(50)
egen pc75SkillOne=pctile(OccSkillOne),p(75)

egen pc25SkillTwo=pctile(OccSkillTwo),p(25)
egen pc50SkillTwo=pctile(OccSkillTwo),p(50)
egen pc75SkillTwo=pctile(OccSkillTwo),p(75)

egen pc25SkillThree=pctile(OccSkillThree),p(25)
egen pc50SkillThree=pctile(OccSkillThree),p(50)
egen pc75SkillThree=pctile(OccSkillThree),p(75)


egen pc33SkillFour=pctile(OccSkillTwo), p(33)
egen pc66SkillFour=pctile(OccSkillTwo), p(66)


gen HighSkillOccOne=0
gen MedSkillOccOne=0
gen LowSkillOccOne=0

gen HighSkillOccTwo=0
gen MedSkillOccTwo=0
gen LowSkillOccTwo=0

gen HighSkillOccThree=0
gen MedSkillOccThree=0
gen LowSkillOccThree=0

gen HighSkillOccFour=0
gen MedSkillOccFour=0
gen LowSkillOccFour=0


replace HighSkillOccOne=1 if OccSkillOne>=pc75SkillOne
replace MedSkillOccOne=1 if OccSkillOne<pc75SkillOne & OccSkillOne>=pc25SkillOne
replace LowSkillOccOne=1 if OccSkillOne<pc25SkillOne

replace HighSkillOccTwo=1 if OccSkillTwo>=pc75SkillTwo
replace MedSkillOccTwo=1 if OccSkillTwo<pc75SkillTwo & OccSkillTwo>=pc25SkillTwo
replace LowSkillOccTwo=1 if OccSkillTwo<pc25SkillTwo

replace HighSkillOccThree=1 if OccSkillThree>=pc75SkillThree
replace MedSkillOccThree=1 if OccSkillThree<pc75SkillThree & OccSkillThree>=pc25SkillThree
replace LowSkillOccThree=1 if OccSkillThree<pc25SkillThree

replace HighSkillOccFour=1 if OccSkillTwo>pc66SkillFour
replace MedSkillOccFour=1 if OccSkillTwo<=pc66SkillFour & OccSkillTwo>pc33SkillFour
replace LowSkillOccFour=1 if OccSkillTwo<=pc33SkillFour

save AllOccupationSkill.dta,replace

keep onetsoccode HighSkillOccOne MedSkillOccOne LowSkillOccOne HighSkillOccTwo MedSkillOccTwo LowSkillOccTwo HighSkillOccThree MedSkillOccThree LowSkillOccThree HighSkillOccFour MedSkillOccFour LowSkillOccFour
rename onetsoccode ONET2010
save OccupationSkillRank.dta,replace

*===================================================================================================================================
* Now get the concordances and merge with the CPS Occupation File, 1990 census and 2000 census
*=================================================================================================
* For Census 1990, SkillOne , Skilltwo and SkillThree

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationSkillRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus1990.dta"
keep if _merge==3
drop _merge
contract Census1990 HighSkillOccOne MedSkillOccOne LowSkillOccOne // By using contract, some occupation splits into more than one occupation in census, and keeping only those with the highest frequency
by Census1990: egen max=max(_freq)
by Census1990: drop if _freq!=max
drop _freq max
rename Census1990 A_OCC
save Census1990OccupationSkillOne.dta,replace

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationSkillRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus1990.dta"
keep if _merge==3
drop _merge
contract Census1990 HighSkillOccTwo MedSkillOccTwo LowSkillOccTwo // By using contract, some occupation splits into more than one occupation in census, and keeping only those with the highest frequency
by Census1990: egen max=max(_freq)
by Census1990: drop if _freq!=max
drop _freq max
rename Census1990 A_OCC
save Census1990OccupationSkillTwo.dta,replace

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationSkillRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus1990.dta"
keep if _merge==3
drop _merge
contract Census1990 HighSkillOccThree MedSkillOccThree LowSkillOccThree // By using contract, some occupation splits into more than one occupation in census, and keeping only those with the highest frequency
by Census1990: egen max=max(_freq)
by Census1990: drop if _freq!=max
drop _freq max
rename Census1990 A_OCC
save Census1990OccupationSkillThree.dta,replace

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationSkillRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus1990.dta"
keep if _merge==3
drop _merge
contract Census1990 HighSkillOccFour MedSkillOccFour LowSkillOccFour // By using contract, some occupation splits into more than one occupation in census, and keeping only those with the highest frequency
by Census1990: egen max=max(_freq)
by Census1990: drop if _freq!=max
drop _freq max
rename Census1990 A_OCC
save Census1990OccupationSkillFour.dta,replace


clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationOffshorabilityRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus1990.dta"
keep if _merge==3
drop _merge
contract Census1990 Automation notFaceToFace notOnSite notDecisionMaking taskOffshorability notFaceToFaceOne notOnSiteOne notDecisionMakingOne AutomationOne taskOffshorabilityOne // By using contract, some occupation splits into more than one occupation in census, and keeping only those with the highest frequency
by Census1990: egen max=max(_freq)
by Census1990: drop if _freq!=max
drop _freq max
rename Census1990 A_OCC
save Census1990OccupationOffshorability.dta,replace

clear
use Census1990OccupationSkillOne.dta
merge m:m A_OCC using Census1990OccupationSkillTwo.dta
drop _merge
merge m:m A_OCC using Census1990OccupationSkillThree.dta
drop _merge
merge m:m A_OCC using Census1990OccupationSkillFour.dta
drop _merge
merge m:m A_OCC using Census1990OccupationOffshorability
drop _merge
rename A_OCC Occupation
save Census1990OccupationSkillRobust.dta, replace

* For Census 2000======================================================================================================================================================

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationSkillRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus2002.dta"
keep if _merge==3
drop _merge
contract Census2002 HighSkillOccOne MedSkillOccOne LowSkillOccOne // Contracting to keep occupation and skill with the highest frequency
by Census2002: egen max=max(_freq)
by Census2002: drop if _freq!=max
drop _freq max
destring Census2002, replace
rename Census2002 OCCUP
save Census2002OccupationSkillOne.dta,replace

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationSkillRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus2002.dta"
keep if _merge==3
drop _merge
contract Census2002 HighSkillOccTwo MedSkillOccTwo LowSkillOccTwo // Contracting to keep occupation and skill with the highest frequency
by Census2002: egen max=max(_freq)
by Census2002: drop if _freq!=max
drop _freq max
destring Census2002, replace
rename Census2002 OCCUP
save Census2002OccupationSkillTwo.dta,replace

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationSkillRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus2002.dta"
keep if _merge==3
drop _merge
contract Census2002 HighSkillOccThree MedSkillOccThree LowSkillOccThree // Contracting to keep occupation and skill with the highest frequency
by Census2002: egen max=max(_freq)
by Census2002: drop if _freq!=max
drop _freq max
destring Census2002, replace
rename Census2002 OCCUP
save Census2002OccupationSkillThree.dta,replace

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationSkillRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus2002.dta"
keep if _merge==3
drop _merge
contract Census2002 HighSkillOccFour MedSkillOccFour LowSkillOccFour // Contracting to keep occupation and skill with the highest frequency
by Census2002: egen max=max(_freq)
by Census2002: drop if _freq!=max
drop _freq max
destring Census2002, replace
rename Census2002 OCCUP
save Census2002OccupationSkillFour.dta,replace


clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationOffshorabilityRank.dta
merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus2002.dta"
keep if _merge==3
drop _merge
contract Census2002 Automation notFaceToFace notOnSite notDecisionMaking taskOffshorability notFaceToFaceOne notOnSiteOne notDecisionMakingOne AutomationOne taskOffshorabilityOne // Contracting to keep occupation and skill with the highest frequency
by Census2002: egen max=max(_freq)
by Census2002: drop if _freq!=max
drop _freq max
destring Census2002, replace
rename Census2002 OCCUP
save Census2002OccupationOffshorability.dta,replace

clear
use Census2002OccupationSkillOne.dta
merge m:m OCCUP using Census2002OccupationSkillTwo.dta
drop _merge
merge m:m OCCUP using Census2002OccupationSkillThree.dta
drop _merge
merge m:m OCCUP using Census2002OccupationSkillFour.dta
drop _merge
merge m:m OCCUP using Census2002OccupationOffshorability.dta
drop _merge
rename OCCUP Occupation
save Census2002OccupationSkillRobust.dta, replace

cd "K:\FirstChapter\Programs\New Final Programs"
