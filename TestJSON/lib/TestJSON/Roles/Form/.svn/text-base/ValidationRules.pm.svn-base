package Services::Roles::Form::ValidationRules;

# converts HTML::FormHandler cfg into jQuery.validate cfg

use 5.10.0;
use Moose::Role;

sub get_validation_config {
  my ($self) = @_;

  my ( %fields, %messages );

  my @dependents = @{ $self->dependency || [] };

  foreach my $field ($self->fields) {
    my $name = $field->name;
    my $cfg  = ( $fields{$name} ||= {} );

    foreach my $attr (qw/required minlength maxlength/) {
      next unless $field->meta->find_attribute_by_name($attr) and $field->$attr;
      $cfg->{$attr} = $field->$attr;
    }

    given (lc $field->type) {
      when ('email') { $cfg->{email} = 1 }
      when ('integer') { $cfg->{digits} = 1 }
    }
  }

  return {
    rules      => \%fields,
    messages   => \%messages,
    errorClass => 'ui-state-error',
  };
}

1;
