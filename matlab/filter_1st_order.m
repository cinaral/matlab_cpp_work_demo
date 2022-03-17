function y = filter_1st_order(y_prev, x, x_prev, T, tau)
%* Practical differentiator with first order filter
%* y = filter_1st_order(x, T, tau)  
%* y      - filtered x at the current time step
%* y_prev - filtered x at the previous time step
%* x      - x at the current time step
%* x_prev - x at the previous time step
%* T      - time step
%* tau    - time constant
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

y = ((T*x + T*x_prev) - (T - 2*tau)*y_prev)/(T + 2*tau);

end
