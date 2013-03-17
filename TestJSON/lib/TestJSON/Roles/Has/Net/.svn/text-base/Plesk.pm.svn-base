package Services::Roles::Has::Net::Plesk;

use Moose::Role;
use Scalar::Util qw/blessed/;
use namespace::clean -except => 'meta';

BEGIN {
  use constant SERVICES_PLESK_DEBUG => $ENV{SERVICES_PLESK_DEBUG};
};

################################################################################
################################################################################

has net_plesk => (
  isa      => 'Net::Plesk',
  is       => 'rw',
);

################################################################################
################################################################################

sub extract_plesk_result {
  my ($self, $result) = @_;

  if (SERVICES_PLESK_DEBUG) {
    require Data::Dumper;
    warn Data::Dumper->new([$result],['plesk_result'])->Dump;
  }

  return unless blessed $result and $result->is_success;
  return unless my @array = $result->results;

  my ($struct) = @array;
  return unless ref $struct;
  return $struct;
}

################################################################################
################################################################################

sub extract_plesk_result_id {
  my ($self, $result) = @_;

  my ($results) = $self->extract_plesk_result($result);

  return unless ref $results eq 'HASH';
  return unless $results->{id};
}

################################################################################
################################################################################

sub plesk_result_ok {
  my ($self, $result) = @_;

  $result = $self->extract_plesk_result($result);

  return ref $result eq 'HASH' && $result->{status} eq 'ok';
}

################################################################################
################################################################################


1;
