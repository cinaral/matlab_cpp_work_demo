%************************%
%* Read test parameters *%
%************************%
bin_dname   = '../../build/bin';
param_dname = append(bin_dname, '/', 'param');
dat_dname   = append(bin_dname, '/', 'dat');
addpath('../../matlab');

param_file  = fopen(append(param_dname, '/', 'Scalars'), 'r');

while ~feof(param_file)
	name = fscanf(param_file, '%s', 1);
	val  = fscanf(param_file, '%f', 1);
	param.(name) = val;
end
fclose(param_file);

%**********************************%
%* verify filter_1st_order_test.m *%
%**********************************%
t_final     = 10; %* [s]
t_arr       = 0:param.time_step:t_final;
t_arr_len   = length(t_arr);
input_ampl  = 1; 
input_freq  = 1; %* [hz]
tau         = param.time_const;
w           = 2*pi*input_freq;
x_arr       = input_ampl*sin(w*t_arr).';
H_norm      = 1/sqrt(1+ w^2*tau^2);
H_angle     = -atan(w*tau);
y_chk_arr   = input_ampl/(tau^2*w^2 + 1)*(sin(w*t_arr) - tau*w*cos(w*t_arr) + tau*w*exp(-t_arr/tau)).';
y_arr       = zeros(size(x_arr));
delimiter   = ',';

for i = 1:t_arr_len

	if i == 1
		%* initially at rest
		x_1 = 0;
		y_1 = 0;
	else
		x_1 = x_arr(i - 1);
		y_1 = y_arr(i - 1);	
	end
	x_0 = x_arr(i);

	y_arr(i) = filter_1st_order(y_1, x_0, x_1, param.time_step, tau);
end

fprintf('--- filter_1st_order.m:\n');
max_x_error  = max(vecnorm(y_arr - y_chk_arr, 2, 2));
mean_x_error = mean(vecnorm(y_arr - y_chk_arr, 2, 2));
fprintf('max  y(t) err: %g\n', max_x_error);
fprintf('mean y(t) err: %g\n', mean_x_error);

%***************%
%* test_filter *%
%***************%

%* x_arr is an input to test_filter.exe
writematrix(x_arr, append(dat_dname, '/', 'x_arr.dat'), 'Delimiter', delimiter);  

%* run test_filter.exe
prev_pwd = pwd;
cd(bin_dname);
if system('test_filter.exe') > 0
	error('Could not open test_filter.exe');
end
cd(prev_pwd);

%* read the output of test_filter.exe
try
    y_cpp_arr = readmatrix(append(dat_dname, '/', 'y_arr.dat'), 'Delimiter', delimiter);
catch
    error('Could not open y_arr.dat');
end

fprintf('--- filter_1st_order.cpp:\n');
max_x_error  = max(vecnorm(y_cpp_arr - y_arr, 2, 2));
mean_x_error = mean(vecnorm(y_cpp_arr - y_arr, 2, 2));
fprintf('max  y_cpp(t) vs y(t): %g\n', max_x_error);
fprintf('mean y_cpp(t) vs y(t): %g\n', mean_x_error);

%********%
%* Plot *%
%********%
figure('Name', 'filter_1st_oder_test');
clf;
hold on;
plot(t_arr, y_arr);
plot(t_arr, y_cpp_arr);
plot(t_arr, y_chk_arr, '--');
plot(t_arr, x_arr, ':', 'LineWidth', 1);
title('$\frac{Y(s)}{X(s)} = \frac{1}{\tau s + 1}$');
xlabel('$t$');
ylabel('$y(t)$');
legend('$y(t)$', '$y_\mathrm{cpp}(t)$', '$y_\mathrm{analytical}(t)$', 'x(t)', 'Location', 'Best')
