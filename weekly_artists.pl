##########################
# last fm weekly artists #
##########################

#!/usr/bin/perl
use strict ;
use warnings ;
use LWP::UserAgent;
use JSON;
use Config::Tiny;
use Data::Dumper;

# username and api_key in .lastfm.cnf configuration file - home directory

my $config_file = "$ENV{HOME}/.lastfm.cnf";
die "$config_file not there" unless -e $config_file;

my $config = Config::Tiny->read($config_file);

my $user    = $config->{lastfm}->{user};
my $api_key = $config->{lastfm}->{api_key};
                  
my $url = "http://ws.audioscrobbler.com/2.0/?method=user.getweeklyartistchart&user=$user&api_key=$api_key&format=json";

my $ua = LWP::UserAgent->new();
my $data = $ua->get($url);
my $json = $data->decoded_content;
my $perl_data_structure = decode_json($json);

print Dumper ($perl_data_structure),"\n";

exit ;
