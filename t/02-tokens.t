use strict;
use warnings;

use Test::More import => ['!pass'];

plan tests => 2;

{
    use Dancer;
    use Dancer::Plugin::MobileDevice;

    get '/' => sub {
        template 'index', {}, {layout => 0};
    };
}

use Dancer::Test;

$ENV{HTTP_USER_AGENT} = 'Android';
response_content_is [GET => '/'], 
    "is_mobile_device: 1\n", 
    "token is_mobile_device is present and valid for Android";

$ENV{HTTP_USER_AGENT} = 'Mozilla';
response_content_is [GET => '/'], 
    "is_mobile_device: 0\n", 
    "token is_mobile_device is present and valid for Mozilla";

