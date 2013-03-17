package TestJSON::Utils;

use 5.12.0;
use Moose;
use String::MkPasswd qw/mkpasswd/;
use POSIX qw//;
use Try::Tiny;
use URI::Escape qw/uri_escape/;
use DateTime::Format::Strptime;

with qw/
  TestJSON::Roles::CamelCase
  TestJSON::Roles::UserRoles
/;

################################################################################
################################################################################

sub row_to_dotted {
  my ($self, %args) = @_;

  my $id   = $args{id} || $args{item}->id;
  my %data = $args{item}->get_columns;

  foreach my $key (keys %data) {
    $data{ "$id.$key" } = delete $data{$key};
  }

  return \%data;
}

################################################################################
################################################################################

sub extract_dotted_fields {
  my ($self, %args) = @_;

  die "missing data argument" unless ref $args{data};

  my $id = $args{id} || $args{item}->id;

  # HTML checkboxes don't send a param name when unchecked, and must be explicitly kept
  my $force_keep = ref $args{force_keep} ? $args{force_keep} : [$args{force_keep}];

  my %result;

  foreach my $column ($args{item}->result_source->columns) {
    next if $column eq 'id';
    ( defined $args{data}->{"$id.$column"} or grep { $_ eq $column } @$force_keep ) and $result{$column} = delete $args{data}->{"$id.$column"};
  }

  return \%result;
}

################################################################################
################################################################################

sub make_control_panel_url {
  my ($self, $domain) = @_;

  my $plesk_client = $domain->plesk_client;

  return sprintf qq{https://%s:8443/login_up.php3?login_name=%s&passwd=%s} => (
    $domain->server->hostname, $plesk_client->username, uri_escape($plesk_client->password), 
  );
}

################################################################################
################################################################################

sub uncamelcase {
  my ($self, $string) = @_;

  $string =~ s/((?<!\A)[A-Z])/'_' . lc($1)/exms; 

  return lcfirst($string);
}

################################################################################
################################################################################

sub camelcase {
  my ($self, $string) = @_;

  $string =~ s/(?:_+([a-z]))/uc($1)/gexms;

  return ucfirst($string);
}

################################################################################
################################################################################

sub schema_to_hashref {
  my ($self, $object) = @_;

  my %hash;

  foreach my $attr ($object->meta->get_all_attributes) {
    my $name     = $attr->name;
    $hash{$name} = $object->$name;
  }

  return \%hash;
}

################################################################################
################################################################################

sub generate_password {
  my ($self) = @_;

  my @rand = grep { not /[Oo1Il]/ } ('A' .. 'Z', 'a' .. 'z', 1 .. 9);

  (my $password = "x" x 8) =~ s/./@rand[rand @rand]/gexms;

  # ensure generated passwords contain at least one digit
  while ($password !~ /\d/) {
    $password =~ s/\w/@rand[rand @rand]/exms;
  }

  return $password;
}

################################################################################
################################################################################

sub generate_domain_password {
  my ($self, $extension) = @_;

  my %config = (
    -length     => 8,
    -minnum     => 2,
    -minlower   => 3,
    -minupper   => 1,
    -minspecial => int( $extension->modulename eq 'VERISIGNreg' ),
  );

  my $password = mkpasswd(%config);

  my @special = qw| ! @ $ % ~ ^ & * ( ) - = _ + [ ] { } < > ? |;

  $password =~ s/['\/\\]/@special[rand @special]/gxms;

  return $password;
}

################################################################################
################################################################################

sub split_phone_number {
  my ($self, $client) = @_;

  my $address = $client->address;

  my $number = $client->mobile || $client->phone;
  $number =~ s/\D+//gxms;

  # FIXME link country codes against new country list
  return (phonecountrycode => '', phoneareacode => '', phonenumber => $number) unless 
  $address->country =~ m/(AUS|Australia)/ and $number =~ m/\A (0[23478]) ( \d{7} ) \z/xms;

  return (phonecountrycode => 61, phoneareacode => $1, phonenumber => $2);
}

################################################################################
################################################################################

sub strftime {
  my ($self, $pattern) = @_;

  return POSIX::strftime($pattern, localtime);
};

################################################################################
################################################################################

sub parse_date {
  my ($self, $string) = @_;

  state $fmt = DateTime::Format::Strptime->new(
    pattern   => '%F',
    time_zone => 'Australia/Melbourne',
  );

  return try { $fmt->parse_datetime($string) };
}

################################################################################
################################################################################

sub parse_datetime {
  my ($self, $string) = @_;

  state $fmt = DateTime::Format::Strptime->new(
    pattern   => '%F %T',
    time_zone => 'Australia/Melbourne',
  );

  return try { $fmt->parse_datetime($string) };
}

################################################################################
################################################################################

1;
