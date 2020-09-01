##########################
# last fm weekly artists #
##########################

# top 5 weekly artists to barchart
# not using Last FM cpan module
# updated with show values - numeric value above bar

#!/usr/bin/perl
use strict ;
use warnings ;
use LWP::UserAgent;
use JSON qw(decode_json);
use Config::Tiny;
use POSIX qw (strftime);
use GD::Graph::bars;

my $date = strftime "%e-%b-%Y",localtime;

my $config_file = "$ENV{HOME}/.lastfm.cnf";
die "$config_file not there" unless -e $config_file;

my $config = Config::Tiny->read($config_file);

my $user    = $config->{lastfm}->{user};
my $api_key = $config->{lastfm}->{api_key};
                  
my $base_url    = "http://ws.audioscrobbler.com/2.0";
my $method_url  = "user.getweeklyartistchart";
my $format      = "json";

my $request_url = "$base_url/?method=$method_url&user=$user&api_key=$api_key&format=$format";

# send the request and decode json to perl data structure
# not too much held in memory - no need for content_reference
# or write to disk
my $ua        = LWP::UserAgent->new();
my $request   = $ua->get($request_url);
my $json      = $request->decoded_content;
my $perl_data = decode_json($json);

my (@artists, @playcounts);

# only need the top 5 weekly artists in barchart
my $x = 0;
DATUM:
foreach my $thing ( @{$perl_data->{weeklyartistchart}->{artist} } ) {
$x++;
push (@artists,$thing->{'name'});
push (@playcounts,$thing->{'playcount'});
# exit when 5 is reached
last DATUM if $x == 5;
}

# artists and playcounts to bar chart
# create the layout
my $data  =  GD::Graph::Data->new( [ \@artists,\@playcounts ] );
my $graph =  GD::Graph::bars->new();


$graph->set(
            x_label           => 'ARTISTS',
	    y_label           => 'PLAYCOUNT',
            x_labels_vertical => 1,
            bar_spacing       => 1,
            show_values       => 1,
            title             => "Last.fm data $date",
           ) or die $graph->error;

$graph->plot($data) or die $graph->error;

# barchart to image file
my $file = "LastFM_Weekly_Artists.$date.png";
open (my $picture,'>',$file) or die "Cannot open file $file $!";
binmode $picture;
print $picture $graph->gd->png;
close $picture;
exit;
