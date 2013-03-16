package TestJSON::View::Email::Template;

use strict;
use base 'Catalyst::View::Email::Template';

__PACKAGE__->config(
  stash_key       => 'email_template',
  template_prefix => '',

  sender => {
    mailer => $ENV{EMAIL_SEND_MAILER} || 'SMTP',
  },

  default => {
    content_type => 'multipart/alternative',
    view         => 'Email::TT',
  },
);

=head1 NAME

Services::View::Email::Template - Templated Email View for Services

=head1 DESCRIPTION

View for sending template-generated email from Services. 

=head1 AUTHOR

,,,

=head1 SEE ALSO

L<Services>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

