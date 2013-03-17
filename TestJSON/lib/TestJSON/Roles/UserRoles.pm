package TestJSON::Roles::UserRoles;

use 5.10.0;
use Moose::Role;

# DBIx::user_data::Schema::users->roles returns role objects,
# and Catalyst's user object returns role names

# FIXME 
# copied from package DBIx::Common::ResultSet
# make the resultset point here somehow?
# maybe by using moose in the DBIC classes

sub get_privilege_type {
  my ($self, $user) = @_;
  return unless my $roles = $self->get_user_roles($user);

  foreach my $level (qw/superuser admin user/) {
    $roles->{$level} and return $level;
  }

  return;
}

sub get_user_roles {
  my ($self, $user) = @_;

  my %roles;

  foreach my $role ($user->roles) {
    my $name = blessed($role) ? $role->role : $role;
    $roles{$name} = 1;
  }

  # return unless $self->verify_roles( $user, %roles );
  return \%roles;
}

sub verify_roles {
  my ($self, $user, %roles) = @_;

  my $warn = sub {
    warn sprintf "verify_roles(%s) error: %s\n", $user->email, shift
  };

  unless ( $roles{superuser} or $roles{reseller} or $roles{client} ) {
    $warn->('not superuser, reseller, or client');
  }

  unless ( $roles{admin} or $roles{user} ) {
    $warn->('not admin or user');
  }

  return 1;
}

1;
