package Services::Roles::Form::Results;

use Moose::Role;
use Try::Tiny;

sub get_json_results {
  my ($self) = @_;

  unless ($self->validated) {
    return { errors => $self->get_all_errors };
  }

  my $item = $self->build_item ? { $self->build_item->get_columns } : {};

  return {
    success => 1,
    item    => $item,
  };
}

sub get_all_errors {
  my ($self) = @_;

  my %errors;

  foreach my $field ( $self->fields ) {
    my $errors = $field->errors;
    next unless $errors and ref $errors and @$errors;
    $errors{$field->name} = ref($errors) ? join(', ' => @$errors) : $errors;
  }

  return \%errors;

}


1;
