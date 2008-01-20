#!perl -wT
# $Id: /local/CPAN/Handel-Storage-RDBO/t/storage_rdbo_columns.t 1243 2008-01-20T04:05:18.816539Z claco  $
use strict;
use warnings;

BEGIN {
    use lib 't/lib';
    use Handel::Test;

    eval 'require DBD::SQLite';
    if($@) {
        plan skip_all => 'DBD::SQLite not installed';
    } else {
        plan tests => 3;
    };

    use_ok('Handel::Storage::RDBO');
};

$ENV{'HandelDBIDSN'} = Handel::Test->init_schema(no_populate => 1)->dsn;

my $storage = Handel::Storage::RDBO->new({
    schema_class    => 'Handel::Schema::RDBO::Cart'
});


## get columns from unconnected schema (really column accessors keys
is_deeply([sort $storage->columns], [qw/description id name shopper type/], 'received expected columns');


## get columns from connected schema
my $schema = $storage->schema_instance;
is_deeply([sort $storage->columns], [sort $schema->meta->columns], 'received expected columns from schema instance');
