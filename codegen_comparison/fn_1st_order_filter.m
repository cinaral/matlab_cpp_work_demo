%#codegen
function xf = fn_1st_order_filter(x,dt,f)
coder.inline('always');
%  X = [x_n ; x_n-1  ; x_n-2];
% dX = [0   ; dx_n-1 ; dx_n-2];

persistent n X Xf A B tau

if isempty(n)
   n   = 1; 
   tau = 1/(2*pi*f);
   A   = (2*tau - dt) / (2*tau + dt);
   B   = dt / (2*tau + dt);
   X   = [0;0];
   Xf  = [0;0]; 
end

X  = [x;X(1)];
xf = A*Xf(1)+B*(X(1)+X(2)); 

if n<1.5
   xf = x;
   n  = n+1;
end

Xf = [xf;Xf(1)];