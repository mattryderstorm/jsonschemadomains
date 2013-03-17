package Services::Roles::GeneratePassword;

use 5.010;
use Moose::Role;

sub generate_password {
  my ($self, %args) = @_;

  state $default_length = 8;
  my $length = $args{length} || $default_length;

  my @rand = ('A' .. 'Z', 'a' .. 'z', 0 .. 9);
  @rand = grep { not /[Oo1Il0]/ } @rand;
  (my $password = 0 x $length) =~ s/./@rand[rand @rand]/gexms;

  return $password;
}

1;
