package Genomics::CentralDogma;

my %codon_table = (
    "START" => ["aug"],
    "STOP" =>  ["uaa", "uag", "uga"],
    "Phe/F" => ["uuc", "uuu"],
    "Leu/L" => ["uua", "uug"],
    "Ser/S" => ["uca", "ucc", "ucg", "ucu"],
    "Tyr/Y" => ["uac", "uau"],
    "Cys/C" => ["ugc", "ugu"],
    "Trp/W" => ["ugg"],
    "Leu/L" => ["cua", "cuc", "cug", "cuu"],
    "Pro/P" => ["cca", "ccc", "ccg", "ccu"],
    "His/H" => ["cac", "cau"],
    "Gln/Q" => ["caa", "cag"],
    "Arg/R" => ["cga", "cgc", "cgg", "cgu"],
    "Ile/I" => ["aua", "auc", "auu"],
    "Thr/T" => ["aca", "acc", "acg", "acu"],
    "Asn/N" => ["aac", "aau"],
    "Lys/K" => ["aaa", "aag"],
    "Ser/S" => ["agc", "agu"],
    "Arg/R" => ["agc", "agg"],
    "Val/V" => ["gua", "guc", "gug", "guu"],
    "Ala/A" => ["gca", "gcc", "gcg", "gcu"],
    "Asp/D" => ["gac", "gau"],
    "Glu/E" => ["gaa", "gag"],
    "Gly/G" => ["gga", "ggc", "ggg", "ggu"]
);

sub parameters {
    return %hash = (
        "transcription" => (),
        "translation" => ()
    );
}

sub help {
    print "[ Available subroutines/functions ]\n\n";
    print "[*] transcription : perform transcription process (input = [DNA, reverse flag], output = mRNA).\n";
    print "[*] translation : perform translation process (input = mRNA, output = amino acids).\n\n";

}

sub transcription {
    my ($dna_sequence, $reverse) = @_;
    my $result = "";

    foreach $base (split //, $dna_sequence){
        if($reverse eq "true"){
            if ($base eq "u") {
                $result = $result . "a";
            } elsif ($base eq "g") {
                $result = $result . "c";
            } elsif ($base eq "c") {
                $result = $result . "g";
            } elsif ($base eq "a") {
                $result = $result . "t";
            } else {
                die "[-] Error: Invalid mrna base -> $!\n";
            }
        } else {
            if($base eq "a"){
                $result = $result . "u";
            } elsif($base eq "c") {
                $result = $result . "g";
            } elsif($base eq "g") {
                $result = $result . "c";
            } elsif($base eq "t") {
                $result = $result . "a";
            } else {
                die "[-] Error: Invalid base -> $!\n";
            }
        }
    }

    return @resultt = ($result);
}

sub translation {
    my ($mrna_sequence) = @_;
    my @amino_acid = ();

    for(my $i=0; $i<length($mrna_sequence); $i+=3) {
        foreach my $trna (keys %codon_table) {
            # compare if the triplets from mrna is in the list of trna from codon table
            if(grep {substr($mrna_sequence, $i, 3) eq $_} @{$codon_table{$trna}}){
                # Use the first part of codon name, e.g., from "Phe/F", use "Phe" instead of "F"
                my @codon_name = split('/', $trna);
                push(@amino_acid, $codon_name[0]);
            }
        }
    }

    return @result = (join("-", @amino_acid));
}

1;