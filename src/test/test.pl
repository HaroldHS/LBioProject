# Set up @INC in order to be able to execute all test cases subroutine
use FindBin qw($Bin);
use lib "$Bin/modules";

# Use/import all test modules
use CentralDogmaTest;

# Run each subroutine from each module
CentralDogmaTest::test_transcription("tacgtgatt", "augcacuaa") or warn "[-] Invalid test case -> CentralDogmaTest::test_transcription\n";
CentralDogmaTest::test_reverse_transcription("augcacuaa", "tacgtgatt") or warn "[-] Invalid test case -> CentralDogmaTest::test_reverse_transcription\n";
CentralDogmaTest::test_translation("augcacuaa", "START-His-STOP") or warn "[-] Invalid test case -> CentralDogmaTest::test_translation\n";