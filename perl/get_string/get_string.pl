#!/usr/bin/perl 

open(IN ,"./file.txt") or die "Can not open file $opt_i: $! \n";

while($line=<IN>){
    chomp($line);
    print "$line\n";
    #if($line=~/^(.*)<.*$/){
    if($line=~/^.*<\s+(\d+).*$/){ #get the 25 in "for(i=0; i < 25 ; i= i+1)"
        print  "$1 \n"; 
    }
}
