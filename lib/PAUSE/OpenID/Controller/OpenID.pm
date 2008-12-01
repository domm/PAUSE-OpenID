package PAUSE::OpenID::Controller::OpenID;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use Net::OpenID::Server;


# taken straight from Net::OpenID::Server
# http://search.cpan.org/src/MART/Net-OpenID-Server-1.02/doc/catalyst_sample
sub index : Local {
    my ( $self, $c ) = @_;

    my $server = Net::OpenID::Server->new(
        post_args    => $c->req->params,
        get_args     => $c->req->params,
        endpoint_url => $c->uri_for('/server'),
        setup_url    => $c->uri_for('/login'),
        get_user     => sub {
            return $c->user_exists ? $c->user : undef;
        },
        get_identity => sub {
            my ( $u, $identity ) = @_;
            return $identity unless $u;
            return $c->uri_for( sprintf( '/user/%s', $u->username ) );
        },
        is_identity => sub {
            my ( $u, $identity ) = @_;
            return $u && $u->username eq ( split '/', $identity )[-1];
        },
        is_trusted => sub {
            my ( $u, $trust_root, $is_identity ) = @_;
            return $is_identity;
        }
    );

    my ( $type, $data ) = $server->handle_page();

    if ( $type eq 'redirect' ) {
        return $c->res->redirect($data);
    }
    elsif ( $type eq 'setup' ) {
        my $uri = $c->uri_for( '/login', $data );
        return $c->res->redirect($uri);
    }
    else {
        $c->res->content_type($type);
        $c->res->body($data);
    }

}

1;
