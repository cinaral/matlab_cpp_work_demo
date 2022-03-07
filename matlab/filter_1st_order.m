function y_0 = filter_1st_order(y_1, x_0, x_1, T, tau)
%* Practical differentiator with first order filter
%* y_0 = filter_1st_order(x, T, tau)  
%* y_0 - filtered x at the current time step
%* y_1 - filtered x at the previous time step
%* x_0 - x at the current time step
%* x_1 - x at the previous time step
%* T   - time step
%* tau - time constant
%*
%* Let y(t) be the filtered version of x(t):
%* Y(s)       1
%* ---- = ---------
%* X(s)   tau*s + 1
%*
%* Bilinear approximation: s <- 2/T*(z - 1)/(z+1)
%*
%* Y(z)            T + T*z^{-1}
%* ---- = ---------------------------------
%* X(z)   (T + 2*tau) + (T - 2*tau)*z^{-1}
%*
%* cinaral 2022-02-12

y_0 = ((T*x_0 + T*x_1) - (T - 2*tau)*y_1)/(T + 2*tau);

end
