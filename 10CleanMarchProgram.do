* In this program:
* NOT i) Merge Individual's occupation with their skill
* NOT ii) Merge Individual's industry with the relevant industry data (material outsourcing, service outsourcing, RnD and TFP)
* iii) clean the individual data

*===========================================================
* Merge Occupation, Skills with the March Supplement file
*===========================================================
 /*
clear
cd "K:\FirstChapter\Final March Supplement\2002"

forvalues i=96/102{
use `i'March.dta
drop if A_OCC==0
merge m:m A_OCC using "K:\FirstChapter\OccupationONET\Stata file\Census1990OccupationSkillRobust.dta"
keep if _merge==3
drop _merge
save `i'NewMarch.dta,replace
}


clear
cd "K:\FirstChapter\Final March Supplement\2002"
forvalues i=103/109{
use `i'March.dta
drop if OCCUP==0
merge m:m OCCUP using "K:\FirstChapter\OccupationONET\Stata file\Census2002OccupationSkillRobust.dta"
keep if _merge==3
drop _merge
save `i'NewMarch.dta,replace
}

*/


*============================================================
* Refining March CPS data, cleaning up
*=============================================================

clear

cd "K:\FirstChapter\Final March Supplement\2002"

forvalues i=96/102 ///
{
	use `i'March.dta
	gen yr= `i'
	drop if AGE1<2 | AGE1>14
	keep if A_CIVLF==1
	recode A_MARITL (2/6=1) (7=0) // If ever married =1, Never Married = 0
	recode A_SEX (2=0) // Female = 0, Male ==1 
	recode A_UNMEM (2=0) // Union Member =1, Non-Union Member =0
	drop if HRSWK < 1 // Worked at least for a week the previous year
	recode HRCHECK (1=0) (2=1) // Full-Time=1 , Part Time = 0
	recode PMCITSHP (2/3=1) (4/5=0) // US born =1, Foreign Born=0
	recode A_RACE (1=1) (2/4=0) // 1= White 0=Black and other races
	rename (A_IND A_RACE A_UNMEM A_SEX A_MARITL A_HGA HRCHECK PMCITSHP GMSTCEN AGE1 A_OCC) (Industry Race Union Male Marital Education FullTime Citizen State Age Occupation)

/* Recoding state to match the 2003-2010 CPS State FIPS Code*/
	recode State (11=23) (12=33) (13=50) (14=25)(15=44) (16=9)(21=36) (22=34)(23=42) (31=39)(32=18) (33=19)(34=26) (35=55)(41=27) (42=19)(43=29) (44=38)(45=46) (46=31)(47=20) (51=10)(52=24) (53=11)(54=51) (55=54)(56=37) (57=45)(58=13) (59=12)(61=21) (62=47)(63=1) (64=28)(71=2) (72=22)(73=40) (74=48)(81=30) (82=16)(83=56) (84=8) (85=35) (86=4)(87=49) (88=32)(91=53) (92=41)(93=6) (94=2)(95=15) 
*===========
	drop OCCURNUM H_IDNUM PHF_SEQ YYYYMM  INDUSTRY PEARNVAL PTOTVAL MIG_ST A_HRLYWK A_HRSPAY
	drop if WSAL_VAL<10 // Drop if Total Earnings in a year is less than 10 dollars

	gen HourlyWage= (WSAL_VAL/(HRSWK*WKSWORK))
	//gen HourlyIncome=(PTOTVAL/(HRSWK*WKSWORK))
	//gen HourlyEarnings= (PEARNVAL/(HRSWK*WKSWORK))
	*drop if HourlyWage>1500 // Drop if HourlyWage>1500
	rename (HRSWK WKSWORK WSAL_VAL) (HoursPerWeek WeeksPerYear WageAndSalary)

	*gen LogHourlyWage=ln(HourlyWage)

	save `i'CleanMarch.dta,replace
}


clear
forvalues i=103/109 ///
{
	use `i'March.dta
	gen yr= `i'
	drop if AGE1<2 | AGE1>14
	keep if A_CIVLF==1
	*recode PRDTRACE (1=0) (2=1) // Black =0, all other races =1
	replace PRDTRACE =0 if (PRDTRACE>=2) // 1=White, 0= All other races
	recode A_MARITL (2/6=1) (7=0) // If I ever married =1, Never Married = 0
	recode A_SEX (2=0) // Female = 0, Male ==1 
	recode A_UNMEM (2=0) // Union Member =1, Non-Union Member =0
	drop if HRSWK < 1 // Worked at least for a week the previous year
	recode HRCHECK (1=0) (2=1) // Full-Time=1 , Part Time = 0
	recode PMCITSHP (2/3=1) (4/5=0) // US born =1, Foreign Born=0
	drop OCCURNUM  PHF_SEQ YYYYMM MIG_ST AGI PEARNVAL PTOTVAL A_USLHRS A_HRS1 PMHRUSLT PEIOIND A_AGE A_GRSWK A_HRLYWK A_HRSPAY
	rename (INDUSTRY  A_UNMEM A_SEX A_MARITL A_HGA HRCHECK PMCITSHP GESTFIPS AGE1 PRDTRACE OCCUP) (Industry Union Male Marital Education FullTime Citizen State Age Race Occupation)

	drop if WSAL_VAL<10 // Drop if Total Earnings in a year is less than 10 dollars
	gen HourlyWage= (WSAL_VAL/(HRSWK*WKSWORK))
	*drop if HourlyWage>1500
	*gen HourlyIncome=(PTOTVAL/(HRSWK*WKSWORK))
	*gen HourlyEarnings= (PEARNVAL/(HRSWK*WKSWORK))
	rename (HRSWK WKSWORK WSAL_VAL) (HoursPerWeek WeeksPerYear WageAndSalary)

	*gen LogHourlyWage = ln(HourlyWage)

	*order Age A_CIVLF Education Industry Marital Sex Union HoursPerWeek FullTime Citizen WeeksPerYear WageAndSalary Race State yr HourlyWage LogHourlyWage
	*keep Age A_CIVLF Education Industry Marital Sex Union HoursPerWeek FullTime Citizen WeeksPerYear WageAndSalary Race State yr HourlyWage LogHourlyWage
	save `i'CleanMarch.dta,replace
}


cd "K:\FirstChapter\Programs\New Final Programs"
 
