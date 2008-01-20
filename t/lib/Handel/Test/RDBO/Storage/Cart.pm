# $Id: /local/CPAN/Handel-Storage-RDBO/t/lib/Handel/Test/RDBO/Storage/Cart.pm 1243 2008-01-20T04:05:18.816539Z claco  $
package Handel::Test::RDBO::Storage::Cart;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Storage::RDBO::Cart/;
};

__PACKAGE__->item_storage_class('Handel::Test::RDBO::Storage::Cart::Item');

1;
