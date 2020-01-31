clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use Skills.dta


* USING 4 DIFFERENT SKILLS: READING COMPREHENSION, CRITICAL THINKING, COMPLEX PROBLEM SOLVING & JUDGMENT AND DECISION MAKING
keep if elementname=="Reading Comprehension" |elementname== "Critical Thinking" | elementname=="Complex Problem Solving" | elementname== "Judgment and Decision Making"
destring datavalue, replace

gen skillTwo=.
replace skillTwo=datavalue^(2/3) if scaleid=="IM"
replace skillTwo=datavalue^(1/3) if scaleid=="LV"
egen SkillSecond=prod(skillTwo), by( onetsoccode elementid)
egen OccSkillTwo=sum(SkillSecond), by(onetsoccode)
replace OccSkillTwo=OccSkillTwo/2
keep onetsoccode OccSkillTwo
collapse OccSkillTwo, by(onetsoccode)
rename onetsoccode ONET2010


merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus1990.dta"
keep if _merge==3
drop _merge
contract Census1990 OccSkillTwo
by Census1990: egen max=max(_freq)
by Census1990: drop if _freq!=max
drop _freq max

collapse OccSkillTwo, by(Census1990)
egen maxOccSkillTwo=max(OccSkillTwo)
replace OccSkillTwo = OccSkillTwo/maxOccSkillTwo
drop maxOccSkillTwo
sort OccSkillTwo
cd "K:\FirstChapter\OccupationONET\Stata file\OccupationSkillRank"
save OccupationSkillRank1990.dta, replace

*2000=================

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use Skills.dta


* USING 4 DIFFERENT SKILLS: READING COMPREHENSION, CRITICAL THINKING, COMPLEX PROBLEM SOLVING & JUDGMENT AND DECISION MAKING
keep if elementname=="Reading Comprehension" |elementname== "Critical Thinking" | elementname=="Complex Problem Solving" | elementname== "Judgment and Decision Making"
destring datavalue, replace

gen skillTwo=.
replace skillTwo=datavalue^(2/3) if scaleid=="IM"
replace skillTwo=datavalue^(1/3) if scaleid=="LV"
egen SkillSecond=prod(skillTwo), by( onetsoccode elementid)
egen OccSkillTwo=sum(SkillSecond), by(onetsoccode)
replace OccSkillTwo=OccSkillTwo/2
keep onetsoccode OccSkillTwo
collapse OccSkillTwo, by(onetsoccode)
rename onetsoccode ONET2010

merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus2002.dta"
keep if _merge==3
drop _merge
contract Census2002 OccSkillTwo
by Census2002: egen max=max(_freq)
by Census2002: drop if _freq!=max
drop _freq max

collapse OccSkillTwo, by(Census2002)
egen maxOccSkillTwo=max(OccSkillTwo)
replace OccSkillTwo = OccSkillTwo/maxOccSkillTwo
drop maxOccSkillTwo
sort OccSkillTwo
cd "K:\FirstChapter\OccupationONET\Stata file\OccupationSkillRank"
save OccupationSkillRank2000.dta, replace

*================================================================================================================================================================================================================================
*Task Offshorability

clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationOffshorabilityRank.dta

merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus1990.dta"
keep if _merge==3
drop _merge
contract Census1990  Automation notFaceToFace notOnSite notDecisionMaking taskOffshorability
by Census1990: egen max=max(_freq)
by Census1990: drop if _freq!=max
drop _freq max
collapse  Automation notFaceToFace notOnSite notDecisionMaking taskOffshorability, by(Census1990)
cd "K:\FirstChapter\OccupationONET\Stata file\OccupationSkillRank"
save OccupationOffshorabilityRank1990.dta,replace


*====2000====
clear
cd "K:\FirstChapter\OccupationONET\Stata file"
use OccupationOffshorabilityRank.dta

merge m:m ONET2010 using "K:\FirstChapter\ConcordanceFiles\Occupational Concordances\Occupation 1990dd concordance\ONETCensus2002.dta"
keep if _merge==3
drop _merge
contract Census2002  Automation notFaceToFace notOnSite notDecisionMaking taskOffshorability
by Census2002: egen max=max(_freq)
by Census2002: drop if _freq!=max
drop _freq max
collapse  Automation notFaceToFace notOnSite notDecisionMaking taskOffshorability, by(Census2002)
cd "K:\FirstChapter\OccupationONET\Stata file\OccupationSkillRank"
save OccupationOffshorabilityRank2000.dta,replace

