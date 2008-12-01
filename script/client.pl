#!/usr/bin/perl
use strict;
use warnings;

use Net::OpenID::Consumer;
use LWPx::ParanoidAgent;

my $csr = Net::OpenID::Consumer->new(
    ua    => LWPx::ParanoidAgent->new,
    #cache => Some::Cache->new,
    #args  => $cgi,
    consumer_secret => 'foo',
    required_root => "http://localhost:3000",
  );

  # a user entered, say, "bradfitz.com" as their identity.  The first
  # step is to fetch that page, parse it, and get a
  # Net::OpenID::ClaimedIdentity object:

  my $claimed_identity = $csr->claimed_identity("http://localhost:3000") || die $csr->err;

  # now your app has to send them at their identity server's endpoint
  # to get redirected to either a positive assertion that they own
  # that identity, or where they need to go to login/setup trust/etc.

  my $check_url = $claimed_identity->check_url(
    return_to  => "http://localhost:3000/openid-check.app?yourarg=val",
    trust_root => "http://localhost:3000/",
  );

  # so you send the user off there, and then they come back to
  # openid-check.app, then you see what the identity server said.

  # Either use callback-based API (recommended)...
  $csr->handle_server_response(
      not_openid => sub {
          die "Not an OpenID message";
      },
      setup_required => sub {
          my $setup_url = shift;
          print "setup_required $setup_url\n";
          # Redirect the user to $setup_url
      },
      cancelled => sub {
            print "cancelled\n";
          # Do something appropriate when the user hits "cancel" at 
          # the OP
      },
      verified => sub {
          my $vident = shift;
          print "verified $vident\n";
          # Do something with the VerifiedIdentity object $vident
      },
      error => sub {
          my $err = shift;
          die($err);
      },
  );


