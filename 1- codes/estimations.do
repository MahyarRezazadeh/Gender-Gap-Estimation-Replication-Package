set more off
global root="C:\Users\mahya\Dropbox\Family Room (1)\WP2\Outputs\Egypt, Mahyar\replication package"
cd "$root"

/**************************DID estimations*/
clear all
use "$root/0-create data/ready_to_estimate.dta",clear

eststo model1: reghdfe ln_empinc i.female##i.post_covid if age>=18 , vce(cluster reg)
eststo model2: reghdfe ln_empinc i.female##i.post_covid  if age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model3: reghdfe ln_empinc i.female##i.post_covid  if number_of_kids==0, vce(cluster reg)
eststo model4: reghdfe ln_empinc i.female##i.post_covid if number_of_kids==0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model5: reghdfe ln_empinc i.female##i.post_covid  if  number_of_kids>0 & age>=18 ,  vce(cluster reg)
eststo model6: reghdfe ln_empinc i.female##i.post_covid  if number_of_kids>0 & age>=18 , abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
esttab model1 model2 model3 model4 model5 model6 using "$root\2- results\DDresults_employmentINC.tex", label replace


*RESULTS: No overall covid effect(measurement error and selection problem: only those who are high income reported and covid is supposed to disporportionally change high income persons report and low income reports decision)
******************************DD participation
/*


eststo model01: reg participation i.female##i.post_covid , vce(cluster reg)
eststo model02: reg participation i.female##i.post_covid age yeduc mart i.reg i.reg#i.year  HH_size i.round  , vce(cluster reg)
eststo model03: reg participation i.female##i.post_covid  if number_of_kids==0, vce(cluster reg)
eststo model04: reg participation i.female##i.post_covid age yeduc mart reg  HH_size i.reg#i.year i.round if number_of_kids==0 ,  vce(cluster reg)
eststo model05: reg participation i.female##i.post_covid  if number_of_kids>0  ,  vce(cluster reg)
eststo model06: reg participation i.female##i.post_covid age yeduc mart reg  HH_size i.reg#i.year i.round if number_of_kids>0 ,  vce(cluster reg)
esttab model01 model02 model03 model04 model05 model06 using "$root\2- results\DDresults_participation.tex", label replace

**************/
*health insurance status

eststo modell1: reghdfe hlthins i.female##i.post_covid , vce(cluster reg)
eststo modell2: reghdfe hlthins i.female##i.post_covid  , abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo modell3: reghdfe hlthins i.female##i.post_covid  if number_of_kids==0, vce(cluster reg)
eststo modell4: reghdfe hlthins i.female##i.post_covid if number_of_kids==0 , abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo modell5: reghdfe hlthins i.female##i.post_covid  if  number_of_kids>0  ,  vce(cluster reg)
eststo modell6: reghdfe hlthins i.female##i.post_covid  if number_of_kids>0  , abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
esttab modell1 modell2 modell3 modell4 modell5 modell6 using "$root\2- results\DDresults_health_insurance.tex", label replace

* The positive effect is mainly explained by the sector of employment: Women in healthcare get higher bargaining power 
* being in a sector is explaining the main variation






*************************
**************************DID Post-covid, different seasons*
****1- Spring
eststo model11: reghdfe ln_empinc i.female##i.treatment2 if age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

eststo model12: reghdfe ln_empinc i.female##i.treatment2 if having_kids==0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

eststo model13: reghdfe ln_empinc i.female##i.treatment2 if having_kids>0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)


*Result: No heterogenous response once after beggining the shock

esttab model11 model12 model13  using "$root\2- results\DDresults_Spring_employmentINC.tex", label replace

****2- Summer
eststo model21: reghdfe ln_empinc i.female##i.treatment3 if age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model22: reghdfe ln_empinc i.female##i.treatment3 if having_kids==0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model23: reghdfe ln_empinc i.female##i.treatment3 if having_kids>0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
esttab model21 model22 model23  using "$root\2- results\DDresults_Summer_employmentINC.tex", append

*During season heterogeneity: Summer is making women with kids more negatively impacted  


****3- Fall
eststo model21: reghdfe ln_empinc i.female##i.treatment4 if age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model22: reghdfe ln_empinc i.female##i.treatment4 if having_kids==0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model23: reghdfe ln_empinc i.female##i.treatment4 if having_kids>0 & age>=18,   abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)


*Result: no statistical evidence, but results should be cautiously interpreated


esttab model21 model22 model23  using "$root\2- results\DDresults_Fall_employmentINC.tex", append


*******WINTER
****3- Fall
eststo model21: reghdfe ln_empinc i.female##i.treatment1 if age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model22: reghdfe ln_empinc i.female##i.treatment1 if having_kids==0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model23: reghdfe ln_empinc i.female##i.treatment1 if having_kids>0 & age>=18,   abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

**No effect on labor income.

/********************************************************************************************************************
Log of weekly working hours
********************************************************************************************************************/

eststo model31: reghdfe ln_hrswrk  i.female##i.post_covid if age>=18, vce(cluster reg)
eststo model32: reghdfe ln_hrswrk  i.female##i.post_covid if age>=18,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model33: reghdfe ln_hrswrk  i.female##i.post_covid if number_of_kids==0 & age>=18, vce(cluster reg)
eststo model34: reghdfe ln_hrswrk  i.female##i.post_covid  if number_of_kids==0 & age>=18 , abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model35: reghdfe ln_hrswrk  i.female##i.post_covid if number_of_kids>0 & age>=18, vce(cluster reg)
eststo model36: reghdfe ln_hrswrk  i.female##i.post_covid if number_of_kids>0 & age>=18 , abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
esttab model31 model32 model33 model34 model35 model36  using "$root\2- results\DDresults_Hrswrk.tex", label replace

*RESULTS: covid forced all women to reduce their weekly working hours and gap has been increased 

****1-Spring
eststo model41: reghdfe ln_hrswrk i.female##i.treatment2 if age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

eststo model42: reghdfe ln_hrswrk i.female##i.treatment2 if number_of_kids==0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

eststo model43: reghdfe ln_hrswrk i.female##i.treatment2 if number_of_kids>0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

* NO effect during spring (a quarter after the shock: maybe because of lock down and total closure of all sectors (peak of effect and no vaccination))

esttab model41 model42 model43 using "$root\2- results\DDresults_hrswrk_Spring.tex", label replace 

****2- Summer
eststo model51: reghdfe ln_hrswrk i.female##i.treatment3 if age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

eststo model52: reghdfe ln_hrswrk i.female##i.treatment3 if having_kids==0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)


eststo model53: reghdfe ln_hrswrk i.female##i.treatment3 if having_kids>0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

* RESULTS: women with kids are affected more and they reduced their weekly working hours. No effect on non mothers

esttab model51 model52 model53  using "$root\2- results\DDresults_hrswrk_summer.tex", append

****3- Fall
eststo model61: reghdfe ln_hrswrk i.female##i.treatment4 if age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

eststo model62: reghdfe ln_hrswrk i.female##i.treatment4  if having_kids==0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model63: reghdfe ln_hrswrk i.female##i.treatment4 if having_kids>0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

****Winter after
eststo model61: reghdfe ln_hrswrk i.female##i.treatment1 if age>=18 , abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

eststo model62: reghdfe ln_hrswrk i.female##i.treatment1  if having_kids==0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo model63: reghdfe ln_hrswrk i.female##i.treatment1 if having_kids>0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
*Results: both groups womens are affected: No evidence of child burden for this variable. No school effect, no dynamic in weekly working hours, but during a winter after, the effect is still exist for mothers but no effect for other womens. It can be because of seasonal flexibility of market for mothers as well. But no general evidence
esttab model61 model62 model63 using "$root\2- results\DDresults_hrswrk_fall.tex", append


** heterogenous response among differet groups.
*/
/**********************************************************************************************************************
Results until here		
**********************************************************************************************************************/
*Working hours, nothing yet in tersm of child burden. But be careful that employment income decreased and it might be because of extensive effect that makes mothers to exit the market. Does results confirm this? Lets go and see this for employment

****************************************************************************************************

*Log of weekly working hours
/*
 reghdfe has_health  i.female##i.post_covid 
 reghdfe has_health  i.female##i.post_covid,  abs(age yeduc mart reg occ)
 reghdfe has_health  i.female##i.post_covid if kids==0
 reghdfe has_health  i.female##i.post_covid if kids==0,  abs(age yeduc mart reg occ)
 reghdfe has_health  i.female##i.post_covid if kids>0
 reghdfe has_health  i.female##i.post_covid if kids>0,  abs(age yeduc mart reg occ)
 
*******1-Spring
eststo model81: reghdfe health_insurance_ratio i.female##i.treatment2,  abs(age yeduc mart reg occ)

eststo model82: reghdfe with_kids_insurance_ratio i.female##i.treatment2 if kids>0,  abs(age yeduc mart reg occ)

eststo model83: reghdfe without_kids_insurance_rati i.female##i.treatment2 if kids==0,  abs(age yeduc mart reg occ)

esttab model81 model82 model83  using "$root\results_insurance_combined.tex", label replace
*******2-Summer
eststo model91: reghdfe health_insurance_ratio i.female##i.treatment3,  abs(age yeduc mart reg area occ)

eststo model92: reghdfe with_kids_insurance_ratio i.female##i.treatment3 if kids>0,  abs(age yeduc mart reg occ)

eststo model93: reghdfe without_kids_insurance_rati i.female##i.treatment3 if kids==0,  abs(age yeduc mart reg occ)

esttab model91 model92 model93 using "$root\results_insurance_combined.tex", append

*******3-Fall
eststo modela1: reghdfe health_insurance_ratio i.female##i.treatment4,  abs(age yeduc mart reg occ)

eststo modela2: reghdfe with_kids_insurance_ratio i.female##i.treatment4 if kids>0,  abs(age yeduc mart reg   occ)

eststo modela3: reghdfe without_kids_insurance_rati i.female##i.treatment4 if kids==0,  abs(age yeduc mart reg occ)

esttab modela1 modela2 modela3  using "$root\results_insurance_combined.tex", append
**Only without kids are negatively affected (?) 

*/
/********************************
Effect on unemployment
*********************************/


eststo model101: reghdfe employed i.female##i.post_covid if age>=18, vce(cluster reg)
eststo model102: reghdfe employed i.female##i.post_covid if age>=18, abs(i.age##i.age i.yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo model103: reghdfe employed i.female##i.post_covid if having_kids==0 & age>=18, vce(cluster reg)
eststo model104: reghdfe employed i.female##i.post_covid  if having_kids==0 & age>=18,  abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo model105: reghdfe employed i.female##i.post_covid if having_kids>0 & age>=18 , vce(cluster reg)
eststo model106: reghdfe employed i.female##i.post_covid  if having_kids>0 & age>=18 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
esttab model101 model102 model103 model104 model105 model106 using "$root\2- results\DDemployement.tex", label replace

* Results: overall effect on unemployment rate for mothers: 2.5 percent less (compare it with women employment rate in egypt: Here you need to refer to summary stat table)

**for women with kids effect on employmemnt is negative but positive for women without kids. (robust to adding controls)


*Add a trend of gap over the period: define gap and its trend over time with its (just to make things more beautifull:) 

******************************************************************************************************************************************************************

*******1-Spring
eststo s1: reghdfe employed i.female##i.treatment2, vce(cluster reg)
eststo s2: reghdfe employed i.female##i.treatment2 if age>=18,  abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo s3:reghdfe employed i.female##i.treatment2 if having_kids==0, vce(cluster reg)
eststo s4:reghdfe employed i.female##i.treatment2 if having_kids==0 , abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo s5:reghdfe employed i.female##i.treatment2 if having_kids>0, vce(cluster reg)
eststo s6: reghdfe employed i.female##i.treatment2 if having_kids>0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
esttab s1 s2 s3 s4 s5 s6  using "$root\2- results\DDresults_employment_spring.tex", label replace


*Part of the decrease happened during spring: Once after the shock happens 

*******2-Summer
eststo ss1: reghdfe employed i.female##i.treatment3, vce(cluster reg)
eststo ss2: reghdfe employed i.female##i.treatment3 if age>=18,  abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo ss3:reghdfe employed i.female##i.treatment3 if having_kids==0, vce(cluster reg)
eststo ss4:reghdfe employed i.female##i.treatment3 if having_kids==0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo ss5:reghdfe employed i.female##i.treatment3 if having_kids>0, vce(cluster reg)
 eststo ss6:reghdfe employed i.female##i.treatment3 if having_kids>0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
esttab ss1 ss2 ss3 ss4 ss5 ss6 using "$root\2- results\DDresults_employment_summer.tex", append

*Another part of decrease during summer


*******3-Fall
eststo f1: reghdfe employed i.female##i.treatment4, vce(cluster reg)
eststo f2: reghdfe employed i.female##i.treatment4 if age>=18,  abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo f3: reghdfe employed i.female##i.treatment4 if having_kids==0, vce(cluster reg)
eststo f4:reghdfe employed i.female##i.treatment4 if having_kids==0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo f5:reghdfe employed i.female##i.treatment4 if having_kids>0, vce(cluster reg)
eststo f6: reghdfe employed i.female##i.treatment4 if having_kids>0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
esttab f1 f2 f3 f4 f5 f6 using "$root\2- reults\DDresults_employment_fall.tex", append

* ANother part happens in FaLL

******************4- winter
reghdfe employed i.female##i.treatment1, vce(cluster reg)
 reghdfe employed i.female##i.treatment1 if age>=18,  abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
reghdfe employed i.female##i.treatment1 if having_kids==0, vce(cluster reg)
reghdfe employed i.female##i.treatment1 if having_kids==0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
reghdfe employed i.female##i.treatment1 if having_kids>0, vce(cluster reg)
 reghdfe employed i.female##i.treatment1 if having_kids>0 & age>=18, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
esttab model131 model132 model133 using "$root\DDresults_employment_fall.tex", append


*Overtime exit is happening for mothers. Maybe that is a reason why their weekly working hours is behaving like that

*/

/**********************************************************
Tripple differnce estimations
**********************************************************/
drop having_kids
gen having_kids=1 if number_of_kids>=1
replace having_kids=0 if number_of_kids==0
gen interaction1=female*post_covid
gen interaction2=female*post_covid*having_kids
gen interaction3=female*having_kids
label variable interaction3 "Post-Covid*Having Kids"
label variable interaction1 "Female*Post_covid"
label variable interaction2 "Female*Post_covid*Having Kids"
gen interaction0=post_covid*having_kids
label variable interaction0 "Post-Covid* Having kids"

eststo DDD1: reghdfe ln_hrswrk i.female##i.post_covid##i.having_kids if age>=18, vce(cluster reg)
eststo DDD2: reghdfe ln_hrswrk i.female##i.post_covid##i.having_kids if age>18, abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

**NO Effect: Consistent with previous finding

eststo DDD3: reghdfe ln_empinc i.female##i.post_covid##i.having_kids if age>=18, vce(cluster reg)
eststo DDD4: reghdfe ln_empinc i.female##i.post_covid##i.having_kids if age>18,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

**NO statisticall effect: COnsistent with previous findings

*eststo DDD5: reg has_health female post_covid having_kids interaction2 interaction1  interaction0, vce(cluster reg)
*eststo DDD6: reg has_health female post_covid having_kids interaction2 interaction1  interaction0 age yeduc mart reg occ HH_size, vce(cluster reg)
eststo DDD7: reghdfe employed i.female##i.post_covid##i.having_kids if age>=18,vce(cluster reg)
eststo DDD8: reghdfe employed i.female##i.post_covid##i.having_kids if age>18, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
*overall effect: Women exited the market during the covid, Employment rate decreased by 2 percent.  They exited the market, they reduced their working hours as well as all other womens. But women with kids exited the market by more 2 percent. 
*/ seasonal heterogeneity
esttab DDD1 DDD2 DDD3 DDD4 DDD7 DDD8 using "$root\2- results\DDDresults.tex"


****************DYNAMIC OF EFFECT, TABLE 7

*1-EMPLOYMENT RATE
reghdfe employed i.female##i.having_kids##i.post_covid if age>18 & season2==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg) //Spring
reghdfe employed i.female##i.having_kids##i.post_covid if age>18 & season3==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Summer
reghdfe employed i.female##i.having_kids##i.post_covid if age>18 & season4==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Fall
reghdfe employed i.female##i.having_kids##i.post_covid if age>18 & season1==1 & year!=2020, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Winer


*2-WORKING HOURS
reghdfe ln_hrswrk i.female##i.having_kids##i.post_covid if age>18 & season2==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg) //Spring
reghdfe ln_hrswrk i.female##i.having_kids##i.post_covid if age>18 & season3==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Summer
reghdfe ln_hrswrk i.female##i.having_kids##i.post_covid if age>18 & season4==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Fall
reghdfe ln_hrswrk i.female##i.having_kids##i.post_covid if age>18 & season1==1 & year!=2020, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Winer

*3-EMPLOYMENT INCOME

reghdfe ln_empinc i.female##i.having_kids##i.post_covid if age>18 & season2==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg) //Spring
reghdfe ln_empinc i.female##i.having_kids##i.post_covid if age>18 & season3==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Summer
reghdfe ln_empinc i.female##i.having_kids##i.post_covid if age>18 & season4==1, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Fall
reghdfe ln_empinc i.female##i.having_kids##i.post_covid if age>18 & season1==1 & year!=2020, abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
// Winer




****fall


eststo fDDD1: reghdfe ln_hrswrk i.female##i.having_kids##i.treatment4   if age>18, vce(cluster reg)
eststo fDDD2: reghdfe  ln_hrswrk i.female##i.having_kids##i.treatment4  if age>18 ,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)


eststo fDDD3: reg ln_empinc i.female##i.having_kids##i.treatment4, vce(cluster reg) 
eststo fDDD4: reghdfe  ln_empinc i.female##i.having_kids##i.treatment4  if age>18 ,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

*eststo DDD5: reg has_health female post_covid having_kids interaction2 interaction1  interaction0, vce(cluster reg)
*eststo DDD6: reg has_health female post_covid having_kids interaction2 interaction1  interaction0 age yeduc mart reg occ HH_size, vce(cluster reg)
eststo fDDD7: reghdfe employed i.female##i.having_kids##i.treatment4  if age>18 ,vce(cluster reg)
eststo fDDD8: reghdfe  employed i.female##i.having_kids##i.treatment4  if age>18 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)


*Results: market exiting for mothers continues in fall


*************Winter


eststo wDDD1: reghdfe ln_hrswrk i.female##i.having_kids##i.treatment1 if age>18, vce(cluster reg)
eststo wDDD2: reghdfe  ln_hrswrk i.female##i.having_kids##i.treatment1 ,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
eststo wDDD3: reghdfe ln_empinc i.female##i.having_kids##i.treatment1, vce(cluster reg)
eststo wDDD4: reghdfe  ln_empinc i.female##i.having_kids##i.treatment1,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)
*eststo DDD5: reg has_health female post_covid having_kids interaction2 interaction1  interaction0, vce(cluster reg)
*eststo DDD6: reg has_health female post_covid having_kids interaction2 interaction1  interaction0 age yeduc mart reg occ HH_size, vce(cluster reg)
eststo wDDD7: reghdfe employed i.female##i.having_kids##i.treatment1, vce(cluster reg)
eststo wDDD8: reghdfe  employed i.female##i.having_kids##i.treatment1 if age>18 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)

esttab sDDD2 ssDDD2 fDDD2 wDDD2 using  "$root\2- results\DDD_seasonal_results.tex", replace
esttab sDDD4 ssDDD4 fDDD4 wDDD4 using "$root\2- results\DDD_seasonal_results.tex", append
esttab sDDD8 ssDDD8 fDDD8 wDDD8 using "$root\2- results\DDD_seasonal_results.tex", append

*Result: exiting the market continues in winter following the shock. Most of the market oufollow is happening three quarters aftre the shock. 


*/*******************************
for different employment type (self employed, family worker, etc)
****************/

** group 1 employees:
reghdfe  ln_empinc i.female##i.post_covid if age>=18 & emps==1 & having_kids==0,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

reghdfe  ln_hrswrk i.female##i.post_covid if age>=18 & emps==1 & having_kids==0,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

reghdfe  employed i.female##i.post_covid if age>=18 & emps==1 & having_kids==1,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)


** group 2 employer:
reghdfe  ln_empinc i.female##i.post_covid if age>=18 & emps==2 & having_kids==0,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

reghdfe  ln_hrswrk i.female##i.post_covid if age>=18 & emps==2 & having_kids==0,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

reghdfe  employed i.female##i.post_covid if age>=18 & emps==2 & having_kids==1,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

** group 3 Self-employed:
reghdfe  ln_empinc i.female##i.post_covid if age>=18 & emps==3 & having_kids==0,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

reghdfe  ln_hrswrk i.female##i.post_covid if age>=18 & emps==3 & having_kids==0,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

reghdfe  employed i.female##i.post_covid if age>=18 & emps==3 & having_kids==1,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)

** group 4, 3 family worker:
reghdfe  ln_empinc i.female##i.post_covid if age>=18 & emps==4  & having_kids==0,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

reghdfe  ln_hrswrk i.female##i.post_covid if age>=18 & emps==4  & having_kids==0,abs(age yeduc i.mart HH_size i.reg##i.occ##i.round) vce(cluster reg)

reghdfe  employed i.female##i.post_covid if age>=18 & emps==4   & having_kids==1,abs(age yeduc i.mart HH_size i.occ##i.reg##i.round) vce(cluster reg)


** Robsutness didnt pass!! Maybe it is because of measurment error in the vraiable of occ


***************************************************************************************************************


reg employed i.female##i.post_covid having_kids age yeduc occ HH_size mart i.reg i.round i.reg#i.round if emps==2 & having_kids==1 , vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc occ  mart i.reg i.round i.reg#i.round if rel<=2 & emps==3 | emps==4 , vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc occ HH_size mart i.reg i.round i.reg#i.round if rel<=2 & emps==3 , vce(cluster reg)
reg ln_empinc female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round , vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round if emps==4 | emps==3, vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round if  emps==3, vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round if  emps==4, vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round if  emps==1, vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round if  emps==2, vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round if  emps==3, vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round if  emps==4, vce(cluster reg)
reg employed female post_covid having_kids interaction2 interaction1 interaction3 interaction0 age yeduc mart i.reg i.reg#i.year occ HH_size i.round if  emps==1, vce(cluster reg)




*******************************************END here


***************///////////////Defining sample restriction based on numbers of kids
by caseser: egen max_age = max(cond(rel == 3, age, .))
by caseser: egen min_age = min(cond(rel == 3, age, .))
gen age_diff = max_age - min_age
by caseser: replace age_diff = age_diff[1] if rel == 1 | rel == 2

gen unemployed=1 if employed==0
replace unemployed=0 if employed==1
gen standard_employed=(employed- .5491347)/.4975803
gen log_employed=ln(standard_employed)
******why 10?
quietly summarize employed if age >= 18 & rel == 2 & having_kids == 1 & female == 1
local mean_y = r(mean)

quietly reg employed c.age_diff##c.age_diff c.HH_size occ c.age c.number_of_kids  c.yeduc ///
    if rel == 2 & having_kids == 1 & female == 1, robust
estimates store baseline

quietly eststo eq_temp1: margins , at(age_diff =(0(1)20)) post

coefplot (eq_temp1, at recast(line) lpattern(solid) lwidth(*1) lcolor(navy) ///
    ciopts(recast(rarea) fcolor(bluishgray%75) lpattern(dash) lwidth(0)) ///
    yline(`mean_y', lcolor(red) lpattern(dash)) )  
 graph export "$root/results/kids_numb_dose_response.png", replace
 

******************Women with age diff of kids more than 10







eststo check2:reghdfe  ln_hrswrk i.female##i.post_covid if age>=18  & having_kids==1 & age_diff>12 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo check1:reghdfe  ln_hrswrk i.female##i.post_covid if age>=18  & having_kids==1 & age_diff<=12 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)




//eststo check4:reghdfe  ln_empinc i.female##i.post_covid if age>=18  & having_kids==1 & age_diff>=12 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
//eststo check3:reghdfe  ln_empinc i.female##i.post_covid if age>=18  & having_kids==1 & age_diff<12 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)



eststo check6:reghdfe  employed i.female##i.post_covid if age>=18  & having_kids==1 & age_diff>12 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)
eststo check5:reghdfe  employed i.female##i.post_covid if age>=18  & having_kids==1 & age_diff<=12 ,abs(age yeduc i.mart HH_size i.reg##i.round) vce(cluster reg)





esttab check1 check2 check3 check4 check5 check6 using  "$root\2- results\robustness_check.tex", replace

* Robustness check passed!


***Explain how age diff 10 is determined. SHow the graph of weekly hours as a function of age difference for bs regression

 
**Employment 
reg employed interaction2 interaction0 interaction1 interaction3 female post_covid if age>=18 & age_diff>=10 &number_of_kids>=2, rob
reg employed interaction2 interaction0 interaction1 interaction3 i.female i.post_covid age yeduc HH_size mart i.reg i.reg#i.round  i.year if age>=18 & age_diff>=10, rob

******************Women with age diff of kids less than 10
reg ln_hrswrk  interaction2 interaction0 interaction1 interaction3 female post_covid if number_of_kids>1 & age>=18 & age_diff<10, rob
reg ln_hrswrk interaction2 interaction0 interaction1 interaction3 female post_covid age yeduc mart i.reg i.reg#i.round HH_size i.year if age>=18 & number_of_kids>1 & age_diff<10, rob


**Employment 
reg employed interaction2 interaction0 interaction1 interaction3 female post_covid if age>=18 & age_diff<10 & number_of_kids>1, rob
reg employed interaction2 interaction0 interaction1 interaction3 i.female i.post_covid age yeduc mart i.reg i.reg#i.round  i.year if age>=18 & age_diff<10 & number_of_kids>1, rob

**************************Comment: can you use an alternative measure of income? Like income per capita by dividing the total income per year devided by numbers of employed in that year and take the differnce of ind income and percapita in that group and see how this changes. 
esttab DDD1 DDD2 DDD3 DDD4 DDD7 DDD8 using "$root/DDD.tex", label replace
*******************************************************************

/***********


Robustnes check of industries

TABLE A.3

***********************/

******Industries are not picking up mothers and non-mothers differently
clear all
use "$root/0-create data/ready_to_estimate.dta",replace
gen mothers=1 if having_kids==1 & female==1

replace mothers=0 if having_kids==0 & female==1

** For each job classification we see whether being hired in that is depend on being mothers#covid compared to non mothers. 

gen employed_employee=1 if employed==1 & emps==1
replace employed_employee=0 if employed==0 & emps==1

gen employed_employer=1 if employed==1 & emps==2
replace employed_employer=0 if employed==0 & emps==2

gen employed_in_own_occupant=1 if employed==1 & emps==3
replace employed_in_own_occupant=0 if employed==0 & emps==3

gen employed_family_worker=1 if employed==1 & emps==4
replace employed_family_worker=0 if employed==0 & emps==3



** while it doesnt directly means that mothers are picked up, but to some extend confirms our statement that mothers decided to exit the market completely
reghdfe employed_employee  i.mothers##i.post_covid  yeduc  if age>=18, abs(i.age##i.age  i.year i.mart HH_size i.reg##i.round) vce(cluster reg)
reghdfe employed_employer  i.mothers##i.post_covid  yeduc  if age>=18, abs(i.age##i.age  i.year i.mart HH_size i.reg##i.round) vce(cluster reg)
reghdfe employed_in_own_occupant  i.mothers##i.post_covid  yeduc  if age>=18 & rel==1|rel==2, abs(i.age##i.age  i.year i.mart HH_size i.reg##i.round) vce(cluster reg)
reghdfe employed_family_worker  i.mothers##i.post_covid  yeduc  if age>=18 & rel==1|rel==2, abs(i.age##i.age  i.year i.mart HH_size i.reg##i.round) vce(cluster reg)

//Robustnesss check passed!!




/***********************************

Robustness checks age restriction


*********************/

clear all
use "$root/0-create data/ready_to_estimate.dta", replace

keep if rel==3
gen kids_age=age
keep year quarterly_date round caseser pnum kids_age

save "$root/0-create data/kids_sample.dta", replace
use "$root/0-create data/ready_to_estimate.dta", replace

merge 1:1 round caseser pnum year using "$root/0-create data/kids_sample.dta", keep (master match)
keep if _merge==3
drop _merge
 
******kids with different ages




***1- Winter
eststo rob1:reghdfe employed  i.female##i.post_covid  if  having_kids==1 & kids_age<19 & round==1 & year<2021 ,abs(i.age##i.age yeduc i.mart i.reg##i.round) vce(cluster reg)
eststo rob2:reghdfe employed  i.female##i.post_covid  if  having_kids==1 & kids_age>=19 & round==1 & year<2021 ,abs(i.age##i.age yeduc i.mart i.reg##i.round) vce(cluster reg)

******SPRING

eststo rob3:reghdfe employed  i.female##i.post_covid  if  having_kids==1 & kids_age<19 & round==2 & year<2021 ,abs(i.age##i.age yeduc i.mart i.reg##i.round) vce(cluster reg)
eststo rob4:reghdfe employed  i.female##i.post_covid  if  having_kids==1 & kids_age>=19 & round==2& year<2021 ,abs(i.age##i.age yeduc i.mart i.reg##i.round) vce(cluster reg)

**SUMMER
eststo rob5:reghdfe employed  i.female##i.post_covid  if  having_kids==1 & kids_age<19 & round==3& year<2021  ,abs(i.age##i.age yeduc i.mart i.reg##i.round) vce(cluster reg)
eststo rob6:reghdfe employed  i.female##i.post_covid  if  having_kids==1 & kids_age>=19 & round==3& year<2021 ,abs(i.age##i.age yeduc i.mart i.reg##i.round) vce(cluster reg)

**Fall
eststo rob7:reghdfe employed  i.female##i.post_covid  if  having_kids==1 & kids_age<19 & round==4 & year<2021 ,abs(i.age##i.age yeduc i.mart i.reg##i.round) vce(cluster reg)
eststo rob8:reghdfe employed  i.female##i.post_covid  if  having_kids==1 & kids_age>=19 & round==4& year<2021 ,abs(i.age##i.age yeduc i.mart i.reg##i.round) vce(cluster reg)


esttab rob1 rob2 rob3 rob4 rob5 rob6 rob7 rob8 using "$root/kids_rob.tex", label replace


**DISTRIBUTIONS


*label define round 1 "Winter" 2 "Spring" 3 "Summer" 4 "Fall"
gen ln_total_menwith_kids_emp=ln(total_menwithkids_employment)
gen ln_total_womwith_kids_emp=ln(total_womwithkids_employment)
gen ln_totalwomwithoutkidsemployment=ln(total_womwithoutkids_employment)

graph bar (mean) ln_total_menwith_kids_emp ln_totalwomwithoutkidsemployment ln_total_womwith_kids_emp, over(round) bar(1, color(blue)) bar(2, color(red)) bar(3, color(green)) legend(label(1 "Men with kids") label(2 "Women without kids") label(3 "Women with kids")) ytitle("Mean of employment") title("Mean Employed persons by round")

graph export "$root\results\graph1.png", as(png) name("Graph1"), replace



// Fourth graph: Mean of ln_total_menwith_kids_emp over quarterly_date


// Combine all graphs into one figure with different colors
graph combine graph1 graph2 graph3, col(2)

//Tabulate counts of employed individuals (employed == 1) by quarter (round), year, and groups (male, mothers, non-mothers)


/********************************************************************************************
Graphical Trends
********************************************************************************************/
preserve
collapse (mean) employed, by(quarterly_date female )
twoway (line ln_hrswrk quarterly_date if female==1 ,sort lcolor(red) lpattern(line) connect(direct)) (line ln_hrswrk quarterly_date if female==0 , sort lcolor(blue) lpattern(line) connect(direct)),  title(Log of Weekly Working Hours) legend(order(1 "All women" 2 "All men") position(4) ring(0) col(1)) name(graph1)




clear all
use "$root/egypt,2017-2021", clear

preserve
collapse (mean) ln_hrswrk, by(quarterly_date female )
twoway (line ln_hrswrk quarterly_date if female==1 ,sort lcolor(red) lpattern(line) connect(direct)) (line ln_hrswrk quarterly_date if female==0 , sort lcolor(blue) lpattern(line) connect(direct)),  title(Log of Weekly Working Hours) legend(order(1 "All women" 2 "All men") position(4) ring(0) col(1)) name(graph1)


restore
collapse (mean) ln_hrswrk, by(quarterly_date female having_kids)
twoway (line ln_hrswrk quarterly_date if female==1 & having_kids==1,sort lcolor(red) lpattern(line) connect(direct)) (line ln_hrswrk quarterly_date if female==0 &  having_kids==1, sort lcolor(blue) lpattern(line) connect(direct)),  title(Log of Weekly Working Hours (HH with kids)) legend(order(1 "All women with kids" 2 "All men with kids") position(4) ring(0) col(1)) name(graph2)
twoway (line ln_hrswrk quarterly_date if female==1 &  having_kids==0,sort lcolor(red) lpattern(line) connect(direct)) (line ln_hrswrk quarterly_date if female==0 &  having_kids==0, sort lcolor(blue) lpattern(line) connect(direct)),  title(Log of Weekly Working Hours (HH without kids)) legend(order(1 "All women without kids" 2 "All men without kids") position(4) ring(0) col(1)) name(graph3)
graph combine graph1 graph2 graph3, rows(2) cols(2) xcommon ycommon 
graph export "$root\weekly hours.png", as(png) name("Graph") replace


clear all
use "$root/egypt,2017-2021", clear
preserve
collapse (mean) ln_empinc, by(quarterly_date year female)
drop if year<=2018
twoway (line ln_empinc quarterly_date if female==1 ,sort lcolor(red) lpattern(line) connect(direct)) (line ln_empinc quarterly_date if female==0 , sort lcolor(black) lpattern(line) connect(direct)),  title(Log of Employment Income) legend(order(1 "All women" 2 "All men") position(4) ring(0) col(1)) name(graph1)


restore
collapse (mean) ln_empinc, by(round female year quarterly_date having_kids)
drop if year<=2018
twoway (line ln_empinc quarterly_date if female==1 & having_kids==1,sort lcolor(red) lpattern(line) connect(direct)) (line ln_empinc quarterly_date if female==0  & having_kids==1, sort lcolor(black) lpattern(line) connect(direct)),  title(Log of Employment Income (HH with kids)) legend(order(1 "All women with kids" 2 "All men with kids") position(4) ring(0) col(1)) name(graph2)

twoway (line ln_empinc quarterly_date if female==1 & having_kids==0,sort lcolor(red) lpattern(line) connect(direct)) (line ln_empinc quarterly_date if female==0 & having_kids==0, sort lcolor(black) lpattern(line) connect(direct)),  title(Log of Employment Income (HH without kids)) legend(order(1 "All women without kids" 2 "All men without kids") position(4) ring(0) col(1)) name(graph3)
graph combine graph1 graph2 graph3, rows(2) cols(2) xcommon ycommon 
graph export "$root\employment income.png", as(png) name("Graph") replace



clear all
use "$root/egypt,2017-2021", clear
preserve
collapse (mean) employed, by(quarterly_date female) 
twoway (line employed quarterly_date if female==1 ,sort lcolor(red) lpattern(line) connect(direct)) (line employed quarterly_date if female==0 , sort lcolor(black) lpattern(line) connect(direct)),  title(mean of employed persons) legend(order(1 "All women" 2 "All men") position(4) ring(0) col(1)) name(graph1)
restore
collapse (mean) employed, by(quarterly_date female having_kids) 
twoway (line employed quarterly_date if female==1 & having_kids==1,sort lcolor(red) lpattern(line) connect(direct)) (line employed quarterly_date if female==0 & having_kids==1, sort lcolor(black) lpattern(line) connect(direct)),  title(mean of employed persons (HH with kids)) legend(order(1 "All women with kids" 2 "All men with kids") position(4) ring(0) col(1)) name(graph2)

twoway (line employed quarterly_date if female==1 & having_kids==0,sort lcolor(red) lpattern(line) connect(direct)) (line employed quarterly_date if female==0 & having_kids==0, sort lcolor(black) lpattern(line) connect(direct)),  title(mean of employed persons (HH without kids)) legend(order(1 "All women without kids" 2 "All men without kids") position(4) ring(0) col(1)) name(graph3)
graph combine graph1 graph2 graph3, rows(2) cols(2) xcommon ycommon 
graph export "$root\employed.png", as(png) name("Graph") replace



clear all
use "$root/egypt,2017-2021", clear
//replace has_health=ln(has_health)
preserve
collapse (mean) has_health , by(quarterly_date female) 
twoway (line has_health quarterly_date if female==1 ,sort lcolor(red) lpattern(line) connect(direct)) (line has_health quarterly_date if female==0 , sort lcolor(black) lpattern(line) connect(direct)),  title(has helath insurance) legend(order(1 "All women" 2 "All men") position(4) ring(0) col(1)) name(graph1)


restore
collapse (mean) has_health, by(quarterly_date female having_kids) 
twoway (line has_health quarterly_date if female==1 & having_kids==1,sort lcolor(red) lpattern(line) connect(direct)) (line has_health quarterly_date if female==0 & having_kids==1, sort lcolor(black) lpattern(line) connect(direct)),  title(has health insurance (HH with kids)) legend(order(1 "All women with kids" 2 "All men with kids") position(4) ring(0) col(1)) name(graph2)

twoway (line has_health quarterly_date if female==1 & having_kids==0,sort lcolor(red) lpattern(line) connect(direct)) (line has_health quarterly_date if female==0 & having_kids==0, sort lcolor(black) lpattern(line) connect(direct)),  title(has helath insurance (HH without kids)) legend(order(1 "All women without kids" 2 "All men without kids") position(4) ring(0) col(1)) name(graph3)
graph combine graph1 graph2 graph3, rows(2) cols(2) xcommon ycommon 
graph export "$root\has health insurance.png", as(png) name("Graph") replace




///////////////////////TABLE OF Differences///////////////////////////////////


* Before COVID-19
clear all
use "$root/0-create data/ready_to_estimate.dta",replace
*gen female_withkids=1 if female==1 & having_kids==1
*replace female_withkids=0 if female==1 & having_kids==0


keep if post_covid==0
ttest employed, by(female) 
ttest empinc, by(female)
ttest hrswk, by(female)
*keep if age>=25 & age<40

clear all
use "$root/0-create data/ready_to_estimate.dta",replace
keep if post_covid==0 & having_kids==0
ttest employed, by(female) 
ttest empinc, by(female)
ttest hrswk, by(female)



clear all
use "$root/0-create data/ready_to_estimate.dta",replace
keep if post_covid==0 & having_kids==1
ttest employed, by(female) 
ttest empinc, by(female)
ttest hrswk, by(female)


* After COVID-19
clear all
use "$root/0-create data/ready_to_estimate.dta",replace

keep if post_covid==1
ttest employed, by(female) 
ttest empinc, by(female)
ttest hrswk, by(female)


clear all
use "$root/0-create data/ready_to_estimate.dta",replace
keep if post_covid==1 & having_kids==0
ttest employed, by(female) 
ttest empinc, by(female)
ttest hrswk, by(female)



clear all
use "$root/0-create data/ready_to_estimate.dta",replace
keep if post_covid==1 & having_kids==1
ttest employed, by(female) 
ttest empinc, by(female)
ttest hrswk, by(female)

