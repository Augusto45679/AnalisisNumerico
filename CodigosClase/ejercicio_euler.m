function ejercicio_euler

y0=1;
t0=0;
dt = 0.1;
Ndt = 10;

%dimensionamiento
t = zeros(Ndt, 1);
y= = zeros(Ndt,1);

t(1)=t0;
y(1)=y0;
% EULER
for j=1:NDt-1
    k1=Dt*f_ord_1(y(j),t(j));
    y(j+1)  = y(j)+ k1;
    t(j+1)  = t(j)+Dt;
end


%Grafico

endfunction
