
*claudia gentile
*Exercise 5.2 do file


clear
cd "C:\Users\93cla\Google Drive\Zurich\university of zurich\exams\metrics 2\ps5"


capture log close
set more off
use mroz.dta

*points a,b
gen kidslt6d = 0
replace kidslt6d = 1 if kidslt6 > 0

probit inlf nwifeinc educ exper expersq age
outreg using exercise_2_probit, title("Probit regression") varlabels replace
probit kidslt6d nwifeinc educ exper expersq age
outreg using exercise_2_probit, title("Probit regression") varlabels merge replace
biprobit inlf kidslt6d nwifeinc educ exper expersq age
outreg using exercise_2_biprobit, title("Biprobit regression") varlabels replace
*point c
biprobit (inlf = kidslt6 nwifeinc educ exper expersq age) (kidslt6d = nwifeinc educ exper expersq age)
outreg using exercise_2_biprobitc, title("Biprobit regression (2)") varlabels replace

*point e
*in order to find effect of more than one child I create two new dummy variables:
*•	Kids1:  taking value 1 if the woman has one child below 6
*•	Kidsm1 : taking value 1 if the woman has more than one child below  6 
*(since it is not specified whether we should consider all children or just the ones below 6, I focus on children below 6 since in the above points we were focusing our attention on kidslt6).

gen kids1 = 0
replace kids1 = 1 if kidslt6 == 1
gen kidsm1 = 0
replace kidsm1 = 1 if kidslt6 > 1
biprobit (inlf = kids1 kidsm1 nwifeinc educ exper expersq age) (kidslt6d = nwifeinc educ exper expersq age)
outreg using exercise_2_biprobit3, title("Biprobit regression (unconstrained)") varlabels replace

local athrho = atanh(-.7)
constraint 1 [athrho]_cons = `athrho'
biprobit (inlf = kids1 kidsm1 nwifeinc educ exper expersq age) (kidslt6d = nwifeinc educ exper expersq age), constraint(1)

local athrho = atanh(-.75)
constraint 1 [athrho]_cons = `athrho'
biprobit (inlf = kids1 kidsm1 nwifeinc educ exper expersq age) (kidslt6d = nwifeinc educ exper expersq age), constraint(1)
outreg using exercise_2_biprobit4, title("Biprobit regression (constrained rho = -0.75)") varlabels replace

*point f
probit inlf nwifeinc educ exper expersq age 
predict xb
rename xb xb1
probit kidslt6d nwifeinc educ exper expersq age
predict xb
rename xb xb2

correlate xb1 xb2, cov

*point g
local athrho = atanh(-.0078)
constraint 1 [athrho]_cons = `athrho'
biprobit (inlf = kids1 kidsm1 nwifeinc educ exper expersq age) (kidslt6d = nwifeinc educ exper expersq age), constraint(1)
outreg using exercise_2_biprobit5, title("Biprobit regression (constrained rho = -0.0078)") varlabels replace
margins, dydx(*)

















