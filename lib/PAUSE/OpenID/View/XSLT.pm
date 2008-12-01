package PAUSE::OpenID::View::XSLT;

use strict;
use base 'Catalyst::View::XSLT';

# example configuration

__PACKAGE__->config(
   # relative paths to the directories with templates
	INCLUDE_PATH => [
		PAUSE::OpenID->path_to( 'root', 'templates' ),
	],
	TEMPLATE_EXTENSION => '.xsl', # default extension when getting template name from the current action
	DUMP_CONFIG => 1, # use for Debug. Will dump the final (merged) configuration for XSLT view
	#LibXSLT => { # XML::LibXSLT specific parameters
	#	register_function => [
	#		{
	#			uri => 'urn:catalyst',
	#			name => 'Hello',
	#			subref => sub { return $_[0] },
	#		}
	#	],
	#},
);
																																																		
=head1 NAME

PAUSE::OpenID::View::XSLT - XSLT View Component

=head1 SYNOPSIS

	See L<PAUSE::OpenID>

=head1 DESCRIPTION

Catalyst XSLT View.

=head1 AUTHOR

Michael Kr�ll,,,

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
