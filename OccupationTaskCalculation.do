
*============================
* Calculating different occupation task category
*==============================

clear
cd "K:\FirstChapter\OccupationONET\Stata file\OccupationTask"
use finalTaskCategory.dta
egen SumActivityContext=rowtotal(taskSecond OccTaskContext)
drop taskSecond OccTaskContext


#delimit ;
by ONETSOCCode:	egen FaceToFace=total(SumActivityContext) if 
				ElementName== "Face-to-Face Discussions" |
				ElementName== "Assisting and Caring for Others"|
				ElementName== "Performing for or Working Directly with the Public"|
				ElementName== "Establishing and Maintaining Interpersonal Relationships" |
				ElementName== "Coaching and Developing Others" ;


by ONETSOCCode: egen Automation=total(SumActivityContext) if
		ElementName=="Degree of Automation" |
		ElementName== "Importance of Repeating Same Tasks" | 
		ElementName=="Structured versus Unstructured Work" | 
		ElementName== "Pace Determined by Speed of Equipment" |
		ElementName== "Spend Time Making Repetitive Motions" ;
		

by ONETSOCCode: egen OnSite=total(SumActivityContext) if
		ElementName== "Inspecting Equipment, Structures, or Material" |
		ElementName== "Handling and Moving Objects" |
		ElementName== "Controlling Machines and Processes" |
		ElementName== "Operating Vehicles, Mechanized Devices, or Equipment" |
		ElementName== "Repairing and Maintaining Mechanical Equipment" | 
		ElementName== "Repairing and Maintaining Electronic Equipment" ;
		
by ONETSOCCode: egen DecisionMaking=total(SumActivityContext) if
		ElementName== "Responsibility for Outcomes and Results" |
		ElementName== "Frequency of Decision Making"|
		ElementName== "Making Decisions and Solving Problems" |
		ElementName== "Thinking Creatively" |
		ElementName== "Developing Objectives and Strategies" ;

#delimit cr

egen maxFaceToFace=max(FaceToFace)
egen maxAutomation=max(Automation)
egen maxOnSite=max(OnSite)
egen maxDecisionMaking=max(DecisionMaking)

replace FaceToFace=FaceToFace/maxFaceToFace
replace Automation=Automation/maxAutomation
replace OnSite=OnSite/maxOnSite
replace DecisionMaking=DecisionMaking/maxDecisionMaking

drop maxFaceToFace maxAutomation maxOnSite maxDecisionMaking 

/*egen meanFaceToFace=mean(FaceToFace)
egen meanAutomation=mean(Automation)
egen meanOnSite=mean(OnSite)
egen meanDecisionMaking=mean(DecisionMaking)

egen stdFaceToFace=sd(FaceToFace)
egen stdAutomation=sd(Automation)
egen stdOnSite=sd(OnSite)
egen stdDecisionMaking=sd(DecisionMaking)


replace FaceToFace = (FaceToFace-meanFaceToFace)/stdFaceToFace
replace Automation= (Automation-meanAutomation)/stdAutomation
replace OnSite= (OnSite - meanOnSite)/stdOnSite
replace DecisionMaking= (DecisionMaking-meanDecisionMaking)/stdDecisionMaking */



collapse FaceToFace Automation OnSite DecisionMaking, by(ONETSOCCode)
drop if Automation==.
gen notFaceToFace= 1-FaceToFace    // Need to do the reverse to get in terms of offshoring, for all three. 
gen notOnSite=1-OnSite
gen notDecisionMaking=1-DecisionMaking

egen meanNotFaceToFace=mean(notFaceToFace)
egen meanNotOnSite=mean(notOnSite)
egen meanNotDecisionMaking=mean(notDecisionMaking)
egen meanAutomation=mean(Automation)

gen notFaceToFaceOne=0
gen notOnSiteOne=0
gen notDecisionMakingOne=0
gen AutomationOne=0

replace notFaceToFaceOne=1 if notFaceToFace>=meanNotFaceToFace
replace notOnSiteOne=1 if notOnSite>=meanNotOnSite
replace notDecisionMakingOne=1 if notDecisionMaking>=meanNotDecisionMaking
replace AutomationOne=1 if Automation>=meanAutomation



egen taskOffshorability=rowtotal( Automation notFaceToFace notDecisionMaking)   // Dropping OnSite because it might not correctly represent offshorability. can set up manufacturing plant anywhere. CEO has less onsite too. 
egen maxOffshorability=max(taskOffshorability)
replace taskOffshorability=taskOffshorability/maxOffshorability

egen meanTaskOffshorability=mean(taskOffshorability)
gen taskOffshorabilityOne=0
replace taskOffshorabilityOne=1 if taskOffshorability>=meanTaskOffshorability



keep ONETSOCCode Automation notFaceToFace notOnSite notDecisionMaking taskOffshorability notFaceToFaceOne notOnSiteOne notDecisionMakingOne AutomationOne taskOffshorabilityOne
rename ONETSOCCode ONET2010
cd "K:\FirstChapter\OccupationONET\Stata file"
save OccupationOffshorabilityRank.dta,replace

cd "K:\FirstChapter\Programs\New Final Programs"





		
