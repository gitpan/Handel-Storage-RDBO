# $Id: /local/CPAN/Handel-Storage-RDBO/t/lib/Handel/Test/RDBO/Checkout.pm 1243 2008-01-20T04:05:18.816539Z claco  $
package Handel::Test::RDBO::Checkout;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Checkout/;
};

__PACKAGE__->order_class('Handel::Test::RDBO::Order');

1;
