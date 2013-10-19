open OUT,">genePositions.txt";
open IN, "sequence.gb";

print "\n---Create List Of Genes\n";
print "(1/2) Calculating All Gene Locations...\n";
@pos = ();
while ($str = <IN>) { 
	if ($str =~ m/gene\s*(complement\()?(\d+)\.\.(\d+)/) {
		print "$2--$3\n";
		if ($#pos==-1) {
			push(@pos,"$2");
			push(@pos,"$3");
		} elsif (@pos[$#pos]>$2) {
			pop(@pos);
			push(@pos,"$3");
		} else {
			push(@pos,"$2");
			push(@pos,"$3");
		}
	}
}

print "(2/2) Generating Results...\n";
for($i = 0; $i < $#pos; $i+=2) {
	print OUT @pos[$i]." ".@pos[$i+1]."\n";
}

close IN;
close OUT;