use strict;
use warnings;
use Path::Tiny;
use autodie;
use Cwd;
use Data::Dumper;

$Data::Dumper::Sortkeys  = 1;

my $dir = getcwd();
#my $file = path($dir,"/06")->child("test.txt");
my $file = path($dir,"/06")->child("data.txt");
my $data = $file->slurp;

my $not_match = 1;
my $lowbound = 0;
my $upbound = 4;
my $end = length $data;

print("Running part 1? or 2?\n");
my $part = <> - 1;

while ($end >= $upbound) {
    my $checkstr;
    if ($part){
        $checkstr = join '', substr($data,$lowbound,14);
    }
    else{
        $checkstr = join '', substr($data,$lowbound,4);

    }
    my $result = $checkstr =~ /^.*(.).*\1.*$/gs;
    if ($result != 1){
        if ($part){
            print "OUTPUT IS: ", $checkstr, " INDEX IS:", index($data, $checkstr) + 14,"\n";
        }
        else{
            print "OUTPUT IS: ", $checkstr, " INDEX IS:", index($data, $checkstr) + 4,"\n";
        }
        last;
    }
    $lowbound += 1;
    $upbound += 1;
}