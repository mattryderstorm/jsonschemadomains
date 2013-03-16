package TestJSON::View::Email::TT;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
  CATALYST_VAR => 'c',
  INCLUDE_PATH => [
    TestJSON->path_to(qw{ root email }),
    TestJSON->path_to(qw{ root html  }),
  ],
  PRE_PROCESS  => 'config/main',
  INTERPOLATE  => 1,
});

=head1 NAME

Services::View::TT - Catalyst TTSite View

=head1 SYNOPSIS

See L<Services>

=head1 DESCRIPTION

Catalyst TTSite View.

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
