package TestJSON::HTTPRequest;

use 5.12.0;
use Moose;
use Data::UUID;

extends 'Catalyst::Request::REST';

has 'uuid' => (
  isa        => 'Str',
  is         => 'ro',
  lazy_build => 1,
);

sub _build_uuid {
  state $uuid = Data::UUID->new;

  return $uuid->create_str;
}

sub short_uuid {
  my ($self) = @_;

  return substr( $self->uuid, 0, 13 );
}

sub is_post { shift()->method eq 'POST' }
sub is_get  { shift()->method eq 'GET'  }

no Moose;

1;
