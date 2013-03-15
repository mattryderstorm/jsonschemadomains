package TestJSON::View::TTWrapped;

use strict;
use base 'Catalyst::View::TT';

use Template::Constants qw( :debug );
use Template::Filters;

my $filters = Template::Filters->new({
  FILTERS => { newline_list => \&newline_list }
});


__PACKAGE__->config({
  CATALYST_VAR => 'c',
  # DEBUG => DEBUG_PARSER | DEBUG_PROVIDER | DEBUG_SERVICE | DEBUG_CONTEXT | DEBUG_PLUGINS | DEBUG_FILTERS | DEBUG_DIRS | DEBUG_CALLER,
  # DEBUG => DEBUG_CONTEXT | DEBUG_DIRS,
  COMPILE_DIR => '/tmp/services_ttwrapped',
  INCLUDE_PATH => [
    TestJSON->path_to(qw{ root html }),
  ],
  LOAD_FILTERS => [ $filters ],
  PRE_PROCESS  => 'config/main',
  WRAPPER      => 'wrapper',
  # ERROR        => 'error',
  TIMER        => 0,
  RECURSION    => 1,
  INTERPOLATE  => 1,
});

sub newline_list {
  my ($string) = @_;

  my @chunks;

  foreach my $line (split /\n/, $string) {
    push @chunks, qq{<li>$line</li>};
  }

  return join "\n", @chunks;
}

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

