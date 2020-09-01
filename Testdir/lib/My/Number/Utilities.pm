package My::Number::Utilities;
use strict;
use warnings;

our $VERSION = 0.02;

use base 'Exporter';
our @EXPORT_OK = qw(is_prime meaningless_sub $var);
our %EXPORT_TAGS = ( all => \@EXPORT_OK);


sub is_prime {
  my $number = $_[0];
  return if $number < 2;
  return 1 if $number == 2;
  for ( 2 .. int sqrt ($number) ) {
    return if !($number % $_);
  }
  return 1;
}

# immutable value in a subroutine
# meaningless - but '100' cannot be changed with script

sub meaningless_sub { 100 };

# and this...
# a pointless var that gets printed in the .pl file
# simply by; print $var
# it has to be our $var in this package
# otherwise the script will complain if it is; my $var
# our $var in the package allows it to be shared in other packages/scripts

our $var = 'Hello';

1;
