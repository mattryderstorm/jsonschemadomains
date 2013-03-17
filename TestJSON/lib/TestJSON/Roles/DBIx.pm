package TestJSON::Roles::DBIx;

use Moose::Role;

with 'TestJSON::Roles::UserRoles';

################################################################################
################################################################################

sub restricted_search_rs {
  my ($self, @args) = @_;

  return unless my $search_args = $self->make_restricted_search(@args);

  return $self->search_rs(@$search_args);
}

################################################################################
################################################################################

sub restricted_search {
  my ($self, @args) = @_;

  return unless my $search_args = $self->make_restricted_search(@args);

  return $self->search(@$search_args);
}

################################################################################
################################################################################

# XXX originally copied from DBIx::user_data::ResultSet::clients

sub make_restricted_search {
  my ($self, $user, $search_id) = @_;

  return unless $user;
  return unless my $roles = $self->get_user_roles($user);
  return unless ref $roles and keys %$roles;

  my %search;
  $search_id and $search{'me.id'} = $search_id;

  if ( $roles->{superuser} ) {
  } 
  elsif ( $roles->{reseller} ) {
    $search{'me.reseller_id'} = $user->client->reseller_id;
  } 
  elsif ( $roles->{client} ) {
    $search{'me.client_id'}   = $user->client_id;
    $search{'me.reseller_id'} = $user->client->reseller_id;
  } 
  else {
    return; # do nothing
  }

  return [ \%search ];
}

################################################################################
################################################################################

# XXX copied from DBIx::Common::ResultSet

sub enable_hashrefs {
  my ($self) = @_;

  local $@;

  my $class = 'DBIx::Class::ResultClass::HashRefInflator';
  eval "require $class; 1" and $self->result_class($class);

  return $self;
}

################################################################################
################################################################################

sub id_search {
  my ($self, @args) = @_;

  return $self->search(@args)->search(undef, {columns => ['id']})->enable_hashrefs;
}

################################################################################
################################################################################

1;
