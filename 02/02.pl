use strict;
use warnings;
use Path::Tiny;
use autodie;
use Cwd;

my $dir = getcwd();
#my $file = path($dir,"/02")->child("test.txt");
my $file = path($dir,"/02")->child("data.txt");
my $data = $file->slurp;

my @strategies = split('\n', $data);

# A, X = Rock
# B, Y = Paper
# C, Z = Scissors

sub compete {
    my ($opponentmove, $mymove) = @_;
    my $outcome_score = 0;
    my $mod_val = (ord($opponentmove) - ord($mymove)) % 3;
    my $choice_score = 0;

    if ($mymove eq "X") {
        $choice_score = 1;
    }
    if ($mymove eq "Y") {
        $choice_score = 2;
    }
    if ($mymove eq "Z") {
        $choice_score = 3;
    }

    $outcome_score = 6 - ($mod_val*3);
    return $outcome_score + $choice_score;

}

sub competeP2 {
    my ($opponentmove, $mymove) = @_;
    my $outcome_score = 0;
    my $mod_val = (ord($opponentmove) - ord($mymove)) % 3;
    my $choice_score = 0;
    #lose
    if ($mymove eq "X") {
        $outcome_score = 0;
        if ($opponentmove eq "A"){
            $choice_score = 3;
        }
        if ($opponentmove eq "B"){
            $choice_score = 1;
        }
        if ($opponentmove eq "C"){
            $choice_score = 2;
        }
    }
    #draw
    if ($mymove eq "Y") {
        $outcome_score = 3;
        if ($opponentmove eq "A"){
            $choice_score = 1;
        }
        if ($opponentmove eq "B"){
            $choice_score = 2;
        }
        if ($opponentmove eq "C"){
            $choice_score = 3;
        }
    }
    #win
    if ($mymove eq "Z") {
        $outcome_score = 6;
        if ($opponentmove eq "A"){
            $choice_score = 2;
        }
        if ($opponentmove eq "B"){
            $choice_score = 3;
        }
        if ($opponentmove eq "C"){
            $choice_score = 1;
        }
    }

    return $outcome_score + $choice_score;

}

my $total_score = 0;
my $total_p2_score = 0;

foreach my $strategy ( @strategies ){
    my @moves = split(' ', $strategy);
    my $output = compete($moves[0], $moves[1]);
    $total_score += $output;
    my $output2 = competeP2($moves[0], $moves[1]);
    $total_p2_score += $output2;
}

print "$total_score\n";
print "$total_p2_score\n";