package TestJSON::Controller::Baz;
 
use Moose;
use namespace::autoclean;
 
BEGIN { extends 'Catalyst::Controller::ActionRole' }
 
__PACKAGE__->config(
#    action_roles => [qw( Foo )],
    action       => {
        some_action    => { Does => [qw( Bar )] },
        another_action => { Does => [qw( Foo )] },
    },
    action_args  => {
        another_action => { customarg => 'arg1' },
    }
);
 
# has Catalyst::ActionRole::Foo and MyApp::ActionRole::Bar applied
sub some_action : Local { ... }
 
# has Catalyst::ActionRole::Foo and MyActionRole::Baz applied
# and associated action class would get additional arguments passed
sub another_action : Local { ... }
