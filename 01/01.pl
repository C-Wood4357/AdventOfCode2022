use strict;
use warnings;
use Path::Tiny;
use autodie;
use Cwd;

my $dir = getcwd();
#my $file = path($dir,"/01")->child("test.txt");
my $file = path($dir,"/01")->child("data.txt");

my $data = $file->slurp;

my @elves = split('\n\n', $data);
my @sum_array;

foreach my $elf ( @elves ){
    my $iter_sum = 0;
    my @elf_calories = split('\n', $elf);
    for my $each(@elf_calories){
        $each =~ s/[\r\n]+//g;
        $iter_sum += $each;
    }
    push(@sum_array, int($iter_sum));
}
my @sums = sort { $b <=> $a } @sum_array;

print join ",", @sums, "\n";

print $sums[0], "\n";

print $sums[0] + $sums[1] + $sums[2];