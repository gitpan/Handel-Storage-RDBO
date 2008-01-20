# $Id: /local/CPAN/Handel-Storage-RDBO/t/lib/Handel/Test/RDBO/Order/Item.pm 1243 2008-01-20T04:05:18.816539Z claco  $
package Handel::Test::RDBO::Order::Item;
use strict;
use warnings;

BEGIN {
    use base qw/Handel::Order::Item/;
};

__PACKAGE__->storage_class('Handel::Test::RDBO::Storage::Order::Item');
__PACKAGE__->create_accessors;

1;
