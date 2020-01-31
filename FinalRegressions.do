*===========Very First Table of regression================================================================================
qui reg LnWage lagMatOut  HighSkillOccOne MedSkillOccTwo  College SomeCollege lagTFP Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\firstreg.csv", drop ( Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label auto(3) title(OLS Estimates of Offshoring on Individual wages) replace nonote addnote(All regression has demographic control)

qui reg LnWage lagSerOut  HighSkillOccOne MedSkillOccTwo  College SomeCollege lagTFP Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\firstreg.csv", drop ( Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label append

qui reg LnWage lagMatOut lagSerOut HighSkillOccOne MedSkillOccTwo  College SomeCollege lagTFP Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\firstreg.csv", drop ( Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) sortvar(lagMatOut lagSerOut) label auto(3) append 





*========Skill REgression for Different Skills Interactions=============================================================================================================
qui reg LnWage lagMatOut lagSerOut  HighSkillOccTwo MedSkillOccTwo lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OccSkillreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  label  title(Wage based on Occupation)replace nonote addnote(All regression has demographic control and time and industry fixed effect)

qui reg LnWage lagMatOut lagSerOut  HighSkillOccTwo MedSkillOccTwo lagSerOutHighSkillTwo lagSerOutMedSkillTwo lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OccSkillreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label  append

qui reg LnWage lagMatOut lagSerOut  HighSkillOccTwo MedSkillOccTwo lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagSerOutHighSkillTwo lagSerOutMedSkillTwo lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OccSkillreg.csv", drop (College SomeCollege  Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  sortvar (lagMatOut lagSerOut HighSkillOccTwo MedSkillOccTwo lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagSerOutHighSkillTwo lagSerOutMedSkillTwo) label  append



*===================================================================================================================================
*	Regression with task occupation index, seperately and together
*===================================================================================================================================
qui reg LnWage lagMatOut lagSerOut AutomationOne lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  label title(OLS Estimates on Occupational Measure of Offshorability) replace nonotes addnote(Demographic controls)

qui reg LnWage lagMatOut lagSerOut  notDecisionMakingOne lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  label  append

qui reg LnWage lagMatOut lagSerOut  notFaceToFaceOne lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label  append

qui reg LnWage lagMatOut lagSerOut AutomationOne notDecisionMakingOne notFaceToFaceOne lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) sortvar(lagMatOut lagSerOut AutomationOne notDecisionMakingOne notFaceToFaceOne) label  append




*===========================================================REgression of task occupation index with interaction terms=======
qui reg LnWage lagMatOut lagSerOut taskOffshorabilityOne lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OffshorabilityInteraction.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label  title(OLS Estimates on Offshoring and Offshorability Interaction) nonotes addnote(Demographic controls) replace 

qui reg LnWage lagMatOut lagSerOut  taskOffshorabilityOne lagMatOutOffshorability lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OffshorabilityInteraction.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label  append

qui reg LnWage lagMatOut lagSerOut  taskOffshorabilityOne lagSerOutOffshorability lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OffshorabilityInteraction.csv", drop (College SomeCollege  Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label  append

qui reg LnWage lagMatOut lagSerOut  taskOffshorabilityOne lagMatOutOffshorability lagSerOutOffshorability lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\OffshorabilityInteraction.csv", drop (College SomeCollege  Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)sortvar(lagMatOut lagSerOut taskOffshorabilityOne lagMatOutOffshorability lagSerOutOffshorability) label  append

*=================================================================
* Regression for different time period on occupational skill
*===================================================================
qui reg LnWage lagMatOut lagSerOut  lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS if yr<105,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccSkillreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  label  title(Wage based on Occupation)replace nonote addnote(All regression has demographic control and time and industry fixed effect)

qui reg LnWage lagMatOut lagSerOut  lagSerOutHighSkillTwo lagSerOutMedSkillTwo lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS if yr<105,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccSkillreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label  append

qui reg LnWage lagMatOut lagSerOut  lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagSerOutHighSkillTwo lagSerOutMedSkillTwo lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS if yr<105,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccSkillreg.csv", drop (College SomeCollege  Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  sortvar (lagMatOut lagSerOut lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagSerOutHighSkillTwo lagSerOutMedSkillTwo) label  append

qui reg LnWage lagMatOut lagSerOut  lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS if yr>104,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccSkillreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  label append

qui reg LnWage lagMatOut lagSerOut  lagSerOutHighSkillTwo lagSerOutMedSkillTwo lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS if yr>104,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccSkillreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label  append

qui reg LnWage lagMatOut lagSerOut  lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagSerOutHighSkillTwo lagSerOutMedSkillTwo lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS if yr>104,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccSkillreg.csv", drop (College SomeCollege  Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  sortvar (lagMatOut lagSerOut lagMatOutHighSkillTwo lagMatOutMedSkillTwo lagSerOutHighSkillTwo lagSerOutMedSkillTwo) label  append

*=======================================
* Regression of different time period on occupational task
*=================================================

qui reg LnWage lagMatOut lagSerOut lagTFP Automation College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State if yr >104,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) ctitle("All") label title(Based on different offshorability measures) replace nonotes

qui reg LnWage lagMatOut lagSerOut lagTFP notDecisionMaking College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State if yr >104,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) ctitle("All") label  append

qui reg LnWage lagMatOut lagSerOut lagTFP notFaceToFace College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State if yr >104,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) ctitle("All") label  append

qui reg LnWage lagMatOut lagSerOut lagTFP taskOffshorabilityOne College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State if yr >104,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) ctitle("All") label  append

qui reg LnWage lagMatOut lagSerOut lagTFP taskOffshorabilityOne lagMatOutOffshorability lagSerOutOffshorability College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State if yr >104,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\TimeOccTaskreg.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) ctitle("All") label  append




*======================================================================
*				ROBUSTNESS CHECK
*======================================================================


*===============1. DIFFERENT SKILL CALCULATION, OCCONE==============================================================================
qui reg LnWage lagMatOut lagSerOut  HighSkillOccOne MedSkillOccOne lagMatOutHighSkillOne lagMatOutMedSkillOne lagTFP College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\RobustnessSkillOne.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  label  title(Robustness check using different measure for Skill Index)replace nonote addnote(All regression has demographic control and time and industry fixed effect)

qui reg LnWage lagMatOut lagSerOut  HighSkillOccOne MedSkillOccOne lagSerOutHighSkillOne lagSerOutMedSkillOne lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\RobustnessSkillOne.csv", drop ( College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag) label  append

qui reg LnWage lagMatOut lagSerOut  HighSkillOccOne MedSkillOccOne lagMatOutHighSkillOne lagMatOutMedSkillOne lagSerOutHighSkillOne lagSerOutMedSkillOne lagTFP  College SomeCollege Age1624 Age2539 Marital Male Union FullTime Citizen Race  i.yr i.State i.NAICS,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Dissertation\FirstChapter\Paper\RobustnessSkillOne.csv", drop (College SomeCollege  Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State) tex(frag)  sortvar (lagMatOut lagSerOut HighSkillOccOne MedSkillOccOne lagMatOutHighSkillOne lagMatOutMedSkillOne lagSerOutHighSkillOne lagSerOutMedSkillOne) label  append


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




*========================================================================================
* Regression by defining industries as high/low material offshoring intensity, in regards to skill level
*===========================================================================================
qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccOne MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if HighServiceOutsourcing==1,  robust
outreg2 using "K:\FirstChapter\Paper\ServiceIntensity.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccOne MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if LowServiceOutsourcing==1,  robust
outreg2 using "K:\FirstChapter\Paper\ServiceIntensity.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append

*========================================================================================
* Regression by defining industries as high/low service offshoring intensity, in regards to skill level
*======================================================================================================
qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccOne MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if HighMatOut==1,  robust
outreg2 using "K:\FirstChapter\Paper\MaterialIntensity.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  replace nonotes

qui reg LnWage lagMatOut Age1624 Age2539 HighSkillOccOne MedSkillOccTwo  lagTFP Marital Male Union FullTime Citizen Race i.State i.yr if LowMatOut==1,  robust
outreg2 using "K:\FirstChapter\Paper\MaterialIntensity.csv", drop (Age1624 Age2539 Marital Male Sex Union FullTime Citizen Race i.State i.yr) tex(frag) ctitle("All") addtext("Year Dummy", Yes, "State Dummy", Yes)label  append


*==========================================================================================================
* Appendix regressions
*=================================================================================================

*===========Very First Table of regressions appendix================================================================================
qui reg LnWage lagMatOut  HighSkillOccOne MedSkillOccTwo  College SomeCollege lagTFP Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Defense\FirstChapter\Paper.csv", drop (i.NAICS i.yr i.State) tex(frag) label auto(3) title(OLS Estimates of Offshoring on Individual wages) replace nonote addnote(All regression has demographic control)

qui reg LnWage lagSerOut  HighSkillOccOne MedSkillOccTwo  College SomeCollege lagTFP Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Defense\FirstChapter\Paperappendixfirstreg.csv", drop ( i.NAICS i.yr i.State) tex(frag) label append

qui reg LnWage lagMatOut lagSerOut HighSkillOccOne MedSkillOccTwo  College SomeCollege lagTFP Age1624 Age2539 Marital Male Union FullTime Citizen Race i.NAICS i.yr i.State,  robust
outreg2 using "C:\Users\Sandeep\Desktop\Defense\FirstChapter\Paper.csv", drop ( i.NAICS i.yr i.State) tex(frag) sortvar(lagMatOut lagSerOut) label auto(3) append 

