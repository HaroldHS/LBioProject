package BasicReport;

use Cwd;

sub generate_report {
    my ($module_name, $input, $output) = @_;

    my $header_format = "format header_format = \n".
    "======================================================================\n".
    "@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\n".
    "$module_name\n".
    "======================================================================\n".
    "\n".
    ".";

    my $input_output_format = "format input_output_format = \n".
    "@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n".
    "INPUT\n".
    "\n".
    "@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n".
    "$input\n\n".
    "======================================================================\n\n".
    "@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n".
    "OUTPUT\n".
    "\n".
    "@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n".
    "$output\n\n".
    "======================================================================\n".
    ".";

    my $dir = getcwd;
    if (!(-d $dir."/report")) {
        mkdir($dir."/report") or die "[-] Can't create directory /report\n";
    }

    open(OUTPUT_FILE, ">", "$dir/report/result_".$module_name.".txt") or die "[-] Can't create file result_$module_name.txt\n";
    select(OUTPUT_FILE);

    # Evaluate the format strings in order to execute the format
    eval $header_format;
    eval $input_output_format;

    $^ = "header_format";
    $~ = "input_output_format";

    write;
    close(OUTPUT_FILE) or die "[-] Can't close file result_$module_name.txt\n";
    exit 0;
}

1;