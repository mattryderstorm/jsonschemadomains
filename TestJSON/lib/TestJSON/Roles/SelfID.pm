package Services::Roles::SelfID;

use Moose::Role;

with 'KiokuDB::Role::ID';
requires 'storage_id';

sub kiokudb_object_id { 
  my ($self) = @_;

  return join ":" => $self->storage_id;
}

sub storage_name {
  my ($self) = @_;
  return unless $self->can('name');

  ( my $name = lc $self->name ) =~ s/[^\s\w\d.]+//gxms;
  $name =~ s/[.]$//;
  return join "_" => split /\s+/ => $name;
}

sub canonical_name { 
  goto &storage_name; 
}

1;
