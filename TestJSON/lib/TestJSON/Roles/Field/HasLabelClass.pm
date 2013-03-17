package Services::Roles::Field::HasLabelClass;
use Moose::Role;
has 'label_class' => ( is => 'rw', isa => 'Str' );
1;
