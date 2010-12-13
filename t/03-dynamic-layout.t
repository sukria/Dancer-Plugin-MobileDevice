use strict;
use warnings;

use Test::More import => ['!pass'];

plan tests => 5;

{
    use Dancer;
    use File::Spec;
    use Dancer::Plugin::MobileDevice;
    setting show_errors => 1;

    set views => File::Spec->catfile('t', 'views');
    
    get '/' => sub {
        template 'index';
    };
}

use Dancer::Test;



$ENV{HTTP_USER_AGENT} = 'Android';
response_content_is [GET => '/'],
    "is_mobile_device: 1\n",
    "No layout used unless asked to";

# this is a bit dirty
my $settings = Dancer::Config::settings();
$settings->{plugins}{mobiledevice}{mobile_layout} = 'mobile';

response_content_is [GET => '/'], 
    "mobile\nis_mobile_device: 1\n\n",
    "mobile layout is set for mobile agents when desired";


$ENV{HTTP_USER_AGENT} = 'Mozilla';
response_content_is [GET => '/'], 
    "is_mobile_device: 0\n", 
    "no layout for non-mobile agents";

set layout => 'main';

$ENV{HTTP_USER_AGENT} = 'Android';
response_content_is [GET => '/'], 
    "mobile\nis_mobile_device: 1\n\n", 
    "mobile layout is set for mobile agents still";

$ENV{HTTP_USER_AGENT} = 'Mozilla';
response_content_is [GET => '/'], 
    "main\nis_mobile_device: 0\n\n", 
    "main layout for non-mobile agents";

