#!perl -wT
# $Id: order_clear.t 1632 2006-12-18 02:56:33Z claco $
use strict;
use warnings;

BEGIN {
    use lib 't/lib';
    use Handel::Test;

    eval 'require DBD::SQLite';
    if($@) {
        plan skip_all => 'DBD::SQLite not installed';
    } else {
        plan tests => 17;
    };

    use_ok('Handel::Test::RDBO::Order');
    use_ok('Handel::Test::RDBO::Order::Item');
    use_ok('Handel::Constants', ':order');
    use_ok('Handel::Exception', ':try');
};


## This is a hack, but it works. :-)
my $schema = Handel::Test->init_schema(no_populate => 1);

&run('Handel::Test::RDBO::Order', 'Handel::Test::RDBO::Order::Item', 1);

sub run {
    my ($subclass, $itemclass, $dbsuffix) = @_;

    Handel::Test->populate_schema($schema, clear => 1);
    local $ENV{'HandelDBIDSN'} = $schema->dsn;


    ## Clear order contents and validate counts
    {
        my $total_items = $schema->resultset('OrderItems')->count;
        ok($total_items);

        my $it = $subclass->search({
            id => '11111111-1111-1111-1111-111111111111'
        });
        isa_ok($it, 'Handel::Iterator');
        is($it, 1);

        my $order = $it->first;
        isa_ok($order, 'Handel::Order');
        isa_ok($order, $subclass);

        my $related_items = $order->count;
        ok($related_items >= 1);

        $order->clear;
        is($order->count, 0);

        my $reorderit = $subclass->search({
            id => '11111111-1111-1111-1111-111111111111'
        });
        isa_ok($reorderit, 'Handel::Iterator');
        is($reorderit, 1);

        my $reorder = $reorderit->first;
        isa_ok($reorder, 'Handel::Order');
        isa_ok($reorder, $subclass);

        is($reorder->count, 0);

        my $remaining_items = $schema->resultset('OrderItems')->count;
        is($remaining_items, $total_items - $related_items);
    };

};
