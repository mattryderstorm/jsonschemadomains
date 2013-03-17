package TestJSON::Roles::Has::User;

use Moose::Role;

has user => (
  isa      => 'Any',
  is       => 'rw',
  handles  => { user_id => 'id' },
);

1;
