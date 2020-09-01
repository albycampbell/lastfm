package My::Number::Test;
use strict;
use warnings;
use Scalar::Util 'looks_like_number';

our $VERSION = 0.01;

sub sum {
  my @numbers = @_;
  my $total   = 0;
  foreach my $val (@numbers) {
    if (  looks_like_number($val)  ) {
    $total += $val;
    return $total;
  }
      else {
       return;
     }
  }
} 
1;
