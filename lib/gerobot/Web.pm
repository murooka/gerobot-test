package gerobot::Web;
use strict;
use warnings;
use utf8;
use parent qw/gerobot Amon2::Web/;
use File::Spec;

use gerobot::Web::Dispatcher;
sub dispatch {
    return (gerobot::Web::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::JSON',
);

use gerobot::Web::View;
{
    sub create_view {
        my $view = gerobot::Web::View->make_instance(__PACKAGE__);
        no warnings 'redefine';
        *gerobot::Web::create_view = sub { $view }; # Class cache.
        $view
    }
}

__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;

        # http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );

        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );

        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

1;
