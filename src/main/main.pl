use FindBin qw($Bin);
use lib "$Bin/modules";
use lib "$Bin/reports";

# Use/import all modules
use Genomics::CentralDogma;
use DNA::Alignment::PairwiseSequenceAlignment;

# Use/import all report formatting
use BasicReport;
use ListReport;
use HashReport;

# States for modules and report
my $module = "";
my $report = "";
my %input = ();
my @report_input = ();
my @report_output = ();

while (1) {
    # Prompt display
    print ">>> " if $module eq "";
    print "$module >>> " unless $module eq "";

    chomp (my $input = <STDIN>);
    my @input_word = split(" ", $input);

    if ($input_word[0] eq "exit") {
        exit 0;
    } elsif ($input_word[0] eq "set") {
        
        if ($input_word[1] eq "module" && $input_word[2] =~ /^[a-zA-Z:]+$/) {
            $module = $input_word[2];
            %input = eval $input_word[2]."::parameters()";
        } elsif ($input_word[1] eq "input") {
            # push(subroutine name, input)
            push( @{ $input{ $input_word[2] } }, $input_word[3]) or die "[-] Invalid subroutine name\n";
        } elsif ($input_word[1] eq "report" && $input_word[2] =~ /^[a-zA-Z]+$/) {
            $report = $input_word[2];
        } else {
            die "[-] Invalid command: $input_word[1]\n";
        }

    } elsif ($input_word[0] eq "help") {
        eval $module."::help()" or warn "help() function is not available in $module\n";
    } elsif ($input_word[0] eq "run") {

        if ($input_word[1] =~ /^[a-zA-Z_]+$/) {
            my $params = join(",", @{ $input{ $input_word[1] } });
            push(@report_input, @{ $input{ $input_word[1] } });

            @report_output = eval $module."::".$input_word[1]."(".$params.")";
        } else {
            die "[-] Invalid method/subroutine name\n";
        }

    } elsif ($input_word[0] eq "show_report") {
        if ($report eq "basic") {
            BasicReport::generate_report($module, \@report_input, \@report_output);
        } elsif ($report eq "list") {
            ListReport::generate_report($module, \@report_input, \@report_output);
        } elsif ($report eq "hash") {
            HashReport::generate_report($module, \@report_input, \@report_output);
        } elsif ($report eq "") {
            die "[-] Report format is not defined\n";
        } else {
            die "[-] Invalid report name -> $report\n";
        }
    } else {
        die "[-] Invalid command: $input_word[0]\n";
    }
}