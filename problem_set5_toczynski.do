//a
probit inlf nwifeinc educ exper expersq age
gen dkidslt6 = (kidslt6>0)
probit dkidslt6 nwifeinc educ exper expersq age
//b
biprobit inlf dkidslt6 nwifeinc educ exper expersq age
//c
biprobit (inlf nwifeinc educ exper expersq dkidslt6) (dkidslt6 nwifeinc educ exper expersq age)
//d
//baseline
local athrho=1/2*ln((1+(0))/(1-(0)))
constraint define 1 _b[/athrho] = `athrho'
biprobit (inlf dkidslt6 nwifeinc educ exper expersq) (dkidslt6 nwifeinc educ exper expersq age), constraints(1)

local athrho=1/2*ln((1+(-0.3))/(1-(-0.3)))
constraint define 11 _b[/athrho] = `athrho'
biprobit (inlf dkidslt6 nwifeinc educ exper expersq) (dkidslt6 nwifeinc educ exper expersq age), constraints(11)
//e
biprobit (inlf nwifeinc educ exper expersq dkidslt6) (dkidslt6 nwifeinc educ exper expersq age)
predict newvar1, xb1
predict newvar2, xb2
correlate newvar1 newvar2, covariance
//f
local athrho=1/2*ln((1+(-0.26))/(1-(-0.26)))
constraint define 12 _b[/athrho] = `athrho'
biprobit (inlf dkidslt6 nwifeinc educ exper expersq) (dkidslt6 nwifeinc educ exper expersq age), constraints(12)
