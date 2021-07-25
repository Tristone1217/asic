#!/usr/bin/perl -w


#description: update_para.pl -i inputfile -o outputfile


use strict;
use Getopt::Std;





use vars qw($opt_i $opt_o);
getopts('i:o:');

#print "\$opt_i =>; $opt_i\n" if $opt_i;  
#print "\$opt_o =>; $opt_o\n" if $opt_o;

#read  the para in  the default para, and judge whether it is in the para.txt

#read the  file line by line
open(IN ,"<$opt_i") or die "Can not open file $opt_i: $! \n";
open(OUT,"+<$opt_o") or die "Can not open file $opt_o: $! \n";


my @linelist0=<IN>;  # put the value of the input file to the array

my $line0;

$^|=".bak";

while(<OUT>){
    my $desstring;
    my $exsit=0;
    if(/^([\d\w\_]+)($|\=)/) {  #get the parameter in the para.txt
        $desstring=$1;
        foreach $line0(@linelist0){
            if($line0=~/^(\Q$desstring\E)($|\=)/) {  #judge whether the parameter is in the default para file
                $exsit=1;
            }
        }
        if($exsit==0){
            print "delete parameter: $_\n";
            system("sed -i /$desstring/d $opt_o");  #delete the string not exsit in the default_para.txt

        }
    }
}

close(IN);
close(OUT);
