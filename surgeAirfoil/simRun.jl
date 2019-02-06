using UnsteadyFlowSolvers

alphadef = ConstDef(13. *pi/180)

hdef = ConstDef(0.)

lambda = 0.5
k = 0.1

udef = SinDef(1., lambda, k, 0.)

full_kinem = KinemDef(alphadef, hdef, udef)

pvt = 0.25

geometry = "FlatPlate"

lespcrit = [0.25;]

surf = TwoDSurf(geometry, pvt, full_kinem, lespcrit)

curfield = TwoDFlowField()

dtstar = 0.015 #UNSflow.find_tstep(hdef)

t_tot = 2. *pi/udef.k

nsteps = Int(round(t_tot/dtstar))+1

println("nsteps", nsteps)

startflag = 0

writeflag = 1

writeInterval = t_tot/10.

#delvort = delSpalart(500, 12, 1e-5)
delvort = UNSflow.delNone()

mat, surf, curfield = ldvmLin(surf, curfield, nsteps, dtstar,startflag, writeflag, writeInterval, delvort)

UNSflow.makeVortPlots2D()

UNSflow.makeForcePlots2D()

#UNSflow.makeKinemClVortPlots2D()

UNSflow.cleanWrite()
