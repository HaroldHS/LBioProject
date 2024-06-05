use FindBin qw($Bin);
use lib "$Bin/modules";
# use lib "$Bin/reports";

# Use/import all modules
use Genomics::CentralDogma;

# Use/import all report formatting
# use BasicReport;

# States for modules and report
my @input = ();
my @output = ();

while(1){
    print ">>> "; # prompt
    chomp (my $input = <STDIN>);
    my @input_word = split(" ", $input);

    if($input_word[0] eq "exit"){
        exit 0;
    } elsif ($input_word[0] eq "set") {
        if ($input_word[1] eq "input") {
            push(@input, $input_word[2]);
            print "[+] Input was set\n";
        } else {
            die "[-] Invalid command: $input_word[1]\n";
        }
    } elsif ($input_word[0] eq "run") {
        if ($input_word[1] =~ /^[a-zA-Z:_]+$/) {
            my $current_output = eval $input_word[1]."(".$input[0].")";
            push(@output, $current_output);
            print "[+] Result -> ".$current_output."\n";
        } else {
            die "[-] Invalid method/subroutine name\n";
        }
    } else {
        die "[-] Invalid command: $input_word[0]\n";
    }
}