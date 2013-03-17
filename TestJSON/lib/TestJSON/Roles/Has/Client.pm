package TestJSON::Roles::Has::Client;

use Moose::Role;

has client => (
  isa      => 'DBIx::user_data::Schema::clients',
  is       => 'rw',
  handles  => { client_id => 'id' },
);

has client_config => (
  isa => 'Object',
  is  => 'rw',
);

1;
