open GENES,">geneSpace.txt";
open INTER,">intergeneSpace.txt";
open POSITIONS, "genePositions.txt";
open SEQUENCE, "sequence.fasta";

print "\n---Remove Gene Space\n";
print "(1/3) Reading Gene Positions...\n";
@pos = ();
while ($str = <POSITIONS>) { 
	if ($str =~ m/(\d+)\s(\d+)/) {
		push(@pos,$1);
		push(@pos,$2);
	}
}

print "(2/3) Assembling Nucleotide Sequence...\n";
while ($str = <SEQUENCE>) {
	chomp $str;
	print $i++;
	$seq = $seq.$str;
}

print "(3/3) Generating Results...\n";
$startStr = substr($seq,0,@pos[0]-1);
for($i = 0; $i < $#pos; $i++) {
	if ($i & 1) {
		print GENES substr($seq,@pos[$i]-1,@pos[$i+1]-@pos[$i]+1)."\n";
	} else {
		print INTER substr($seq,@pos[$i],@pos[$i+1]-@pos[$i]-1)."\n";
	}
	print $i."\n"
}
print INTER substr($seq,@pos[$i+1]).$startStr;
#print (($#pos+1)/2)." gene sets output\n";

close GENES;
close INTER;
close POSITIONS;
close SEQUENCE;