package PAUSE::OpenID::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

PAUSE::OpenID::Controller::Root - Root Controller for PAUSE::OpenID

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

$c->stash->{xml} =<<XML;
<document/>
XML
    
    # Pass through parameters (unchecked for now)
    foreach my $key ( keys %{$c->req->params} ) {
        $c->stash->{$key} = $c->req->param($key);
    }

    # Hello World
    $c->forward('PAUSE::OpenID::View::XSLT');
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
    
}

sub login :Local {
    my ( $self, $c ) = @_;
    
    my $username = $c->req->param('username');
    my $password = $c->req->param('password');
    
    $c->log->debug('username "'.$username.'" login attemp');
    
    $c->res->redirect($c->uri_for('/login_failed'));
}

sub login_pass {
    my ( $self, $c ) = @_;
    
    $c->res->content_type('text/plain');
    $c->res->body('login pass');
}

sub login_failed {
    my ( $self, $c ) = @_;
    
    $c->res->content_type('text/plain');
    $c->res->body('login fail');
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Thomas Klausner,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
