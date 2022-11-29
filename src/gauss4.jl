#gaussian function
function gauss4(x,a,b,c)
    return a.*broadcast(exp,(-((x.-b)./c).^2))
end
