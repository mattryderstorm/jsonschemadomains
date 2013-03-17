package Services::Roles::Has::Services::Utils;

use Moose::Role;

has utils => (
  isa      => 'Services::Utils',
  is       => 'rw',
  default  => sub { require Services::Utils; Services::Utils->new },
);

1;
