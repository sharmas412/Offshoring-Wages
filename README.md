# Offshoring and U.S. Wages

## Objective
This study aims to understand the effect of material and service offshoring on wages of three types of workers: high-skilled, medium-skilled and low-skilled. I create proxies for both material and service offshoring at an industry-level and merge them with individual-level worker data to study the problem.

## Codes
Note: All the codes are run in STATA

*1TotalMaterialIntermediate - 8AllIndustryDataMerged* : The following code files merges 4 different raw data files to calculate proxies                                                            for material and service offshoring at the industry-level

*9OccupationSkillCalculation* : The file calculates skill-level of workers based on the occupation they are in given their job tasks

*10CleanMarchProgram - 11AllMergeMarch* : The files computes wage variable for individuals and their demographic charaterstics

*12CleanFinalData* : This combines all the previous datasets to run models

*RegressionofNewProgramData* : Runs various linear regressions to study the effect of offshoring on wages

# Paper
*OffshoringWages* : The paper explains the findings of the study
