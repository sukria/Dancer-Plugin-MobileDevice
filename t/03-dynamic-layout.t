use strict;
use warnings;

use Test::More import => ['!pass'];

plan tests => 4;

{
    use Dancer;
    use Dancer::Plugin::MobileDevice;

    get '/' => sub {
        template 'index';
    };
}

use Dancer::Test;

$ENV{HTTP_USER_AGENT} = 'Android';
response_content_like [GET => '/'], 
    qr{mobile\nis_mobile_device: 1}ms, 
    "mobile layout is set for mobile agents";

$ENV{HTTP_USER_AGENT} = 'Mozilla';
response_content_is [GET => '/'], 
    "is_mobile_device: 0\n", 
    "no layout for non-mobile agents";

set layout => 'main';

$ENV{HTTP_USER_AGENT} = 'Android';
response_content_like [GET => '/'], 
    qr{mobile\nis_mobile_device: 1}ms, 
    "mobile layout is set for mobile agents";

$ENV{HTTP_USER_AGENT} = 'Mozilla';
response_content_like [GET => '/'], 
    qr{main\nis_mobile_device: 0}ms, 
    "main layout for non-mobile agents";

