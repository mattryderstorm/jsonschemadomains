use strict;
use warnings;

use TestJSON;

my $app = TestJSON->apply_default_middlewares(TestJSON->psgi_app);
$app;

