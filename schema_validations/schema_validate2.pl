#!/usr/bin/perl

use strict;
use warnings;
use JSON::Schema;
use DateTime; 
use Data::Dumper;
my $validator = JSON::Schema->new(
    {
        properties => {
            'time'       => { type => [ 'DateTime', 'string' ] },
            'teststring' => { type => ['string'] },
            'age' => { type => ['number'] , "description" => ["Age in years"], minium => 0, maximum => 100, },
	    'Dog' => { type => ['string'], "description" => ["Wolf Man"], "pattern" => '^Michael$'},
        },
    });

  my $object = {
    'time' => DateTime->now,
     'teststring' => 'hello',
     'age' => 56,
     'Dog' => 'Michael',
  };

  my $result = $validator->validate($object);
print Dumper($result);
