package Services::Roles::Has::Actions;

use Moose::Role;

has 'actions_object' => (
  isa     => 'Services::Actions',
  is      => 'rw',
  handles => {
    client_actions   => 'clients',
    reseller_actions => 'resellers',
    user_actions     => 'users',
    signup_actions   => 'signups',
    email_actions    => 'email',
    database_actions => 'databases',
    alias_actions    => 'aliases',
    domain_actions   => 'domains',
    finance_actions  => 'finance',
  },
);

1;
