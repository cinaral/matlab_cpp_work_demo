variables = {1.0,1.0,1.0};
cfg = coder.config('lib');
cfg.HardwareImplementation.TargetHWDeviceType = 'Intel->x86-64 (Windows64)';
%mex -setup cpp
codegen fn_1st_order_filter -args  variables -lang:c++ -c -config cfg -report