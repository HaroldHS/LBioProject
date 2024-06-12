package PairwiseSequenceAlignmentTest;

use Storable qw(freeze);
$Storable::canonical = 1;

use FindBin qw($Bin);
use lib "$Bin/../main/modules";

use DNA::Alignment::PairwiseSequenceAlignment;

sub test_needlemanwunsch {
    my @input = @{ $_[0] };
    my @output = @{ $_[1] };
    my @result = DNA::Alignment::PairwiseSequenceAlignment::NeedlemanWunsch($input[0], $input[1], $input[2]);
    return (freeze(\@result) eq freeze(\@output));
}

sub test_smithwaterman {
    my @input = @{ $_[0] };
    my @output = @{ $_[1] };
    my @result = DNA::Alignment::PairwiseSequenceAlignment::SmithWaterman($input[0], $input[1], $input[2]);
    return (freeze(\@result) eq freeze(\@output));
}

1;