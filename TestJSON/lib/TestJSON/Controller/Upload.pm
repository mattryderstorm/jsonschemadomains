package TestJSON::Controller::Upload;
use Moose;
use namespace::autoclean;
use jQuery::File::Upload;
use JSON;
use Data::Dumper;
BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

TestJSON::Controller::upload - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

__PACKAGE__->config(
    default      => 'application/json',
    default_view => 'JSON',
    map          => { 'application/json' => 'JSON' },
);

=head2 index

=cut

sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
	if ($c->req->method eq 'POST') {
	    my $j_fu = jQuery::File::Upload->new;
	    $j_fu->ctx($c);
	    $j_fu->handle_request(1);
	    $c->forward('View::JSON');
	}
}

=head1 AUTHOR

mattryder,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
