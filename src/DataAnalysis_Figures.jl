module DataAnalysis_Figures

# load in processed arrays with all helper functions including simulated pop
# functions for different analyses used in figures

using JLD2, GLM, Dates, StatsBase, HypothesisTests, KernelDensity
# PrettyPlot as well if using Figure Composer https://gitlab.oit.duke.edu/herzfeldd/PrettyPlot.jl

include("smooth.jl")
include("gauss4.jl")

cd("C:\\Users\\scb47\\Documents\\MTdataprocess")
@load "modelfreepop.jld2" foundation foundationNull modulationH modulationHnull modulationSP modulationSPnull
@load "MTdataProcessed.jld2" mdall predFRall dataFRall cohall spdall psall prefD imall eyeall metric_fail speedPulse cohPulse pulseTime
cd("C:\\Users\\scb47\\Documents\\MATLAB\\Figures")
xa_im=-400:1200
for un in unique(mdall)
    if (sum(prefD[mdall.==un])/length(prefD[mdall.==un])) == 1 #if no null direction, remove
        ndx = findall(mdall.==un)
        deleteat!(mdall, ndx)
        deleteat!(predFRall, ndx)
        deleteat!(dataFRall, ndx)
        deleteat!(cohall, ndx)
        deleteat!(spdall, ndx)
        deleteat!(psall, ndx)
        deleteat!(prefD, ndx)
        deleteat!(imall, ndx)
        deleteat!(eyeall, ndx)
        deleteat!(metric_fail, ndx)
        deleteat!(speedPulse, ndx)
        deleteat!(cohPulse, ndx)
        deleteat!(pulseTime, ndx)
    end
end
lg = 60
binsz = 0.005
xa_pd = (-0.4:binsz:1.2)*1000
w = findall((lg).<=xa_pd.<(lg+lg))
winmax100 = Vector{Real}(undef, 0)
unm = unique(mdall)
for un in unique(mdall)
    ndx = findall((cohall.==100).& (mdall.==un))
    hld=[]
    for ii in ndx
        push!(hld, mean(dataFRall[ii][w]))
    end
    push!(winmax100, maximum(hld))
end

sam=0:0.125:6
vsam = repeat(sam,42)
vp = sample(1:length(foundation), length(vsam)).
x = (-0.4:binsz:0.9) * 1000

modelneuron(x,p) = gauss4(x,p[1],90,40).+gauss4(x,p[2],170,60).+gauss4(x,p[3],300,75).+gauss4(x,p[4],500,150).+gauss4(x,p[5],900,300).+p[6]

nm=[]
bb=[]
for kk in 1:length(vsam)
    push!(nm, mean(modelneuron(x, foundation[vp[kk]])[w]))
    push!(bb, foundation[vp[kk]][end])
end


end
