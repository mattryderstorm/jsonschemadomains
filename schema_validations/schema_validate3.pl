#!/usr/bin/perl

use strict;
use warnings;
use JSON::Schema;
use DateTime; 
use Data::Dumper;
use Regexp::Common qw[Email::Address];
use Email::Address;
use 5.12.0;
=comment
    {
        properties => {
            'time'       => { type => [ 'DateTime', 'string' ] },
            'teststring' => { type => ['string'] },
            'age' => { type => ['number'] , "description" => ["Age in years"], minium => 0, maximum => 100, },
	    'Dog' => { type => ['string'], "description" => ["Wolf Man"], "pattern" => '^Michael$'},
        },
    });
,

=cut
use JSON;
my $perlvalidation = from_json('{
	  "description" : "Example Contact Information Array JSON Schema",
	  "type" : "array",
	  "items" : {
	    "title" : "A Contact Information object",
	    "type" : "object",
	    "properties" : {
	      "name" : {
	        "type" : "string",
	        "enum" : ["home", "work", "other"]
	      },
	      "phone" : {
	        "type" : "string",
	        "optional" : true,
	        "format" : "phone"
	      },
	      "mobile" : {
	        "type" : "string",
	        "optional" : true,
	        "format" : "phone"
	      },
	      "email" : {
	        "type" : "string"
	      },
 	      "locale" : {
		"type" :"string",
		"description": "locale",
		"enum": ["US","UK","AUS"],	
		"optional": false
	      }
	    },
	    "minItems" : 1,
	    "maxItems" : 5
	  }
	}');
#$perlvalidation->{'items'}->{'properties'}->{'email'}->{'pattern'} = "^hello";
$perlvalidation->{'items'}->{'properties'}->{'email'}->{'pattern'} = "\^$RE{Email}{Address}\$";

my $validator = JSON::Schema->new($perlvalidation);
my $perlscalar = from_json ('[
	  { "name" : "home", "phone" : "+302109349764", "email": "nico@vahlaseu.net"},
	  { "name" : "work", "phone" : "+302108029409", "email": "nvah@instoreg.com"}
]');

=comment
  my $object = {
    'time' => DateTime->now,
     'teststring' => 'hello',
     'age' => 56,
     'Dog' => 'Michael',
  };
=cut
my $result = $validator->validate($perlscalar);

foreach my $error ($result->errors) {
	say sprintf("%s %s",$error->description,$error->message);
}

