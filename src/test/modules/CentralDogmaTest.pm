package CentralDogmaTest;

# Set up @INC in order to import the intended module to be tested
use FindBin qw($Bin);
use lib "$Bin/../main/modules";

use Genomics::CentralDogma;

sub test_transcription {
    my ($input, $output) = @_;
    my @result = Genomics::CentralDogma::transcription($input);
    return ($result[0] eq $output);
}

sub test_reverse_transcription {
    my ($input, $output) = @_;
    my @result = Genomics::CentralDogma::transcription($input, "true");
    return ($result[0] eq $output);
}

sub test_translation {
    my ($input, $output) = @_;
    my @result = Genomics::CentralDogma::translation($input);
    return ($result[0] eq $output);
}

1;