# $Id: /local/Handel-Storage-RDBO/trunk/t/lib/Handel/Test/RDBO/Order.pm 1787 2007-06-23T21:05:35.855248Z claco  $
package Handel::Test::RDBO::Order;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Order/;
};

__PACKAGE__->storage_class('Handel::Test::RDBO::Storage::Order');
__PACKAGE__->item_class('Handel::Test::RDBO::Order::Item');
__PACKAGE__->cart_class('Handel::Test::RDBO::Cart');
__PACKAGE__->checkout_class('Handel::Test::RDBO::Checkout');
__PACKAGE__->create_accessors;

1;
