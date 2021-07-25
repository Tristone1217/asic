#!/usr/bin/perl -w

use strict;
use Getopt::Std;

use vars qw($opt_d $opt_f $opt_p);
getopts('d:f:p:');

print "\$opt_d =>; $opt_d\n" if $opt_d;
print "\$opt_f =>; $opt_f\n" if $opt_f;
print "\$opt_p =>; $opt_p\n" if $opt_p;

