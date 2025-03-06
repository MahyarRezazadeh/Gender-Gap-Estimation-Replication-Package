set more off
clear all 

/***********************************
************************************/
ssc install estout
global root="C:\Users\mahya\Dropbox\Family Room (1)\WP2\Outputs\Egypt, Mahyar\replication package"
cd "$root"
use "$root/0-create data/2017.dta", clear
forvalues s=2018/2021{
	append using "$root/0-create data/`s'.dta"
}

save "$root/0-create data/egypt,2017-2021", replace

bysort caseser: egen sum_rel_3 = total(rel == 3)
br rel sum_rel_3
rename sum_rel_3 kids
label variable kids "Number of kids"
gen quarterly_date = yq(year, round)
format quarterly_date  %tq

gen health_insurance=1 if hlthins==1
replace health_insurance=0 if hlthins==0
label variable health_insurance "Has Health Insurance"

gen female=1 if sex==2
replace female=0 if sex==1
drop if age>60
label variable female "Female"
gen post_covid=1 if year>=2020 & round>=1
replace post_covid=0 if post_covid==. 
gen employed=1 if mas_d==100
replace employed=0 if mas_d==110 | mas_d==134 | mas_d==210 | mas_d==220 | mas_d==320 |mas_d==620
label variable employed "1 if Employed"
gen participation=1 if srchact_01==1 | srchact_02==1| srchact_03==1| srchact_04==1| srchact_05==1| srchact_06==1| srchact_07==1| srchact_08==1| srchact_09==1 |srchact_10==1 | srchact_90==1 & age>17 
replace participation=0 if srchact_01==0 | srchact_02==0| srchact_03==0| srchact_04==0| srchact_05==0| srchact_06==0| srchact_07==0| srchact_08==0| srchact_09==0 |srchact_10==0 | srchact_90==0 & age>17 & employed==0

keep country year round quarterly_date caseser employed pnum occ reg area rururb age mart rel attsch educ emps gradyr yeduc hlthins socsec hrswk seekwrk sectorprv sectorprv_d unempdur empinc immigr bir kids health_insurance female totwag post_covid participation

order country year quarterly_date round caseser pnum age mart rel educ female health_insurance kids
gen treatment=post_covid*female 
label variable treatment "Post-Covid*Female"

gen ln_hrswrk=ln(hrswk) if rel==1 |rel==2
label variable ln_hrswrk "Weekly working hours"

/***************************
Defining treatments in dfifferent seasons
***************************/
gen season1=1 if round==1
replace season1=0 if season1==.
label variable season1 "Winter"
gen treatment1=season1*post_covid
label variable treatment1 "Post-Covid*Winter" 
gen season2=1 if round==2
replace season2=0 if season2==.
label variable season2 "Spring"
gen treatment2=season2*post_covid
label variable treatment2 "Post-Covid*Spring"
gen season3=1 if round==3
replace season3=0 if season3==.
label variable season3 "Summer"
gen treatment3=season3*post_covid
label variable treatment3 "Post-Covid*Summer"
gen season4=1 if round==4
replace season4=0 if season4==.
label variable season4 "Fall"
gen treatment4=season4*post_covid
label variable treatment4 "Post-Covid*Fall"   


gen ln_empinc=ln(empinc)
label variable ln_empinc "Log of Employment Income"
***********************************************Insurance ratio definition
/*egen total_wom_insurance=total(female==1 & health_insurance==1) if female==1, by(quarterly_date)
egen total_wom=total(female==1) if female==1, by(quarterly_date)
gen women_ins_ratio=total_wom_insurance/total_wom if female==1
egen total_men_insurance=total(female==0 & health_insurance==1) if female==0, by(quarterly_date)
egen total_men=total(female==0) if female==0, by(quarterly_date)
replace women_ins_ratio=total_men_insurance/total_men if female==0
rename women_ins_ratio health_insurance_ratio
label variable health_insurance_ratio "% With health insurance"

egen total_womwithkids_insurance=total(female==1 & health_insurance==1 & kids>0 ) if female==1, by(year round)
egen total_womwithkids=total(female==1 & kids>0) if female==1, by(quarterly_date)
gen womenwithkids_ins_ratio=total_womwithkids_insurance/total_womwithkids if female==1
egen total_menwithkids_insurance=total(female==0 & health_insurance==1 & kids>0 ) if female==0, by(year round)
egen total_menwithkids=total(female==0 & kids>0) if female==0, by(quarterly_date)
replace womenwithkids_ins_ratio=total_menwithkids_insurance/total_menwithkids if female==0
rename womenwithkids_ins_ratio with_kids_insurance_ratio
label variable with_kids_insurance_ratio "% with insurance ratio (HH with kids) "

egen total_womwithoutkids_insurance=total(female==1 & health_insurance==1 & kids==0 ) if female==1, by(year round)
egen total_womwithoutkids=total(female==1 & kids==0) if female==1, by(quarterly_date)
gen womenwithoutkids_ins_ratio=total_womwithoutkids_insurance/total_womwithoutkids if female==1
egen total_menwithoutkids_insurance=total(female==0 & health_insurance==1 & kids==0 ) if female==0, by(year round)
egen total_menwithoutkids=total(female==0 & kids==0) if female==0, by(quarterly_date)
replace womenwithoutkids_ins_ratio=total_menwithoutkids_insurance/total_menwithoutkids if female==0
rename womenwithoutkids_ins_ratio without_kids_insurance_ratio
label variable without_kids_insurance_ratio "% with insurance ratio (HH without kids) "*/
*******************************************************************************************Employment ratio definition
egen total_wom_employment=total(female==1 & employed==1) if female==1, by(quarterly_date)
//egen total_wom=total(female==1) if female==1, by(quarterly_date)
gen women_employment_ratio=total_wom_employment/total_wom if female==1
egen total_men_employment=total(female==0 & employed==1) if female==0, by(quarterly_date)
//egen total_men=total(female==0) if female==0, by(quarterly_date)
replace women_employment_ratio=total_men_employment/total_men if female==0
rename women_employment_ratio employment_ratio
label variable employment_ratio "Share of employed persons"

egen total_womwithkids_employment=total(female==1 & employed==1 & kids>0 ) if female==1, by(quarterly_date)
//egen total_womwithkids=total(female==1 & kids>0) if female==1, by(quarterly_date)
gen womenwithkids_employment_ratio=total_womwithkids_employment/total_womwithkids if female==1
egen total_menwithkids_employment=total(female==0 & employed==1 & kids>0 ) if female==0, by(quarterly_date)
//egen total_menwithkids=total(female==0 & kids>0) if female==0, by(quarterly_date)
replace womenwithkids_employment_ratio=total_menwithkids_employment/total_menwithkids if female==0
rename womenwithkids_employment_ratio with_kids_employment_ratio
label variable with_kids_employment_ratio "Share of employed persons (HH with kids) "

egen total_womwithoutkids_employment=total(female==1 & employed==1 & kids==0 ) if female==1, by(quarterly_date)
//egen total_womwithoutkids=total(female==1 & kids==0) if female==1, by(quarterly_date)
gen womwithoutkids_empl_ratio=total_womwithoutkids_employment/total_womwithoutkids if female==1
egen total_menwithoutkids_employment=total(female==0 & employed==1 & kids==0 ) if female==0, by(quarterly_date)
//egen total_menwithoutkids=total(female==0 & kids==0) if female==0, by(quarterly_date)
replace womwithoutkids_empl_ratio=total_menwithoutkids_employment/total_menwithoutkids if female==0
rename womwithoutkids_empl_ratio without_kids_employment_ratio
label variable without_kids_employment_ratio "Share of employed persons (HH without kids) "
****************************************************************************************************
gen having_kids=1 if kids>0
replace having_kids=0 if kids==0
gen has_health=1 if hlthins==1
replace has_health=0 if hlthins==0
replace has_health=. if hlthins==99

sort caseser pnum
by caseser: egen max_pnum = max(pnum)
rename max_pnum HH_size

gen child_labor=1 if age<=16 & employed==1
replace child_labor=0 if child_labor==.
egen families_with_cl=total(child_labor==1), by(caseser)
bysort caseser: gen kid = (rel== 3)
rename kids number_of_kids
save "$root/0-create data/ready_to_estimate.dta", replace