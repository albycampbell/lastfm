
################################
# Mechanize to get LastFM data #
################################

#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';
use My::Music::LastFM_Package ':all';

my $ua = WWW::Mechanize->new();
$ua->get($request_url);
die "Cannot get the data" unless $ua->success;

my $perl_data = decode_json($ua->content);
pp ($perl_data);  
exit;
