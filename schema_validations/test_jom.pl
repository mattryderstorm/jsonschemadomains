#!/usr/bin/perl

use JSON::JOM ':all';

$root  = to_jom({});
$child = [ 1,2,3 ];
 
# Add $child to our JOM structure:
$root->{list} = $child;
 
print $root->{list}->count . "\n";  # prints '3'
 
# Now modify $child
push @$child, 4;
 
$root->{list} = $child;
print $root->{list}->count . "\n";  # still '3'!
