# $Id: Cart.pm 1909 2007-06-23 21:05:35Z claco $
package Handel::Test::RDBO::Storage::Cart;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Storage::RDBO::Cart/;
};

__PACKAGE__->item_storage_class('Handel::Test::RDBO::Storage::Cart::Item');

1;
