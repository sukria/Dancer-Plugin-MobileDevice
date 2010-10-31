package Dancer::Plugin::MobileDevice;

use strict;
use warnings;
our $VERSION = '0.01';
    
use Dancer ':syntax';
use Dancer::Plugin;

register 'is_mobile_device' => sub {
    return request->user_agent =~
        /(iPhone|Android|BlackBerry|Mobile|Palm)/
      ? 1 : 0;
};

before sub {
    var orig_layout => setting('layout');

    if (is_mobile_device()) {
        setting layout => 'mobile';
    }
};

after sub {
    my $orig_layout = vars->{'orig_layout'};
    setting layout => $orig_layout;
};

before_template sub {
    my $tokens = shift;
    $tokens->{'is_mobile_device'} = is_mobile_device();
};

register_plugin;

1;
__END__
=head1 NAME

Dancer::Plugin::MobileDevice - make a dancr app mobile-aware

=head1 SYNOPSIS

    package MyWebApp;
    use Dancer;
    use Dancer::Plugin::MobileDevice;

    get '/' => sub {
        if (is_mobile_device) {
            # do something for mobile
        }
        else {
            # do something for regular agents
        }
    };

=head1 AUTHOR

Alexis Sukrieh, C<< <sukria at sukria.net> >>

=head1 BUGS

Please report any bugs or feature requests to
L<http://github.com/sukria/Dancer-Plugin-MobileDevice/issues>

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Dancer::Plugin::MobileDevice


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Dancer-Plugin-MobileDevice>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Dancer-Plugin-MobileDevice>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Dancer-Plugin-MobileDevice>

=item * Search CPAN

L<http://search.cpan.org/dist/Dancer-Plugin-MobileDevice/>

=back


=head1 ACKNOWLEDGEMENTS

This plugin was initially written for an artilce of the Dancer advent calendar
2010.

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alexis Sukrieh.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=cut
