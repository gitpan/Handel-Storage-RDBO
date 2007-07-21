# $Id: /local/Handel-Storage-RDBO/trunk/t/lib/Handel/Test/RDBO/Order/Item.pm 1787 2007-06-23T21:05:35.855248Z claco  $
package Handel::Test::RDBO::Order::Item;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Order::Item/;
};

__PACKAGE__->storage_class('Handel::Test::RDBO::Storage::Order::Item');
__PACKAGE__->create_accessors;

1;
