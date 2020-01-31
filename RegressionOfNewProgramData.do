clear
cd "C:\Users\Sandeep\Documents\Dissertation\FirstChapter\Programs\New Final Programs"
use CleanedFinalData.dta

label variable HighSkillOccTwo "High Skill Occupation"
label variable MedSkillOccTwo "Med Skill Occupation"
label variable LowSkillOccTwo "Low Skill Occupation"

label variable Marital "Married"
label variable Race "White"
label variable Citizen "Citizen"
label variable Male "Male"
label variable Union "Union"
label variable FullTime "Full-Time"

label variable MatOutsourcing "Mat. Offshoring"
label variable ServiceOutsourcing "Ser. Offshoring"
label variable lagMatOut "Lag Mat. Offshoring"
label variable lagSerOut "Lag Ser. Offshoring"


label variable lagMatOutHighSkillTwo "Lag Mat. Off * High Skill"
label variable lagMatOutMedSkillTwo "Lag Mat. Off * Med. Skill"
label variable lagMatOutLowSkillTwo "Lag Mat. Off * Low Skill"

label variable lagSerOutHighSkillTwo "lagSerOut * High Skill"
label variable lagSerOutMedSkillTwo "lagSerOut * Med. Skill"
label variable lagSerOutLowSkillTwo "lagSerOut * Low Skill"

*======================= Generating and labeling for task occupation================

gen lagMatOutAutomation=lagMatOut*AutomationOne
gen lagSerOutAutomation=lagSerOut*AutomationOne
gen lagMatOutnotFaceToFace=lagMatOut*notFaceToFaceOne
gen lagSerOutnotFaceToFace=lagSerOut*notFaceToFaceOne
gen lagMatOutnotDecisionMaking=lagMatOut * notDecisionMakingOne
gen lagSerOutnotDecisionMaking=lagSerOut * notDecisionMakingOne
gen lagMatOutnotOnSite=lagMatOut*notOnSiteOne
gen lagSerOutnotOnSite=lagSerOut*notOnSiteOne

label variable lagMatOutAutomation "Lag Mat Off * Automation"
label variable lagMatOutnotFaceToFace "Lag Mat Off * notFaceToFace"
label variable lagMatOutnotOnSite "Lag Mat Off * notOnSite"
label variable lagMatOutnotDecisionMaking "Lag Mat. Off * notDecisionMaking"

label variable lagSerOutAutomation "Lag Ser Off * Automation"
label variable lagSerOutnotFaceToFace "Lag Ser Off * notFaceToFace"
label variable lagSerOutnotOnSite "Lag Ser Off * notOnSite"
label variable lagSerOutnotDecisionMaking "Lag Ser Off * notDecisionMaking"

gen lagMatOutOffshorability=lagMatOut * taskOffshorabilityOne
gen lagSerOutOffshorability=lagSerOut * taskOffshorabilityOne

label variable lagMatOutOffshorability "Lag Mat. Off. * Offshorability"
label variable lagSerOutOffshorability "Lag Ser. Off. * Offshorability"
label variable taskOffshorabilityOne "Offshorability"
label variable Automation "Automation"


*========================Generating skills based on Education=======================
*Low-skill: high school or less; Med-Skill: some college and associate degree; High-Skill: college or more

gen College=0
gen SomeCollege=0
gen HighSchool=0

replace College=1 if Education>=43
replace SomeCollege=1 if Education==40 | Education==41 | Education==42
replace HighSchool=1 if Education<=39

*===================================================================================
* Summary Table
*=====================================================================================
sutex LnWage lagMatOut lagSerOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  College SomeCollege lagTFP Marital Male Union FullTime Citizen Race, lab  file("C:\Users\ssharma03\Desktop\Dissertation\FirstChapter\Paper\summary.tex") replace










/*
*===========Very First Table of regression================================================================================
qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race,  robust
outreg2 using "K:\FirstChapter\Paper\firstreg.csv", drop ( Age1624 Age2539 Marital Male Union FullTime Citizen Race) tex(frag) addtext("Year Dummy", No,"State Dummy", No) wide label auto(3) replace nonotes // addnote("Note: Robust SE in parenthesis, *** significant at 1%, ** significant at 5%, * at 10%. Demographic control variables are not shown" )

qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\firstreg.csv", drop (Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) addtext("Year Dummy", Yes, "State Dummy", Yes)label auto(3) append 

qui reg LnWage lagSerOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race,  robust
outreg2 using "K:\FirstChapter\Paper\firstreg.csv", drop ( Age1624 Age2539 Marital Male Union FullTime Citizen Race)tex(frag) addtext("Year Dummy", No, "State Dummy", No)label  append 

qui reg LnWage lagSerOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr i.NAICS,  robust
outreg2 using "K:\FirstChapter\Paper\firstreg.csv", drop (Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) addtext("Year Dummy", Yes, "State Dummy", Yes)label auto(3)  append 

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race, robust 
outreg2 using "K:\FirstChapter\Paper\firstreg.csv",drop ( Age1624 Age2539 Marital Male Union FullTime Citizen Race) tex(frag) addtext("Year Dummy", No, "State Dummy", No)label  append 

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr, robust
outreg2 using "K:\FirstChapter\Paper\firstreg.csv", drop (Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr) tex(frag) addtext("Year Dummy", Yes, "State Dummy", Yes)label auto(3) append sortvar(lagMatOut lagSerOut)


*========Skill REgression for Different Skills=============================================================================================================
qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 lagTFP Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\OccSkillreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if HighSkillOccTwo==1,  robust
outreg2 using "K:\FirstChapter\Paper\OccSkillreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle ("High-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if MedSkillOccTwo==1,  robust
outreg2 using "K:\FirstChapter\Paper\OccSkillreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle ("Medium-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if LowSkillOccTwo==1,  robust
outreg2 using "K:\FirstChapter\Paper\OccSkillreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle ("Low-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append


*===================================================================================================================================
*	Regression with task occupation index, seperately and together
*===================================================================================================================================
qui reg LnWage lagMatOut lagSerOut lagTFP Age1624 Age2539 Automation Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\OccTaskreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut lagSerOut lagTFP Age1624 Age2539 notDecisionMaking Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\OccTaskreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut lagTFP Age1624 Age2539 notFaceToFace Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\OccTaskreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut lagTFP Age1624 Age2539 Automation notDecisionMaking notFaceToFace Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\OccTaskreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append


*=================================================================
* Regression with task offshorability index
*==================================================================
qui reg LnWage lagMatOut lagSerOut lagTFP Age1624 Age2539 taskOffshorabilityOne Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\Offshorabilityreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut lagSerOut lagTFP Age1624 Age2539 taskOffshorabilityOne lagMatOutOffshorability lagSerOutOffshorability Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\Offshorabilityreg.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append



*========================================================================================
* Regression by defining industries as high/low material offshoring intensity, in regards to skill level
*===========================================================================================
qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if HighServiceOutsourcing==1,  robust
outreg2 using "K:\FirstChapter\Paper\ServiceIntensity.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if LowServiceOutsourcing==1,  robust
outreg2 using "K:\FirstChapter\Paper\ServiceIntensity.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

*========================================================================================
* Regression by defining industries as high/low service offshoring intensity, in regards to skill level
*======================================================================================================
qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if HighMatOut==1,  robust
outreg2 using "K:\FirstChapter\Paper\MaterialIntensity.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccTwo MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if LowMatOut==1,  robust
outreg2 using "K:\FirstChapter\Paper\MaterialIntensity.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append



*======================================================================
*				ROBUSTNESS CHECK
*======================================================================


*===============1. DIFFERENT SKILL CALCULATION, OCCTWO==============================================================================
qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillTwo.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if HighSkillOccTwo==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillTwo.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) ctitle ("High-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if MedSkillOccTwo==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillTwo.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) ctitle ("Medium-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if LowSkillOccTwo==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillTwo.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) ctitle ("Low-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append


*==================2. Different Skill Calculation, OCCTHREE==============

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillThree.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if HighSkillOccThree==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillThree.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle ("High-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if MedSkillOccThree==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillThree.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle ("Medium-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if LowSkillOccThree==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillThree.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle ("Low-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append


*===============3. Different percentile skill calculation, OCCFOUR==========
qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillFour.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if HighSkillOccFour==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillFour.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) ctitle ("High-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if MedSkillOccFour==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillFour.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) ctitle ("Medium-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

qui reg LnWage lagMatOut lagSerOut Age1624 Age2539 Marital Male Union FullTime Citizen Race i.State i.yr if LowSkillOccFour==1,  robust
outreg2 using "K:\FirstChapter\Paper\RobustnessSkillFour.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr i.NAICS) tex(frag) ctitle ("Low-Skill") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append



