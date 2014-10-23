# $Id: /local/CPAN/Handel-Storage-RDBO/t/lib/Handel/Checkout/Plugin/TestBogusPlugin.pm 1243 2008-01-20T04:05:18.816539Z claco  $
package Handel::Checkout::Plugin::TestBogusPlugin;
use strict;
use warnings;
use Handel::Constants qw(:checkout);

sub new {

};

sub register {
    my ($self, $ctx) = @_;

    $self->{'register_called'}++;
    $ctx->add_handler(CHECKOUT_PHASE_INITIALIZE, \&handler);
};

sub init {
    my ($self, $ctx) = @_;

    $self->{'init_called'}++;
};

sub setup {
    my ($self, $ctx) = @_;

    $self->{'setup_called'}++;
};

sub teardown {
    my ($self, $ctx) = @_;

    $self->{'teardown_called'}++;
};

sub handler {
    my ($self, $ctx) = @_;

    $self->{'handler_called'}++;
};

1;