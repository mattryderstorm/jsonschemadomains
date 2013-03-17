package Services::Roles::Form::UpdateColumns;

use Moose::Role;

after 'update_model' => sub {
  my ($self) = @_;

  my %updates;

  my $admin = $self->admin;
  my $item  = $self->item;

  $item->can('client_id')   and $updates{client_id}   = $self->admin->client_id;
  $item->can('reseller_id') and $updates{reseller_id} = $self->admin->client->reseller_id;

  return keys(%updates) ? $item->update(\%updates) : 1;
};

1;
