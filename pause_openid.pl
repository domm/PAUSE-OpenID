use strict;
use warnings;

# Returnvalue
return {

    # Catalyst
    name        => 'PAUSE::OpenID',
    
    session => {
        flash_to_stash => 1,
        expires        => 172800,    # two days
        memcached_new_args => {
            data => [ "localhost:11211" ],
            namespace => "pause_openid_session",
        },
    },

    'static' => {
        debug          => 0,
        logging        => 0,
        dirs           => [qw/static/],
    },
   
    'PAUSE::OpenID'=>{
        baseurl=>'https://id.pause.org/',
    },
    
    'ssl' => {
        'ca_dir' => '/etc/ssl/certs/',
    }

};
