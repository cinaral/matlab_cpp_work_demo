if exist('build/filter_1st_order_test.exe', 'file')
	movefile 'build/filter_1st_order_test.exe' './'
end
if ~exist('filter_1st_order_test.exe', 'file')
	error('Could not find filter_1st_order_test.exe, make sure you build it');		
end

filter_1st_order_test