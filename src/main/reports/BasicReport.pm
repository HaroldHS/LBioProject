package BasicReport;

use Cwd;

sub generate_report {
    my $module_name = $_[0];
    my @given_input = @{$_[1]};
    my @given_output = @{$_[2]};

    my $dir = getcwd;
    if (!(-d $dir."/report")) {
        mkdir($dir."/report") or die "[-] Can't create directory /report\n";
    }

    open(OUTPUT_FILE, ">", "$dir/report/result_".$module_name.".txt") or die "[-] Can't create file result_$module_name.txt\n";
    select(OUTPUT_FILE);

    $^ = "HEADER_FORMAT";
    $~ = "INPUT_OUTPUT_FORMAT";

    write;
    close(OUTPUT_FILE) or die "[-] Can't close file result_$module_name.txt\n";
    exit 0;

format HEADER_FORMAT = 
======================================================================
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$module_name
======================================================================

.

format INPUT_OUTPUT_FORMAT =
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"[ Input ]"

@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$given_input[0]

======================================================================

@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"[ Output ]"

@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$given_output[0]

======================================================================
.

}
1;