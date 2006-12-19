#!perl -wT
# $Id: pod_syntax.t 1624 2006-12-14 04:35:28Z claco $
use strict;
use warnings;

BEGIN {
    use lib 't/lib';
    use Handel::Test;

    plan skip_all => 'set TEST_POD to enable this test' unless $ENV{TEST_POD};

    eval 'use Test::Pod 1.00';
    plan skip_all => 'Test::Pod 1.00 not installed' if $@;
};

all_pod_files_ok();
