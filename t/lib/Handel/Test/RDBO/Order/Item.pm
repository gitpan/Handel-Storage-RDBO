# $Id: Item.pm 1909 2007-06-23 21:05:35Z claco $
package Handel::Test::RDBO::Order::Item;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Order::Item/;
};

__PACKAGE__->storage_class('Handel::Test::RDBO::Storage::Order::Item');
__PACKAGE__->create_accessors;

1;
