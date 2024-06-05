package CentralDogmaTest;

# Set up @INC in order to import the intended module to be tested
use FindBin qw($Bin);
use lib "$Bin/../main/modules";

use Genomics::CentralDogma;

sub test_transcription {
    my ($input, $output) = @_;
    return (Genomics::CentralDogma::transcription($input) eq $output);
}

sub test_reverse_transcription {
    my ($input, $output) = @_;
    return (Genomics::CentralDogma::transcription($input, "true") eq $output);
}

sub test_translation {
    my ($input, $output) = @_;
    return (Genomics::CentralDogma::translation($input) eq $output);
}

1;