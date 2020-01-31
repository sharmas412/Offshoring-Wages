 clear



cd "K:\First Chapter\Final March Supplement\2002"
	use AllData99.dta
forvalues i=100/109{
	append using AllData`i'
	
	
}
gen LowSkill=0
gen MedSkill=0
gen HighSkill=0
replace LowSkill =1 if Education>=31 & Education<=36
replace MedSkill=1 if Education>=37 & Education<=42
replace HighSkill=1 if Education>=43 & Education<=46    // Initial recode(31/34=0)(35/39=1) (40/46=2)

gen Age1624=0
gen Age2539=0
gen Age4064=0
replace Age1624=1 if Age>=2 & Age<=5
replace Age2539=1 if Age>=6 & Age<=8
replace Age4064=1 if Age>=9 & Age<=14

replace ServiceOutsourcing=ServiceOutsourcing *100 // delete this again
replace MatOutsourcing=MatOutsourcing*100

gen MatOutHighSkill=MatOutsourcing *HighSkill
gen MatOutMedSkill= MatOutsourcing * MedSkill
gen MatOutLowSkill = MatOutsourcing * LowSkill

gen SerOutHighSkill = ServiceOutsourcing * HighSkill
gen SerOutMedSkill = ServiceOutsourcing * MedSkill
gen SerOutLowSkill = ServiceOutsourcing * LowSkill

gen MatOutHighSkillOcc=MatOutsourcing *HighSkillOcc
gen MatOutMedSkillOcc= MatOutsourcing * MedSkillOcc
gen MatOutLowSkillOcc = MatOutsourcing * LowSkillOcc

gen SerOutHighSkillOcc = ServiceOutsourcing * HighSkillOcc
gen SerOutMedSkillOcc = ServiceOutsourcing * MedSkillOcc
gen SerOutLowSkillOcc = ServiceOutsourcing * LowSkillOcc



cd "K:\First Chapter\Final March Supplement\FinalDatasets"
save FinalData.dta, replace



cd "K:\First Chapter\Final March Supplement"
merge m:m yr using GDPDeflator
drop if HourlyWage<1 // What should be the cut off point? Or should drop wages at 20 or 50 cents?
drop if HourlyWage>100 // Cut off point?, sounds reasonable
gen NewWage = (HourlyWage)/(gdpdef/100)
gen LnWage=ln(NewWage)
cd "K:\First Chapter\Final March Supplement\FinalDatasets"
save FinalData.dta,replace


cd "K:\First Chapter\Final March Supplement\FinalDatasets"
use FinalData.dta
gen HighMatHighSkill= HighMatOut*HighSkillOcc
gen HighMatMedSkill=HighMatOut*MedSkillOcc
gen HighMatLowSkill=HighMatOut*LowSkillOcc

gen LowMatHighSkill= LowMatOut*HighSkillOcc
gen LowMatMedSkill=LowMatOut*MedSkillOcc
gen LowMatLowSkill=LowMatOut*LowSkillOcc

gen HighSerHighSkill=HighServiceOutsourcing*HighSkillOcc
gen HighSerMedSkill=HighServiceOutsourcing*MedSkillOcc
gen HighSerLowSkill=HighServiceOutsourcing*LowSkillOcc

gen LowSerHighSkill=LowServiceOutsourcing*HighSkillOcc
gen LowSerMedSkill=LowServiceOutsourcing*MedSkillOcc
gen LowSerLowSkill=LowServiceOutsourcing*LowSkillOcc

save FinalData.dta,replace



cd "K:\First Chapter\Programs"
