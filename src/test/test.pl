# Set up @INC in order to be able to execute all test cases subroutine
use FindBin qw($Bin);
use lib "$Bin/modules";

# Use/import all test modules
use CentralDogmaTest;
use PairwiseSequenceAlignmentTest;

# Run each subroutine from each module
CentralDogmaTest::test_transcription("tacgtgatt", "augcacuaa") or warn "[-] Invalid test case -> CentralDogmaTest::test_transcription\n";
CentralDogmaTest::test_reverse_transcription("augcacuaa", "tacgtgatt") or warn "[-] Invalid test case -> CentralDogmaTest::test_reverse_transcription\n";
CentralDogmaTest::test_translation("augcacuaa", "START-His-STOP") or warn "[-] Invalid test case -> CentralDogmaTest::test_translation\n";

my @input = ("tacga", "tatga", -2);
my @output = ("tacga", "tatga", 9);
PairwiseSequenceAlignmentTest::test_needlemanwunsch(\@input, \@output) or warn "[-] Invalid test case -> PairwiseSequenceAlignmentTest::test_needlemanwunsch\n";

my @input = ("atgtg", "atctg", -2);
my @output = ("gtg", "ctg", 6);
PairwiseSequenceAlignmentTest::test_smithwaterman(\@input, \@output) or warn "[-] Invalid test case -> PairwiseSequenceAlignmentTest::test_smithwaterman\n";