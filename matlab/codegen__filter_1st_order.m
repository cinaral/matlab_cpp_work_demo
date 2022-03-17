%* function y = filter_1st_order(y_prev, x, x_prev, T, tau)
precision = 'single';

x_dim    = 1;
scalar_t = coder.newtype(precision, [1, 1]);
x_t      = coder.newtype(precision, [x_dim, 1]);
y_t      = coder.newtype(precision, [x_dim, 1]);
x_prev_t = coder.newtype(precision, [x_dim, 1]);
y_prev_t = coder.newtype(precision, [x_dim, 1]);

cfg = coder.config('lib');

cfg.HardwareImplementation.TargetHWDeviceType = 'Intel->x86-64 (Windows64)';

codegen filter_1st_order -d codegen\ -args {y_prev_t, x_t, x_prev_t, scalar_t, scalar_t} -config cfg -lang:c++ -c -report 