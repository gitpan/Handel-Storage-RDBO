#!perl -wT
# $Id: /local/Handel-Storage-RDBO/trunk/t/storage_rdbo_columns.t 1787 2007-06-23T21:05:35.855248Z claco  $
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
