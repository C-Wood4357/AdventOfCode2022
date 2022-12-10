use strict;
use warnings;
use Path::Tiny;
use autodie;
use Cwd;
use Data::Dumper;

$Data::Dumper::Sortkeys  = 1;

my $dir = getcwd();
#my $file = path($dir,"/05")->child("test.txt");
my $file = path($dir,"/05")->child("data.txt");
my $data = $file->slurp;

my @chunks = split('\n\n', $data);

my @stacks = reverse split("\n",$chunks[0]);
my @instructions = split ("\n", $chunks[1]);

my @stackNums = split ' ', shift @stacks;
my %stacks = map { $_ => [] } @stackNums;

foreach my $stack_line ( @stacks ){
    parseCrate($stack_line);
}

sub parseInstruction{
    my ($instruction, $part2) = @_;
    my @nums = $instruction =~ /((?:\+|-)?\d+)/g;
    my $quantity = $nums[0];
    my $from = $nums[1];
    my $to = $nums[2];
    #print "Pushing $quantity from $from to $to\n";
    if ($part2 == 1){
        my @elements = splice @{$stacks{$from}}, 0-$quantity;
        #print "Just spliced, $from is:", @{$stacks{$from}}, " now.\n";
        if (@elements){
            push(@{$stacks{$to}}, @elements);
            #print "Just spliced, $to is:", @{$stacks{$to}}, " now.\n";
        }
    }
    else{
        for (my $i = 0; $i< $quantity; $i++){
            my $element = pop @{$stacks{$from}};
            #print "Just popped, $from is:", @{$stacks{$from}}, " now.\n";
            if (defined($element)){
                push(@{$stacks{$to}}, $element);
                #print "Just pushed, $to is:", @{$stacks{$to}}, " now.\n";
            }
        }
    }
}

sub parseCrate{
    my ($crateline) = @_;
    my @crates = $crateline =~ /\s{4}|\[\w\]/g;
    my $crate_index = 1;
    foreach my $crate (@crates){
        if($crate ne "    "){
            push(@{$stacks{$crate_index}}, $crate);
        }
        $crate_index += 1;
    }
}

print("Running part 1? or 2?\n");
my $part = <> - 1;
# Run part 1
foreach my $inst ( @instructions ){
    parseInstruction($inst, $part);
}
# Print solve
my $outstring = "";
foreach my $out (sort keys %stacks){
    $outstring = $outstring . $stacks{$out}[-1];
}
$outstring =~ s/\[|\]//g;
print $outstring, "\n";