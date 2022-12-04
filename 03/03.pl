use strict;
use warnings;
use Path::Tiny;
use autodie;
use Cwd;

my $dir = getcwd();
#my $file = path($dir,"/03")->child("test.txt");
my $file = path($dir,"/03")->child("data.txt");
my $data = $file->slurp;

my @two_rucksacks = split('\n', $data);

sub checkrucksack {
    my (@parts) = @_;
    foreach my $char ( split('',$parts[0])){
        my $check = index($parts[1], $char);
        if ($check != -1){
            if (ord($char) > 90){
                return ord($char)-96;
            }
            else{
                return ord($char)-38;
            }
        }
    }
}

sub checkbadges {
    my (@rucksacks) = @_;
    foreach my $char ( split('',$rucksacks[0])){
        my $check = index($rucksacks[1], $char);
        if ($check != -1){
            my $check2 = index($rucksacks[2], $char);
            if ($check2 != -1){
                if (ord($char) > 90){
                    return ord($char)-96;
                }
                else{
                    return ord($char)-38;
                }
            }
        }
    }
}
        
my $total_priority = 0;
my $total_badge_priority = 0;
my @three_group = ();
foreach my $two_rucksack ( @two_rucksacks ){
    if (scalar @three_group < 3){
        push @three_group, $two_rucksack;
    }
    if (scalar @three_group == 3){
        my $badge_priority = checkbadges(@three_group);
        $total_badge_priority += $badge_priority;
        @three_group = ();
    }
    my $halflen = (length $two_rucksack)/2;
    my @parts = split /(?<=.{$halflen})/s, $two_rucksack, 2;
    my $priority = checkrucksack(@parts);
    $total_priority += $priority;
}

print("Total priority is: $total_priority\n");
print("Total badge priority is: $total_badge_priority\n");