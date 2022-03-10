if ~exist('../../build/bin/test_filter.exe', 'file')
	error('test_filter.exe is missing. You need to build it.')
else
	test_filter
end

