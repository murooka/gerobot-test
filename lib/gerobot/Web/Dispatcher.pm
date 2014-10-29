package gerobot::Web::Dispatcher;
use strict;
use warnings;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub {
    my ($c) = @_;
    return $c->render_json(+{
        text => 'hello, gerobot!',
    });
};

1;
