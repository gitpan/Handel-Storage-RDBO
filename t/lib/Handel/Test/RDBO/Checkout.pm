# $Id: /local/Handel-Storage-RDBO/trunk/t/lib/Handel/Test/RDBO/Checkout.pm 1787 2007-06-23T21:05:35.855248Z claco  $
package Handel::Test::RDBO::Checkout;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Checkout/;
};

__PACKAGE__->order_class('Handel::Test::RDBO::Order');

1;
