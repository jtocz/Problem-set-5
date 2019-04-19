* Econometrics PS5

clear
set more off
set matsize 800

* loading the data
use "../mroz.dta", clear

global controls nwifeinc educ exper expersq age

* 5.2.(a)
gen dummy = kidslt6 > 0

probit inlf $controls
probit dummy $controls

* 5.2.(b)
biprobit (dummy = $controls ) (inlf = $controls )

* birpobit allows to control explicitly for correlation between error terms in two regressions

* 5.2.(c)
biprobit (inlf = dummy $controls ) (dummy = $controls ) 
