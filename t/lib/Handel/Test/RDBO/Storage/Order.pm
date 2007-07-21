# $Id: /local/Handel-Storage-RDBO/trunk/t/lib/Handel/Test/RDBO/Storage/Order.pm 1787 2007-06-23T21:05:35.855248Z claco  $
package Handel::Test::RDBO::Storage::Order;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Storage::RDBO::Order/;
};

__PACKAGE__->item_storage_class('Handel::Test::RDBO::Storage::Order::Item');

1;
