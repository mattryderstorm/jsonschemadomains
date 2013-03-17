package TestJSON::View::JSON;

use parent 'Catalyst::View::JSON';
use Moose;

use JSON::XS ();

# before 'process' => sub {
#   my ($self, $c) = @_;
# 
#   if ($c->debug) {
#     $c->log->warn("\$json_data:\n".$c->dump($c->stash->{json_data}, 3));
#   }
# };

sub encode_json {
  my($self, $c, $data) = @_;
  my $encoder = JSON::XS->new->allow_blessed(1)->convert_blessed(0);
  $c->debug and $encoder->pretty(1);
  $encoder->encode($data);
}

=head1 NAME

Services::View::JSON - Catalyst JSON View

=head1 SYNOPSIS

See L<Services>

=head1 DESCRIPTION

Catalyst JSON View.

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

no Moose;
1;
