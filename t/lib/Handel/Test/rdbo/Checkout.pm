# $Id: Checkout.pm 1633 2006-12-18 04:07:10Z claco $
package Handel::Test::RDBO::Checkout;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Checkout/;
};

__PACKAGE__->order_class('Handel::Test::RDBO::Order');

1;
