# $Id: Order.pm 1633 2006-12-18 04:07:10Z claco $
package Handel::Test::RDBO::Storage::Order;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Storage::RDBO::Order/;
};

__PACKAGE__->item_storage_class('Handel::Test::RDBO::Storage::Order::Item');

1;
