#!perl -wT
# $Id: order_item_create.t 1909 2007-06-23 21:05:35Z claco $
use strict;
use warnings;

BEGIN {
    use lib 't/lib';
    use Handel::Test;
    use Scalar::Util qw/refaddr/;

    eval 'require DBD::SQLite';
    if($@) {
        plan skip_all => 'DBD::SQLite not installed';
    } else {
        plan tests => 31;
    };

    use_ok('Handel::Test::RDBO::Order');
    use_ok('Handel::Test::RDBO::Order::Item');
    use_ok('Handel::Constraints', 'constraint_uuid');
    use_ok('Handel::Exception', ':try');
};


## test for Handel::Exception::Argument where first param is not a hashref
{
    try {
        my $item = Handel::Order::Item->create(sku => 'FOO');

        fail;
    } catch Handel::Exception::Argument with {
        pass;
    } otherwise {
        fail;
    };
};


## This is a hack, but it works. :-)
my $schema = Handel::Test->init_schema(no_populate => 1);
my $altschema = Handel::Test->init_schema(no_populate => 1, db_file => 'althandel.db', namespace => 'Handel::AltSchema');

&run('Handel::Test::RDBO::Order::Item', 1);

sub run {
    my ($subclass, $dbsuffix) = @_;

    Handel::Test->populate_schema($schema, clear => 1);
    local $ENV{'HandelDBIDSN'} = $schema->dsn;


    ## create a new order item object
    {
        my $data = {
            sku         => 'sku1234',
            price       => 1.23,
            quantity    => 2,
            description => 'My SKU',
            total       => 2.46,
            orderid     => '00000000-0000-0000-0000-000000000000'
        };
        if ($subclass ne 'Handel::Order::Item') {
            #$data->{'custom'} = 'custom';
        };

        my $item = $subclass->create($data);
        isa_ok($item, 'Handel::Order::Item');
        isa_ok($item, $subclass);
        ok(constraint_uuid($item->id));
        is($item->sku, 'sku1234');
        is($item->price+0, 1.23);
        is($item->quantity, 2);
        is($item->description, 'My SKU');
        is($item->total+0, 2.46);
        if ($subclass ne 'Handel::Order::Item') {
            #is($item->custom, 'custom');
        };


        is($item->price->as_string, '1.23 USD');
        is($item->price->as_string('FMT_NAME'), '1.23 US Dollar');
        is($item->total->as_string, '2.46 USD');
        is($item->total->as_string('FMT_NAME'), '2.46 US Dollar');
        {
            local $ENV{'HandelCurrencyCode'} = 'CAD';
            is($item->price->as_string, '1.23 CAD');
            is($item->price->as_string('FMT_NAME'), '1.23 Canadian Dollar');
            is($item->total->as_string, '2.46 CAD');
            is($item->total->as_string('FMT_NAME'), '2.46 Canadian Dollar');
        };
    };

};


## pass in storage instead
{
    my $storage = Handel::Test::RDBO::Order::Item->storage_class->new;
    local $ENV{'HandelDBIDSN'} = $altschema->dsn;

    my $item = Handel::Test::RDBO::Order::Item->create({
        sku         => 'sku1234',
        price       => 1.23,
        quantity    => 2,
        description => 'My Alt SKU',
        orderid     => '00000000-0000-0000-0000-000000000000'
    }, {
        storage => $storage
    });
    isa_ok($item, 'Handel::Test::RDBO::Order::Item');
    ok(constraint_uuid($item->id));
    is($item->sku, 'sku1234');
    is($item->price+0, 1.23);
    is($item->quantity, 2);
    is($item->description, 'My Alt SKU');
    is($item->total+0, 0);
    is(refaddr $item->result->storage, refaddr $storage, 'storage option used');
    is($altschema->resultset('OrderItems')->search({description => 'My Alt SKU'})->count, 1, 'sku found in alt storage');
    is($schema->resultset('OrderItems')->search({description => 'My Alt SKU'})->count, 0, 'sku not in class storage');
};
