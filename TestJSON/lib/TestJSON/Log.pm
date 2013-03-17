package TestJSON::Log;

use base 'Catalyst::Log';
use constant VERBOSE => $ENV{SERVICES_DEBUG};

our $CALLER;

sub debug {
  my ( $self, $text ) = @_;
  if (VERBOSE) { $CALLER = sprintf '%s #%d: ', (caller(1))[3, 2] }
  $self->SUPER::debug( $CALLER . $text );
}

sub info {
  my ( $self, $text ) = @_;
  if (VERBOSE) { $CALLER = sprintf '%s #%d: ', (caller(1))[3, 2] }
  $self->SUPER::info( $CALLER . $text );
}

sub warn {
  my ( $self, $text ) = @_;
  if (VERBOSE) { $CALLER = sprintf '%s #%d: ', (caller(1))[3, 2] }
  $self->SUPER::warn( $CALLER . $text );
}

sub error {
  my ( $self, $text ) = @_;
  if (VERBOSE) { $CALLER = sprintf '%s #%d: ', (caller(1))[3, 2] }
  $self->SUPER::error( $CALLER . $text );
}

sub fatal {
  my ( $self, $text ) = @_;
  if (VERBOSE) { $CALLER = sprintf '%s #%d: ', (caller(1))[3, 2] }
  $self->SUPER::fatal( $CALLER . $text );
}

1;
