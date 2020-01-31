clear
cd "K:\FirstChapter\Programs\New Final Programs"


*=================================================
*	Programs to calculate Material Outsourcing
*==============================================
do 1TotalMaterialIntermediate
do 2MaterialIMExProdYearly
do 3GenerateMaterialOutsourcing

*=====================================================
*	Programs to calculate Service Outsourcing
*=====================================================
do 4TotalServiceIntermediate
do 5ServiceImExProdYearly
do 6GenerateServiceOutsourcing

*====================================================
* Programs for to capture all industry data together
*====================================================
do 7IndustryRnDTFP
do 8AllIndustryDataMerged

*====================================================
* Program to calculate Skill of Occupation based on ONET
*=====================================================
do 9OccupationSkillCalculation

*==============================================
*	Programs to calculate Individual Wages
*==============================================
do 10CleanMarchProgram
do 11AllMergeMarch
do 12CleanedAllData

