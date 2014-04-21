use strict;
use warnings;

use Test::More import => ['!pass'];

plan tests => 2;

{
	use Dancer;
	use Dancer::Plugin::MobileDevice;

	get '/' => sub {
		return is_mobile_device;
	};
}

use Dancer::Test;

{
	my $warn;
	local $SIG{__WARN__} = sub { $warn = $_[0] };
	
	delete $ENV{HTTP_USER_AGENT};
	response_content_is [GET => '/'], 0,
		'Undefined user agent is not reported as a mobile device';
	ok(!$warn, 'No warning is produced for undefined user agent')
}
