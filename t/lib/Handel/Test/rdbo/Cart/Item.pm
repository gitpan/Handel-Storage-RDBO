# $Id: Item.pm 1633 2006-12-18 04:07:10Z claco $
package Handel::Test::RDBO::Cart::Item;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Cart::Item/;
};

__PACKAGE__->storage_class('Handel::Test::RDBO::Storage::Cart::Item');
__PACKAGE__->create_accessors;

1;
