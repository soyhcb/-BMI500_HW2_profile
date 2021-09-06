clc;clear

profile on
syms x y real
f = (x^2+y-11)^2+(x+y^2-7)^2; 
dx = diff(f,x);
dy = diff(f,y);
sol = vpasolve([dx,dy]);

f_hessian = matlabFunction(hessian(f,[x,y]));
FF = subs(f,sol);

[sol_min, sol_max, sol_sadd] = deal(struct("x",[],"y",[]));
for i=1:length(sol.x)
    eigval = eig(f_hessian(sol.x(i),sol.y(i)));
    if all(eigval > 0)
%         minimum
        sol_min.x = [sol_min.x, sol.x(i)];
        sol_min.y = [sol_min.y, sol.y(i)];     
    elseif all(eigval < 0)
%         maximum
        sol_max.x = [sol_max.x, sol.x(i)];
        sol_max.y = [sol_max.y, sol.y(i)];
    else
%         saddle
        sol_sadd.x = [sol_sadd.x, sol.x(i)];
        sol_sadd.y = [sol_sadd.y, sol.y(i)];
    end
end
sol_sadd
sol_min
sol_max

profile viewer