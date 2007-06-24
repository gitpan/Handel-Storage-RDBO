# $Id: Checkout.pm 1909 2007-06-23 21:05:35Z claco $
package Handel::Test::RDBO::Checkout;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Checkout/;
};

__PACKAGE__->order_class('Handel::Test::RDBO::Order');

1;
