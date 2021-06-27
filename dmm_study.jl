using Plots;
using LaTeXStrings;
# ±[ppm of reading + ppm of range]
function accuracyf(x,a,b,range)
  reading_accuracy = a*x
  range_accuracy = b*range
  accuracy = reading_accuracy + range_accuracy
  return accuracy
end;


f1(v)=accuracyf(v,2,0.7,10);
f2(v)=accuracyf(v,9,1.2,10);
f3(v)=accuracyf(v,14,1.2,10);
f4(v)=accuracyf(v,22,1.2,10);

#
g1(v)=accuracyf(v,3.2,0.35,20);
g2(v)=accuracyf(v,8,0.4,20);
g3(v)=accuracyf(v,12,0.4,20);
g4(v)=accuracyf(v,16,0.4,20);

function accuracy_plot(f,g,name,type="";linewidth=2)
    devices =["K7510" "K2002"]
    vr=range(0,10, length=21)
    if type == "SR"
        prefix = 2e-1
        label_y = "Accuracy (µA)"
    elseif type == "AR"
        prefix = 2e-2
        label_y = "Accuracy (µA)"
    else
        prefix = 1
        label_y = "Accuracy (µV)"
    end

    emptystring=" "

    f1(v)=prefix*f(v)
    f2(v)=prefix*g(v)
    fontsize = 8
    x1=round(f1(0);digits=4)
    y1=round(f2(0);digits=4)
    x2=round(f1(5);digits=4)
    y2=round(f2(5);digits=4)
    x3=round(f1(10);digits=4)
    y3=round(f2(10);digits=4)

    return plot([f1,f2], vr,
        label=devices,
        lw=linewidth,
        xlabel="Voltage (V)", xguidefontsize=fontsize,
        ylabel=label_y, yguidefontsize=fontsize,
        legend=:bottomright, legendfontsize=fontsize,
        title=type*emptystring*name,
        annotations = (
            [( 0, (x1+y1)/2., Plots.text((x1,y1),:left, fontsize)),
             ( 5, (x2+y2)/2., Plots.text((x2,y2),:left, fontsize)),
             (10, (x3+y3)/2., Plots.text((x3,y3),:right, fontsize))
            ]),
        xtickfont = font(fontsize),
        ytickfont = font(fontsize)
        )
end;

l = @layout [a ; b c]
P24h_V=accuracy_plot(f1,g1,"24h δV");
P24h_I_AR=accuracy_plot(f1,g1,"24h δI","AR");
P24h_I_SR=accuracy_plot(f1,g1,"24h δI","SR");
plot(P24h_V,P24h_I_AR,P24h_I_SR, layout = l)

accuracy_plot(f2,g2,"90d")
accuracy_plot(f2,g2,"90d","AR")
accuracy_plot(f2,g2,"90d","SR")

accuracy_plot(f3,g3,"1y")
accuracy_plot(f3,g3,"1y","AR")
accuracy_plot(f3,g3,"1y","SR")

accuracy_plot(f4,g4,"2y")
accuracy_plot(f4,g4,"2y", "AR")
accuracy_plot(f4,g4,"2y", "SR")
