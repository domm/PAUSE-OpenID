#!/usr/bin/perl

use strict;
use warnings;

#use Test::More 'no_plan';
use Test::More tests => 4;
use Test::WWW::Mechanize;
#use WWW::Mechanize::Plugin::AutoWrite;

use FindBin qw($Bin);
use lib "$Bin/lib";

my $url = $ENV{'PAUSE_OpenID_url'} || 'http://localhost:3000/openid/';

exit main();

sub main {
	my $mech = Test::WWW::Mechanize->new;
	#$mech->autowrite('/tmp/mech.html');
	$mech->get_ok($url) or exit(1);
	
	my $uid  = 'nonexisting';
	my $pass = 'nonexisting';
	
	my $res = $mech->submit_form(
		'form_number' => 1,
		'fields' => {
			'user' => $uid,
			'pass' => $pass,
		},
	);
	is($res->code, 404, 'check failed login');
	
	$uid  = $ENV{'PAUSE_OpenID_uid'};
	$pass = $ENV{'PAUSE_OpenID_pass'};
	
	SKIP: {
		skip('set PAUSE_OpenID_uid and PAUSE_OpenID_pass to test the successful login', 2)
			if ((not $uid) or (not $pass));
		
		$mech->get_ok($url);
		my $res = $mech->submit_form(
			'with_fields' => {
				'user' => $uid,
				'pass' => $pass,
			},
		);
		is($res->code, 200, 'check passed login');
	}
	
	return 0;
}

