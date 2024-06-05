use FindBin qw($Bin);
use lib "$Bin/modules";
use lib "$Bin/reports";

# Use/import all modules
use Genomics::CentralDogma;

# Use/import all report formatting
use BasicReport;

# States for modules and report
my $module = "";
my @input = ();
my @output = ();

while(1){
    # Prompt display
    print ">>> " if $module eq "";
    print "$module >>> " unless $module eq "";

    chomp (my $input = <STDIN>);
    my @input_word = split(" ", $input);

    if($input_word[0] eq "exit"){
        exit 0;
    } elsif ($input_word[0] eq "set") {
        if ($input_word[1] eq "module" && $input_word[2] =~ /^[a-zA-Z:]+$/) {
            $module = $input_word[2];
        } elsif ($input_word[1] eq "input") {
            push(@input, $input_word[2]);
            print "[+] Input was set\n";
        } else {
            die "[-] Invalid command: $input_word[1]\n";
        }
    } elsif ($input_word[0] eq "run") {
        if ($input_word[1] =~ /^[a-zA-Z_]+$/) {
            my $current_output = eval $module."::".$input_word[1]."(".$input[0].")";
            push(@output, $current_output) unless $current_output eq "";
            print "[+] Result -> ".$current_output."\n";
        } else {
            die "[-] Invalid method/subroutine name\n";
        }
    } elsif ($input_word[0] eq "show_report") {
        BasicReport::generate_report($module, $input[0], $output[0]);
    } else {
        die "[-] Invalid command: $input_word[0]\n";
    }
}