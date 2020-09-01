#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';

# import all the functions
use My::Number::Utilities ':all';

my @numbers = qw(3 2 39 7919 997 631 200 7919 459 7919 623 997 867 15);

my @primes = grep { My::Number::Utilities::is_prime($_) } @numbers;

print join ( ',' , sort { $a <=> $b }  @primes );
print "\n";

print meaningless_sub;
print "\n";

print $var;
print "\n";
