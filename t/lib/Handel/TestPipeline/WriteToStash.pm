# $Id: WriteToStash.pm 1910 2007-06-24 02:54:07Z claco $
package Handel::TestPipeline::WriteToStash;
use strict;
use warnings;
use base 'Handel::Checkout::Plugin';
use Handel::Constants qw(:checkout);

sub register {
    my ($self, $ctx) = @_;

    $ctx->add_handler(CHECKOUT_PHASE_INITIALIZE, \&handler);
};

sub handler {
    my ($self, $ctx) = @_;

    $ctx->stash->{'WriteToStash'} = 'WrittenToStash';

    return CHECKOUT_HANDLER_OK;
};

1;
