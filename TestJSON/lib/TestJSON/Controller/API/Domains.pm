package TestJSON::Controller::API::Domains;

use parent 'Catalyst::Controller::REST';
use Scalar::Util qw/blessed/;
use DBIx::Class::ResultClass::HashRefInflator;
use Data::Dumper;

__PACKAGE__->config(
  default   => 'application/json',
  stash_key => 'rest',
  map       => { 'application/json' => 'JSON' },
);

################################################################################
################################################################################

sub auto :Private {
  my ($self, $c) = @_;

  my $user_exists = $c->forward('process_auth');
  my $is_admin    = $c->check_roles('reseller') || $c->check_roles('superuser');
  my $is_reseller = $user_exists && $is_admin;

  # $c->log->warn("process_auth: $is_reseller");

  unless ($is_reseller) {
    $self->status_bad_request($c, message => 'Invalid auth information.');
    return 0;
  }

  return 1;
}

################################################################################
################################################################################

sub process_auth :Private {
  my ($self, $c) = @_;

  return 1 if $c->user_exists;

  my %login = (
    email    => $c->req->header('x-email'),
    password => $c->req->header('x-password'),
  );

  $c->forward(Login => verify_login => [undef, %login]);

  return $c->user_exists;
}

################################################################################
################################################################################

1;
