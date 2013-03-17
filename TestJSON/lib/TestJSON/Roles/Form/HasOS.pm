package Services::Roles::Form::HasOS;

use HTML::FormHandler::Moose::Role;

has_field os => (
  type     => 'Select',
  label    => 'OS',
  label_class => 'medium',
  required => 1,
);

sub options_os {
  return (
    ''      => '',
    linux   => 'Linux',
    windows => 'Windows',
  );
}

no HTML::FormHandler::Moose::Role;
1;
