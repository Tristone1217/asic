#!/usr/bin/perl -w

use strict;
use Getopt::Std;

use vars qw($opt_i $opt_o);
getopts('i:o:');

print "\$opt_i =>; $opt_i\n" if $opt_i;  
print "\$opt_o =>; $opt_o\n" if $opt_o;

#read  the para in  the default para, and judge whether it is in the para.txt

#read the  file line by line
open(IN ,"<$opt_i") or die "Can not open file $opt_i: $! \n";
open(OUT,"+<$opt_o") or die "Can not open file $opt_o: $! \n";

my $i=0;
my $j=0;

my $linenum=system("wc -l $opt_o"); 
while(<IN>){
    #print;
    $i=$i+1;
    print "i=$i\n";
    my $desstring;
    if(/^([\d\w\_]+)($|\=)/) {
        $desstring=$1;
        print "string in input file=$desstring\n";    
        while(<OUT>){
            $j=$j+1;
            print "j=$j\n";
            print "string in output file = $desstring\n";
            #            if(/^(\Q$desstring\E)($|\=)/) {
            #                #print "the string is \$1= $1\n"
            #}
            if($j>$linenum) {
                last;
            }
        }
    }
}

close(IN);
close(OUT);
