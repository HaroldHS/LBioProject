package DNA::Alignment::PairwiseSequenceAlignment;

use List::Util qw(max);

sub parameters {
    return %hash = (
        "NeedlemanWunsch" => (),
        "SmithWaterman" => ()
    );
}

sub help {
    print "[ Available subroutines / functions ]\n\n";
    print "[*] NeedlemanWunsch : perform global DNA sequencing with Needleman-Wunsch algorithm (input = [DNA 1, DNA 2, indel penalty], output = [DNA 1 alignment, DNA 2 alignment, score]).\n";
    print "[*] SmithWaterman : perform local DNA sequencing with Smith-Waterman algorithm (input = [], output = []).\n\n";
    print "[ NOTE ] To specify that a base is an indel (insertion or deletion), use '-' symbol.\n\n";
}

sub NeedlemanWunsch {
    my ($dna1, $dna2, $indel) = @_;
    my $dna1_align = "";
    my $dna2_align = "";
    my @tab;

    for (my $i=0; $i<=length($dna1); $i++) {
        $tab[$i][0] = $indel * $i;
    }
    for (my $i=0; $i<=length($dna2); $i++) {
        $tab[0][$i] = $indel * $i;
    }

    # Dynamic Programming (Tabulation) 
    my $top = 0;
    my $left = 0;
    my $diagonal = 0;
    for (my $i=1; $i<=length($dna1); $i++) {
        for (my $j=1; $j<=length($dna2); $j++) {
            $top = $tab[$i-1][$j] + $indel;
            $left = $tab[$i][$j-1] + $indel;
            $diagonal = substr($dna1, $i-1, 1) eq substr($dna2, $j-1, 1) ? $tab[$i-1][$j-1]+1 : $tab[$i-1][$j-1]-1;
            $tab[$i][$j] = max($top, $left, $diagonal);
        }
    }


    # Iterative Backtracking
    my $i = length($dna1);
    my $j = length($dna2);
    my $score = 0;
    while ($i>0 or $j>0) {
        if (substr($dna1, $i-1, 1) eq substr($dna2, $j-1, 1)) {
            $dna1_align = $dna1_align.substr($dna1, $i-1, 1);
            $dna2_align = $dna2_align.substr($dna2, $j-1, 1);
            $score = $score + $tab[$i][$j];
            $i -= 1;
            $j -= 1;
        } else {
            # Take a value from previous left, top, diagonal
            my $top = $tab[$i-1][$j];
            my $left = $tab[$i][$j-1];
            my $diagonal  = $tab[$i-1][$j-1];

            if ($top > $left && $top > $diagonal) {
                $dna1_align = $dna1_align.substr($dna1, $i-1, 1);
                $dna2_align = $dna2_align."-";
                $i = $i - 1;
            } elsif ($left > $top && $left > $diagonal) {
                $dna1_align = $dna1_align."-";
                $dna2_align = $dna2_align.substr($dna2, $j-1, 1);
                $j = $j - 1;
            } else {
                $dna1_align = $dna1_align.substr($dna1, $i-1, 1);
                $dna2_align = $dna2_align.substr($dna2, $j-1, 1);
                $i = $i - 1;
                $j = $j - 1;
            }
        }
    }

    # Reverse both alignments
    return "DNA1: ".reverse($dna1_align)."\nDNA2: ".reverse($dna2_align)."\nScore: ".$score."\n";
}

sub SmithWaterman {
}

1;