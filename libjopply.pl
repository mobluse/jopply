#!/usr/bin/perl
# Jopply 2015-06-28 by M.O.B. as Perl command-line application.
# Copyright (C) 2015 by Mikael O. Bonnier, Lund, Sweden.
# License: GNU AGPL v3 or later, https://gnu.org/licenses/agpl-3.0.txt
# ABSOLUTELY NO WARRANTY.
# Donations are welcome to PayPal mikael.bonnier@gmail.com.
# The source code is at https://github.com/mobluse/jopply/
# You can follow me on Twitter as @mobluse, https://twitter.com/mobluse/
#
# It was developed in Raspbian on Raspberry Pi 2.
#
# Revision history:
# 2015-Jun: Alpha versions.
#
# Suggestions, improvements, and bug-reports
# are always welcome to:
# Mikael Bonnier
# Osten Undens gata 88
# SE-227 62 LUND
# SWEDEN
#
# Or use my internet addresses:
# mikael.bonnier@gmail.com
# http://www.df.lth.se.orbin.se/~mikaelb/
#              _____
#             /   / \
# ***********/   /   \***********
#           /   /     \
# *********/   /       \*********
#         /   /   / \   \
# *******/   /   /   \   \*******
#       /   /   / \   \   \
# *****/   /   /***\   \   \*****
#     /   /__ /_____\   \   \
# ***/               \   \   \***
#   /_________________\   \   \
# **\                      \  /**
#    \______________________\/
#
# Mikael Bonnier
######################################################################

my $encoding = fix_encoding();
$Data::Dumper::Useqq = 1;

{
    no warnings 'redefine';

    sub Data::Dumper::qquote {
        my $s = shift;

        #return "'$s'"
        return "'" . ansi2utf8($s) . "'";
    }
}

my $help                = 0;
my $man                 = 0;
my $verbose             = 0;
my $nyckelord           = '';
my $lanid               = '';
my $has_epostadress     = '';
my $has_webbplats       = '';
my $annonsid            = '';
GetOptions(
    'help|?'                => \$help,
    man                     => \$man,
    verbose                 => \$verbose,
    epostadress             => \$has_epostadress,
    webbplats               => \$has_webbplats,
    'annonsid=s'            => \$annonsid,
    'nyckelord|keyword=s'   => \$nyckelord,
    'kommunid:i'            => \$kommunid,
    'yrkesid:i'             => \$yrkesid,
    'organisationsnummer=s' => \$organisationsnummer,
    'yrkesgruppid:i'        => \$yrkesgruppid,
    'yrkesomradeid:i'       => \$yrkesomradeid,
    'landid:i'              => \$landid,
    'lanid:i'               => \$lanid,
    'anstallningstyp=s'     => \$anstallningstyp,
    'omradeid:i'            => \$omradeid,
) or pod2usage(2);

if ($man) {
    pod2usage( -exitval => 0, -verbose => 2 );
}
if (   ( $help || !$nyckelord )
    && !$annonsid
    && !( $lanid ne '' && $lanid == 0 )
    && !( $lanid > 0 && $kommunid ne '' && $kommunid == 0 ) )
{
    pod2usage(1);
}

$nyckelord = join( ' ', split( /,/, $nyckelord ) );
$nyckelord = uri_esc($nyckelord);

our $xurl = url_new();
my $URL = "http://api.arbetsformedlingen.se/af/v0/platsannonser";
our $response_body;
our $retcode;
my $decoded_json;
mkdir ad;
if ($annonsid) {
    $response_body = get_ad($annonsid);
    $decoded_json  = decode_json($response_body);
    print Dumper $decoded_json;
    exit 0;
}
if ( $lanid ne '' && $lanid == 0 ) {
    $response_body = url_get("$URL/soklista/lan");
    $decoded_json  = decode_json($response_body);

    #print(Dumper $decoded_json);
    for my $elem ( @{ $decoded_json->{'soklista'}{'sokdata'} } ) {
        printf "%2d; %s; %d\n", $elem->{id},
                                ansi2utf8( $elem->{namn} ),
                                $elem->{antal_platsannonser};
    }
    exit 0;
}
if ( $lanid > 0 && $kommunid ne '' && $kommunid == 0 ) {
    $response_body = url_get("$URL/soklista/kommuner?lanid=$lanid");
    $decoded_json  = decode_json($response_body);

    #print(Dumper $decoded_json);
    for my $elem ( @{ $decoded_json->{'soklista'}{'sokdata'} } ) {
        printf "%4d; %s; %d\n", $elem->{id},
                                 ansi2utf8( $elem->{namn} ),
                                 $elem->{antal_platsannonser};
    }
    exit 0;
}

$response_body = url_get(
      "$URL/matchning?lanid=$lanid&kommunid=$kommunid"
    . "&nyckelord=$nyckelord&antalrader=9999" );
$decoded_json = decode_json($response_body);
if ( $decoded_json->{Error} ) {
    print Dumper $decoded_json;
    exit 0;
}

if ( !$decoded_json->{'matchningslista'}{'antal_sidor'} ) {
    exit 1;
}
my $total    = 0;
my $line     = 0;
my $annonser = $decoded_json->{'matchningslista'}{'matchningdata'};
for my $elem ( @{ $decoded_json->{'matchningslista'}{'matchningdata'} } ) {
    ++$total;
    if ( $has_epostadress || $has_webbplats ) {
        sleep 0.2;
        $response_body = get_ad($elem->{'annonsid'});
        $decoded_json  = decode_json($response_body);
        my $epostadress
            = $decoded_json->{'platsannons'}{'ansokan'}{'epostadress'};
        my $webbplats
            = $decoded_json->{'platsannons'}{'ansokan'}{'webbplats'};

        # According to the specification webbplats should be webbadress.
        my $b_line = 0;
        if ( $has_epostadress && $epostadress ) {
            $b_line = 1;
            ++$line;
            print "$line; $elem->{'annonsid'}; $epostadress";
        }
        if ( $has_webbplats && $webbplats ) {
            $webbplats = ansi2utf8($webbplats);
            if ($b_line) {
                print "; $webbplats\n";
            }
            else {
                $b_line = 1;
                ++$line;
                print "$line; $elem->{'annonsid'}; ; $webbplats\n";
            }
        }
        else {
            if ($b_line) {
                print("\n");
            }
        }
        if ( $b_line && $verbose ) {
            print Dumper $elem;
            print Dumper $decoded_json->{'platsannons'}{'ansokan'};
        }
    }
    else {
        ++$line;
        my $annonsrubrik = ansi2utf8( $elem->{'annonsrubrik'} );
        my $kommunnamn   = ansi2utf8( $elem->{'kommunnamn'} );
        print "$line; $elem->{'annonsid'}; $annonsrubrik; $kommunnamn\n";
        if ($verbose) {
            print Dumper $elem;
        }
    }
}
print(    "Total; $line/$total="
        . sprintf( '%.2f', 100 * $line / $total )
        . "%\n" );

sub fix_encoding {
    my $enc = $^O eq 'MSWin32' ? 'cp850' : 'utf8';
    if ( $enc ne 'utf8' ) {
        binmode STDOUT, ":encoding($enc)";
        binmode STDIN,  ":encoding($enc)";
    }
    return $enc;
}

sub ansi2utf8 {
    my ($s) = @_;
    my $tmp;
    eval { $tmp = decode( 'cp1252', $s ); };
    if ($@) {
        warn "caught error: $@";
    }
    else {
        $s = $tmp;
    }
    if ( $encoding eq 'utf8' ) {
        $s = encode( $encoding, $s );
    }
    return $s;
}

sub uri_esc {
    my ($k) = @_;
    if ( $encoding ne 'utf8' ) {
        $k = uri_escape_utf8($k);
    }
    else {
        $k = uri_escape($k);
    }
    return $k;
}

sub get_ad {
    my ($ad) = @_;
    if (-f "ad/$ad.js") {
        open INFILE, '<', "ad/$ad.js";
        $body = join('', <INFILE>);
        close INFILE;
    }
    else {
        warn "Creating ad/$ad.js\n";
        $body = url_get("$URL/$ad");
        open OUTFILE, '>', "ad/$ad.js";
        print OUTFILE $body;
        close OUTFILE;
    }
    return $body;
}

1;
