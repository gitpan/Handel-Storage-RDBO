#!perl -wT
# $Id: /local/CPAN/Handel-Storage-RDBO/t/style_no_tabs.t 1243 2008-01-20T04:05:18.816539Z claco  $
use strict;
use warnings;
use lib 't/lib';
use Handel::Test;

plan skip_all => 'set TEST_AUTHOR to enable this test' unless $ENV{TEST_AUTHOR};

eval 'use Test::NoTabs 0.03';
plan skip_all => 'Test::NoTabs 0.03 not installed' if $@;

all_perl_files_ok('lib');
