# $Id: Item.pm 1909 2007-06-23 21:05:35Z claco $
package Handel::Test::RDBO::Cart::Item;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Cart::Item/;
};

__PACKAGE__->storage_class('Handel::Test::RDBO::Storage::Cart::Item');
__PACKAGE__->create_accessors;

1;
