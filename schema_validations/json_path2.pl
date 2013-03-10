use 5.12.0;
use JSON::Path;
use JSON;
use Test;
my $object = from_json(q'
{
"store": {
"book": [
{
"category": "reference",
"author": "Nigel Rees",
"title": "Sayings of the Century",
"price": 8.95
},
{
"category": "fiction",
"author": "Evelyn Waugh",
"title": "Sword of Honour",
"price": 12.99
},
{
"category": "fiction",
"author": "Herman Melville",
"title": "Moby Dick",
"isbn": "0-553-21311-3",
"price": 8.99
},
{
"category": "fiction",
"author": "J. R. R. Tolkien",
"title": "The Lord of the Rings",
	"newtest" : {
		"test1":"test2",
		"test2":"test3"
	},
"isbn": "0-395-19395-8",

"price": 22.99
}
],
"bicycle": {
"color": "red",
"price": 19.95
}
}
}
');
=comment
	"newtest" : {
		"test1":"test2",
		"test2":"test3",
	},
=cut
use Data::Dumper;
use JSON::Path 'jpath_map';
#jpath_map { say "booyah" if defined($_->{'newtest'}) } $object, '$.store.book[*]';
#jpath_map { say Dumper($_) } $object, '$.store.book[*].author';
jpath_map { say "boo".$_->{'author'} if (defined($_->{'newtest'})) } $object, '$.store.book[*]';
