#!perl -wT
# $Id: /local/Handel-Storage-RDBO/trunk/t/cart_save.t 1787 2007-06-23T21:05:35.855248Z claco  $
use strict;
use warnings;

BEGIN {
    use lib 't/lib';
    use Handel::Test;

    eval 'require DBD::SQLite';
    if($@) {
        plan skip_all => 'DBD::SQLite not installed';
    } else {
        plan tests => 26;
    };

    use_ok('Handel::Test::RDBO::Cart');
    use_ok('Handel::Test::RDBO::Cart::Item');
    use_ok('Handel::Constants', ':cart');
    use_ok('Handel::Exception', ':try');
};


## This is a hack, but it works. :-)
my $schema = Handel::Test->init_schema(no_populate => 1);

&run('Handel::Test::RDBO::Cart', 'Handel::Test::RDBO::Cart::Item', 1);

sub run {
    my ($subclass, $itemclass, $dbsuffix) = @_;

    Handel::Test->populate_schema($schema, clear => 1);
    local $ENV{'HandelDBIDSN'} = $schema->dsn;


    ## test for Handel::Exception::Constraint for invalid type
    {
        my $it = $subclass->search({
            id => '11111111-1111-1111-1111-111111111111'
        });
        isa_ok($it, 'Handel::Iterator');
        is($it, 1, 'got 1 cart');

        my $cart = $it->first;
        isa_ok($cart, 'Handel::Test::RDBO::Cart');
        isa_ok($cart, $subclass);

        try {
            local $ENV{'LANG'} = 'en';
            $cart->type('abc');

            fail('no exception thrown');
        } catch Handel::Exception::Constraint with {
            pass('caught constraint exception');
            like(shift, qr/failed database constraint/i, 'failed constraint in message');
        } otherwise {
            fail('caught other exception');
        };
    };


    ## test for Handel::Exception::Constraint for blank name
    {
        my $it = $subclass->search({
            id => '22222222-2222-2222-2222-222222222222'
        });
        isa_ok($it, 'Handel::Iterator');
        is($it, 1, 'got 1 cart');

        my $cart = $it->first;
        isa_ok($cart, 'Handel::Test::RDBO::Cart');
        isa_ok($cart, $subclass);

        try {
            local $ENV{'LANG'} = 'en';
            $cart->name(undef);
            $cart->save;

            fail('no exception thrown');
        } catch Handel::Exception::Constraint with {
            pass('caught constraint exception');
	    like(shift, qr/failed database constraint/i, 'failed constraint in message');
        } otherwise {
            fail('caught other exception');
        };
    };

    ## Load a cart, save it and validate type
    {
        my $it = $subclass->search({
            id => '11111111-1111-1111-1111-111111111111'
        });
        isa_ok($it, 'Handel::Iterator');
        is($it, 1, 'got 1 cart');

        my $cart = $it->first;
        isa_ok($cart, 'Handel::Test::RDBO::Cart');
        isa_ok($cart, $subclass);
        is($cart->type, CART_TYPE_TEMP, 'got temp type');

        $cart->save;

        my $reit = $subclass->search({
            id => '11111111-1111-1111-1111-111111111111'
        });
        isa_ok($reit, 'Handel::Iterator');
        is($reit, 1, 'got 1 cart');

        my $recart = $reit->first;
        isa_ok($recart, 'Handel::Test::RDBO::Cart');
        isa_ok($recart, $subclass);
        is($cart->type, CART_TYPE_SAVED, 'got saved type');
    };

};
