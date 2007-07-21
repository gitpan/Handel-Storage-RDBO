# $Id: /local/Handel-Storage-RDBO/trunk/t/lib/Handel/Test/RDBO/Cart/Item.pm 1787 2007-06-23T21:05:35.855248Z claco  $
package Handel::Test::RDBO::Cart::Item;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Cart::Item/;
};

__PACKAGE__->storage_class('Handel::Test::RDBO::Storage::Cart::Item');
__PACKAGE__->create_accessors;

1;
