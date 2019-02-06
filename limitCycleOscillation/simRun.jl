using UnsteadyFlowSolvers

alpha_init = 10. *pi/180
alphadot_init = 0.
h_init = 0.
hdot_init = 0.
u = 0.467
udot = 0
kinem = KinemPar2DOF(alpha_init, h_init, alphadot_init, hdot_init, u)

x_alpha = 0.05
r_alpha = 0.5
kappa = 0.05
w_alpha = 1.
w_h = 1.
w_alphadot = 0.
w_hdot = 0.
cubic_h_1 = 1.
cubic_h_3 = 0.
cubic_alpha_1 = 1.
cubic_alpha_3 = 0.
strpar = TwoDOFPar(x_alpha, r_alpha, kappa, w_alpha, w_h, w_alphadot, w_hdot, cubic_h_1, cubic_h_3, cubic_alpha_1, cubic_alpha_3)

#Kinematic definitions to initialise surface (initial conditions)
alphadef = ConstDef(alpha_init)
hdef = ConstDef(h_init)
udef = ConstDef(1.) #This is relative to uref
startkinem = KinemDef(alphadef, hdef, udef)

lespcrit = [0.11;]

pvt = 0.35

c = 1.

surf = TwoDSurf("FlatPlate", pvt, startkinem, lespcrit, c=c, uref=u)

curfield = TwoDFlowField()

dtstar = 0.015

nsteps = 500

t_tot = nsteps * dtstar / u

startflag = 0

writeflag = 0
writeInterval = dtstar * nsteps/20.

writeInterval = t_tot/20.

delvort = delSpalart(500, 12, 1e-5)

mat, surf, curfield = ldvm2DOF(surf, curfield, strpar, kinem, nsteps, dtstar,startflag, writeflag, writeInterval, delvort)

makeForcePlots2D()

#cleanWrite()
