use strict;
use warnings;
use Path::Tiny;
use autodie;
use Cwd;

my $dir = getcwd();
#my $file = path($dir,"/04")->child("test.txt");
my $file = path($dir,"/04")->child("data.txt");
my $data = $file->slurp;

my @assignments = split('\n', $data);

my $total1 = 0;
my $total2 = 0;
foreach my $assignment ( @assignments ){
    my @parts = split(',',$assignment);
    my @all_parts = (split('-',$parts[0]), split('-',$parts[1]));
    if (($all_parts[0] >= $all_parts[2] && $all_parts[1] <= $all_parts[3]) or ($all_parts[2] >= $all_parts[0] && $all_parts[3] <= $all_parts[1])){
        $total1 += 1;
    }
    if (($all_parts[0] >= $all_parts[2] && $all_parts[0] <= $all_parts[3])
    || ($all_parts[2] >= $all_parts[0] && $all_parts[2] <= $all_parts[1])){
        $total2 += 1;
    }
}

print "$total1\n";
print "$total2\n";