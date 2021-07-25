#!/usr/bin/perl

use Encode;
use JSON;
use Data::Dumper;

print "test json data...\n";

my $json = new JSON;
my $js ;

if(open(Myfile,"./json_array.html")){
    printf "open json data successfully\n";
    while(<Myfile>){
        $js .= "$_";
    }

    my $obj = $json->decode($js);
    printf Dumper($obj)."\n";

    for my $item(@{$obj->{'pwd'}}){
        print $item->{'g1'}."\n";
    }
}
else
{
    die("open json data failed");
}
