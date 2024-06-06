use FindBin qw($Bin);
use lib "$Bin/modules";
use lib "$Bin/reports";

# Use/import all modules
use Genomics::CentralDogma;

# Use/import all report formatting
use BasicReport;

# States for modules and report
my $module = "";
my %input = ();
my @report_input = ();
my @report_output = ();

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
            %input = eval $input_word[2]."::parameters()";
        } elsif ($input_word[1] eq "input") {
            # push(subroutine name, input)
            push( @{ $input{ $input_word[2] } }, $input_word[3]) or die "[-] Invalid subroutine name\n";
        } else {
            die "[-] Invalid command: $input_word[1]\n";
        }

    } elsif ($input_word[0] eq "run") {

        if ($input_word[1] =~ /^[a-zA-Z_]+$/) {
            my $params = join(",", @{ $input{ $input_word[1] } });
            push(@report_input, $params);

            my $current_output = eval $module."::".$input_word[1]."(".$params.")";
            push(@report_output, $current_output) unless $current_output eq "";
            
            print "[+] Result -> ".$current_output."\n";
        } else {
            die "[-] Invalid method/subroutine name\n";
        }

    } elsif ($input_word[0] eq "show_report") {
        BasicReport::generate_report($module, $report_input[0], $report_output[0]);
    } else {
        die "[-] Invalid command: $input_word[0]\n";
    }
}