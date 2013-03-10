#!/usr/bin/perl

use JSON::Path;
use Data::Dumper;
my $data = {
  "store" => {
    "book" => [ 
      { "category" =>  "reference",
        "author"   =>  "Nigel Rees",
        "title"    =>  "Sayings of the Century",
        "price"    =>  8.95,
      },
      { "category" =>  "fiction",
        "author"   =>  "Evelyn Waugh",
        "title"    =>  "Sword of Honour",
        "price"    =>  12.99,
      },
      { "category" =>  "fiction",
        "author"   =>  "Herman Melville",
        "title"    =>  "Moby Dick",
        "isbn"     =>  "0-553-21311-3",
        "price"    =>  8.99,
	"related_tasks" => {
		"wonder1" => "Wonde1r",
		"wonder2" => "Wonde1r",
		"wonder3" => "Wonde1r",
	},
      },
      { "category" =>  "fiction",
        "author"   =>  "J. R. R. Tolkien",
        "title"    =>  "The Lord of the Rings",
        "isbn"     =>  "0-395-19395-8",
        "price"    =>  22.99,
      },
    ],
    "bicycle" => [
      { "color" => "red",
        "price" => 19.95,
      },
    ],
  },
 };

my $jpath;
 # All books in the store
#$jpath   = JSON::Path->new('$.store.book[*].related_tasks');
#my @books   = $jpath->values($data);
#print Dumper(\@books);
 # The author of the last (by order) book
#$jpath   = JSON::Path->new('$..book[-1:].author');
#my $tolkien = $jpath->value($data);
#print Dumper($tolkien);
# Convert all authors to uppercase
my $object; 
jpath_map { uc $_ }, $object, '$.store.book[*].title';
