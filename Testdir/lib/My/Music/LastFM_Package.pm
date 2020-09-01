package My::Music::LastFM_Package;
use strict;
use warnings;
use WWW::Mechanize;
use Data::Dump qw(pp);
use JSON 'decode_json';
use Config::Tiny;

our $VERSION = 0.01;

###########################################################################
# not sure why $request_url needs to be exported and the other vars don't #
###########################################################################

# export the Data::Dump pp function and the JSON decode_json funtion

use base 'Exporter';
our @EXPORT_OK = qw(pp decode_json $request_url);
our %EXPORT_TAGS = ( all => \@EXPORT_OK);

our $config_file = "$ENV{HOME}/.lastfm.cnf";
die "$config_file not there" unless -e $config_file;

our $config = Config::Tiny->read($config_file);

our $user    = $config->{lastfm}->{user};
our $api_key = $config->{lastfm}->{api_key};

our $base_url    = "http://ws.audioscrobbler.com/2.0";
our $method_url  = "user.getweeklyartistchart";
our $format      = "json";

our $request_url = "$base_url/?method=$method_url&user=$user&api_key=$api_key&format=$format";

1;
