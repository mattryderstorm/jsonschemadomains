package Services::Roles::Has::RPC;

use Moose::Role;

has rpc => (
  isa      => 'Object',
  is       => 'rw',
);

1;
