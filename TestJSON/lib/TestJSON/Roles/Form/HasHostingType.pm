package Services::Roles::Form::HasHostingType;

use HTML::FormHandler::Moose::Role;

has_field hosting_type => (
  type     => 'Select',
  required => 1,
  css_class => 'medium',
);

sub options_hosting_type {
  return (
    ''       => '',
    plesk    => 'Plesk hosting',
    dns      => 'DNS only',
    colo     => 'Colo',
    vps      => 'VPS',
    internal => 'Internal',
  );
}

no HTML::FormHandler::Moose::Role;
1;
