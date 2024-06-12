package ListFormatReport;

use Cwd;

sub generate_report {
    my $module_name = $_[0];
    my @given_input = @{$_[1]};
    my @given_output = @{$_[2]};

    my $dir = getcwd;
    if (!(-d $dir."/report")) {
        mkdir($dir."/report") or die "[-] Can't create directory /report\n";
    }

    open(OUTPUT_FILE, ">", $dir."/report/result_".$module_name.".txt") or die "[-] Can't create file result_$module_name.txt\n";
    select(OUTPUT_FILE);

    $^ = "HEADER_FORMAT";
    $~ = "INPUT_OUTPUT_FORMAT";

    # Align the elements for inputa and output
    if ($#given_input < $#given_output) {
        for (my $i=0; $i<($#given_output - $#given_input); $i++) {
            push(@given_input, " ");
        }
    }
    if ($#given_input > $#given_output) {
        for (my $i=0; $i<($#given_input - $#given_output); $i++) {
            push(@given_output, " ");
        }
    }

    $index = 0;
    while ($index <= $#given_input && $index <= $#given_output) {
        write; 
        $index++;
    }

    close(OUTPUT_FILE) or die "[-] Can't close file result_$module_name.txt\n";
    exit 0;

format HEADER_FORMAT = 
======================================================================
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$module_name
======================================================================

@||||||||||||||||||||||||||||||||||@||||||||||||||||||||||||||||||||||
"[ Input ]",                       "[ Output ]"

.

format INPUT_OUTPUT_FORMAT = 
@||||||||||||||||||||||||||||||||||@||||||||||||||||||||||||||||||||||
$given_input[$index],                    $given_output[$index]
.

}

1;