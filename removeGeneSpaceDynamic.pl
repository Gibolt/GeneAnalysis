open GENES,">geneSpaceDynamic.txt";
open INTER,">intergeneSpaceDynamic.txt";
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

print "(2/3) Assembling Nucleotide Sequence...\n$#pos";
$i=0;    #position in pos array
$fpt=0;  #position of front point in substr
$bpt=0;  #position of back point in substr
$seq="";
while ($str = <SEQUENCE>) {
	chomp $str;
	$bpt+=length($str);
	$seq = $seq.$str;
	if ($i<$#pos-1) {
		while ($bpt>=@pos[$i+1]) {
			print $fpt." ".$bpt."\n";
			if ($i & 1) {
				$fpos=@pos[$i]-1;
				$bpos=@pos[$i+1]-@pos[$i]+1;
				print GENES substr($seq,$fpos-$fpt,$bpos-$bpt,"")."\n";
				$fpt=$fpos+1;
				$bpt=$bpos+1;
			} else {
				$fpos=@pos[$i];
				$bpos=@pos[$i+1]-@pos[$i]-1;
				print INTER substr($seq,$fpos-$fpt,$bpos-$bpt,"")."\n";
				$fpt=$fpos+1;
				$bpt=$bpos+1;
			}		
			$i++;			
			print $i."\n";
			last if ($i>=$#pos-1);
		}
	}
}

close GENES;
close INTER;
close POSITIONS;
close SEQUENCE;