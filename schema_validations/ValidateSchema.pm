package ValidateSchema;

use Moose;
use JSON;
use JSON::Schema;

has 'params' => (
	isa => 'HashRef',
	is => 'ro',
);

has 'file' => (
	isa => 'IO::File',
	is => 'ro'
);

before 'file' => (

);
after 'params' => (
	my $self = shift;
	
	if ($

	return $validate;	
);
1;
