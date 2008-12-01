package PAUSE::OpenID::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

use LWP::UserAgent;

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

    # 5.2.3
    # If the malformed or invalid message is received by the Relying Party, or "openid.return_to" 
    # is not present or its value is not a valid URL, the server SHOULD return a response to the end user
    # indicating the error and that it is unable to continue.
    my $return_to =  $c->req->param('openid.return_to');
    # TODO: check if its a valid URL
    if ( not defined $return_to ) {
        #$c->flash->{xml} = '<document><error_message>Missing parameter</error_message></document>';
        $c->res->redirect($c->uri_for('/error'));
    }

    # TODO: generate XML programatically
    $c->stash->{xml} = sprintf('<document><config key="url" value="%s"/></document>', $c->config->{'PAUSE::OpenID'}{'baseurl'});
    
    # Pass through parameters (unchecked for now)
    foreach my $key ( keys %{$c->req->params} ) {
        $c->stash->{$key} = $c->req->param($key);
    }

    $c->forward('PAUSE::OpenID::View::XSLT');
}

sub error :Local {
    my ( $self, $c ) = @_;
    #$c->stash->{xml} = $c->flash->{xml};
    $c->stash->{xml} = '<document/>';
    $c->forward('PAUSE::OpenID::View::XSLT');
}

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->content_type('text/plain');
    $c->response->body( 'Page not found' );
    $c->response->status(404);
    
}

sub login :Local {
    my ( $self, $c ) = @_;
    
    my $username = $c->req->param('username');
    my $password = $c->req->param('password');
    
    $c->log->debug('username "'.$username.'" login attempt');
    
    my $ua = LWP::UserAgent->new;
    my $req = HTTP::Request->new(GET => 'https://pause.perl.org/pause/authenquery');
    $req->header('If-SSL-Cert-Subject' => '/CN=pause.perl.org');
    local $ENV{HTTPS_CA_DIR} = $c->config->{'ssl'}->{'ca_dir'};
    $ua->credentials('pause.perl.org:443', 'PAUSE', $username, $password);
    my $res = $ua->request($req);
    
    # but this is bad as the certificate is checked AFTER the credentials are send :-(
    die 'pause server certificate validation failed'
        if exists $res->headers->{'client-ssl-warning'};
    
    if ($res->code == 200) {
        $c->log->info('login pass');
        $c->session->{pauseid} = $username;
        $c->res->redirect($c->uri_for('/login_pass'));
    }
    else {
        $c->log->warn('login failed');
        use Data::Dumper;
        die Dumper($res);
        
        $c->res->redirect($c->uri_for('/login_failed'));
    }
}

sub login_pass :Local {
    my ( $self, $c ) = @_;

    $c->res->content_type('text/plain');
    $c->res->body('login pass');
}

sub login_failed :Local {
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
