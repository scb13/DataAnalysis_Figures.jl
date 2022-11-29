# function to smooth data
using DSP
function smooth(y, w_len=11, w_method=2)
    # This function requires the DSP package to be installed
    # 1: flat
    # 2: hanning
    # 3: hamming ...
    if w_len%2==0
        w_len+=1 #make odd for window length
    end
    if w_method == 1
        w=ones(w_len)
    elseif w_method == 2
        w=DSP.hanning(w_len)
    elseif w_method == 3
        w=DSP.hamming(w_len)
    end

    if (w_len < 3) || (length(y) < w_len) #not long enough
        return y
    else
        y_new = [2*y[1].-reverse(y[1:w_len],1); y[:]; 2*y[end].-reverse(y[end-w_len:end],1)]
        y_smooth = conv(y_new, w/sum(w))
        ind = floor(Int, 1.5*w_len)
        return y_smooth[1+ind:end-ind-1]
    end
end
