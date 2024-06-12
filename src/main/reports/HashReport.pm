package HashReport;

use Cwd;

sub generate_report {
    my $module_name = $_[0];
    my @given_input = @{$_[1]};
    my @given_output = @{$_[2]}; # List of hashes (e.g. ({a => b}, {c => d}))

    my $dir = getcwd;
    if (!(-d $dir."/report")) {
        mkdir($dir."/report") or die "[-] Can't create directory /report\n";
    }

    open(OUTPUT_FILE, ">", $dir."/report/result_".$module_name.".txt") or die "[-] Can't create file result_$module_name.txt\n";
    select(OUTPUT_FILE);

    $^ = "HEADER_FORMAT";
    $~ = "INPUT_FORMAT";

    $input_index = 0;
    while ($input_index <= $#given_input) {
        write; 
        $input_index++;
    }

    $~ = "BREAK";
    write;

    $~ = "HASH_FORMAT";
    for $key (@given_output) {
        for $val (keys %$key) {
            $title = $val;
            $description = $key->{$val};
            write;
        }
    }

    close(OUTPUT_FILE) or die "[-] Can't close file result_$module_name.txt\n";
    exit 0;

format HEADER_FORMAT = 
======================================================================
@|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
$module_name
======================================================================

@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"[ Input ]"

.

format INPUT_FORMAT = 
@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$given_input[$input_index]
.

}

format BREAK = 

======================================================================

@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"[ Output ]"

.

format HASH_FORMAT = 
@<<<<@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
"[*]  ", $title
@<<<<
" |   "
@<<<<@<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
" +-> ", $description

.

1;