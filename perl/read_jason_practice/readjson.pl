#!/usr/bin/perl 

use Encode;
use JSON;
use Data::Dumper;

print "Read json data...\n";

my $json = new JSON;
my $js;


if(open(MYFILE, "./json.html"))
{
    print "Read json data successfully\n";
    while(<MYFILE>)
    {
        $js .= "$_";
    }
}
else
{
    print "Read json data failed\n";
}

my $obj = $json->decode($js);
print "json data is:".Dumper($obj);
print "$obj->{'uns'}\n";
close(MYFILE);
