use strict;
use warnings;
use Module::Build;
use 5.010;

my $builder = Module::Build->new(
    module_name       => 'PAUSE-OpenID',
    license           => 'perl',
    dist_author       => 'Vienna.pm',
    dist_version_from => 'lib/PAUSE/OpenID.pm',
    build_requires    => { 'Test::More' => 0, },
    requires          => {
        'perl'                => '5.010',
        'Catalyst::Runtime'   => '5.7014',
        'Net::OpenID::Server' => '1.02',
    },
    add_to_cleanup       => ['PAUSE-OpenID-*'],
    create_makefile_pl   => 'passthrough',
    recursive_test_files => 1,
);

$builder->create_build_script();
