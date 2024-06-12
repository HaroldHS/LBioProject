package DNA::Alignment::PairwiseSequenceAlignment;

use List::Util qw(max);

sub parameters {
    return %hash = (
        "NeedlemanWunsch" => (),
        "SmithWaterman" => ()
    );
}

sub help {
    print "[ Available subroutines/functions ]\n\n";
    print "[*] NeedlemanWunsch : perform global sequencing with Needleman-Wunsch algorithm (input = [DNA/Protein 1, DNA/Protein 2, indel penalty], output = [DNA/Protein 1 alignment, DNA/Protein 2 alignment, score]).\n";
    print "[*] SmithWaterman : perform local sequencing with Smith-Waterman algorithm (input = [DNA/Protein 1, DNA/Protein 2, indel penalty], output = [DNA/Protein 1 alignment, DNA/Protein 2 alignment, score]).\n\n";
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

    # Iterative Backtracking for obtaining score
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
            # Add the score first $tab[$i][$j]
            $score = $score + $tab[$i][$j];

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

    return @result = (
        scalar reverse("$dna1_align"),
        scalar reverse("$dna2_align"),
        $score
    );
}

sub SmithWaterman {
    my ($dna1, $dna2, $indel) = @_;
    my $dna1_align = "";
    my $dna2_align = "";
    my @tab;
    
    for (my $i=0; $i<=length($dna1); $i++) {
        $tab[$i][0] = 0;
    }
    for (my $i=0; $i<=length($dna2); $i++) {
        $tab[0][$i] = 0;
    }

    # Dynamic Programming (Tabulation), same as NeedlemanWunsch
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

    # Find maximum value in Tabulation table
    my $max_value = 0;
    my $max_col = 0;
    my $max_row = 0;
    for (my $i=1; $i<=length($dna1); $i++) {
        for (my $j=1; $j<=length($dna2); $j++) {
            if ($tab[$i][$j] > $max_value) {
                $max_value = $tab[$i][$j];
                $max_col = $i;
                $max_row = $j;
            }
        }
    }

    # Iterative Backtracking for obtaining score
    my $i = $max_col;
    my $j = $max_row;
    my $stop_flag = 0;
    my $score = 0;
    while (($i>0 or $j>0) and ($stop_flag!=1)) {
        if (substr($dna1, $i-1, 1) eq substr($dna2, $j-1, 1)) {
            $dna1_align = $dna1_align.substr($dna1, $i-1, 1);
            $dna2_align = $dna2_align.substr($dna2, $j-1, 1);
            $score = $score + $tab[$i][$j];
            $i -= 1;
            $j -= 1;
        } else {
            # If mismatch and $tab[$i][$j]==0, then stop
            if ($tab[$i][$j]==0) {
                $stop_flag = 1;
            } else {
                # Add the score first $tab[$i][$j]
                $score = $score + $tab[$i][$j];

                # Take a value from previous left and top
                my $top = $tab[$i-1][$j];
                my $left = $tab[$i][$j-1];

                if ($top >= $left && $top != 0) {
                    $dna1_align = $dna1_align.substr($dna1, $i-1, 1);
                    $dna2_align = $dna2_align."-";
                    $i = $i - 1;
                } elsif ($left > $top && $left != 0) {
                    $dna1_align = $dna1_align."-";
                    $dna2_align = $dna2_align.substr($dna2, $j-1, 1);
                    $j = $j - 1;
                } else {
                    $dna1_align = $dna1_align.substr($dna1, $i-1, 1);
                    $dna2_align = $dna2_align.substr($dna2, $j-1, 1);
                    $stop_flag = 1;
                }
            }
        }
    }

    return @result = (
        scalar reverse("$dna1_align"),
        scalar reverse("$dna2_align"),
        $score
    );
}

1;