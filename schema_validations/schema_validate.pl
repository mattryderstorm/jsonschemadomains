#!/usr/bin/perl

use strict;
use warnings;
use JSON::Schema;
use DateTime; 
use Data::Dumper;
#my $validator = JSON::Schema->new({});

my $schema = {
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
	        "type" : "string",
	        "optional" : true,
	        "format" : "email"
	      }
	    },
	    "minItems" : 1,
	    "maxItems" : 5
	  }
	};
