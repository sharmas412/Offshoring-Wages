clear
cd "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Final March Supplement\2002"
use UncleanedFinalData.dta

cd "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Final March Supplement"
merge m:m yr using GDPDeflator
drop if yr==99
drop _merge
gen NewWage = (HourlyWage)/(gdpdef/100)
gen LnWage=ln(NewWage)
cd "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Final March Supplement\FinalDatasets"
save UncleanedFinalData.dta,replace




gen Age1624=0
gen Age2539=0
gen Age4064=0
replace Age1624=1 if Age>=2 & Age<=5
replace Age2539=1 if Age>=6 & Age<=8
replace Age4064=1 if Age>=9 & Age<=14

*replace ServiceOutsourcing=ServiceOutsourcing/100 // *100 // delete this again (may need to multiply this by a 100, as done previously, look into it)
replace MatOutsourcing=MatOutsourcing/100  // *100 (may need to multiply this by a 100, as done previously, look into it and the implications for the analysis of results)
replace lagMatOut=lagMatOut/100
*replace lagSerOut=lagSerOut/100

*====Generate Interaction terms between offshoring and skill level========

gen lagMatOutHighSkillOne=lagMatOut *HighSkillOccOne
gen lagMatOutMedSkillOne= lagMatOut * MedSkillOccOne
gen lagMatOutLowSkillOne = lagMatOut * LowSkillOccOne

gen lagSerOutHighSkillOne = lagSerOut * HighSkillOccOne
gen lagSerOutMedSkillOne = lagSerOut * MedSkillOccOne
gen lagSerOutLowSkillOne = lagSerOut * LowSkillOccOne


*Interaction terms for robustness checks:
gen lagMatOutHighSkillTwo=lagMatOut *HighSkillOccTwo
gen lagMatOutMedSkillTwo= lagMatOut * MedSkillOccTwo
gen lagMatOutLowSkillTwo = lagMatOut * LowSkillOccTwo

gen lagSerOutHighSkillTwo = lagSerOut * HighSkillOccTwo
gen lagSerOutMedSkillTwo = lagSerOut * MedSkillOccTwo
gen lagSerOutLowSkillTwo = lagSerOut * LowSkillOccTwo


gen lagMatOutHighSkillThree=lagMatOut *HighSkillOccThree
gen lagMatOutMedSkillThree= lagMatOut * MedSkillOccThree
gen lagMatOutLowSkillThree = lagMatOut * LowSkillOccThree

gen lagSerOutHighSkillThree = lagSerOut * HighSkillOccThree
gen lagSerOutMedSkillThree = lagSerOut * MedSkillOccThree
gen lagSerOutLowSkillThree = lagSerOut * LowSkillOccThree

order  Age A_CIVLF Education Industry Occupation Automation notFaceToFace notOnSite notDecisionMaking HighSkillOccOne MedSkillOccOne LowSkillOccOne HighSkillOccTwo MedSkillOccTwo LowSkillOccTwo HighSkillOccThree MedSkillOccThree LowSkillOccThree HighSkillOccFour MedSkillOccFour LowSkillOccFour Marital Male Union HoursPerWeek FullTime Citizen WeeksPerYear WageAndSalary Race State yr 

save CleanedFinalData.dta,replace
*==============================================================================
*	Further interaction terms
*================================================================
