open GENES,">geneSpace.txt";
open INTER,">intergeneSpace.txt";
open POSITIONS, "genePositions.txt";
open SEQUENCE, "sequence.fasta";

print "\n---Remove Gene Space\n";
print "(1/3) Reading Gene Positions...\n";
@pos = ();
@ppos = (0,0,0);
$str = <POSITIONS>;
if ($str =~ m/(\d+)\s(\d+)/) {
	@pos[0]=$1;
	@pos[1]=$2;
}
print @pos;

print "\n(2/3) Assembling Nucleotide Sequence...\n$#pos\n";
$i=-1;   #position in pos array
$j=1;
$fpt=1;  #position of front point in substr
$bpt=0;  #position of back point in substr
$seq="";
while ($str = <SEQUENCE>) {
	chomp $str;
	$seq = $seq.$str;
	$bpt+=length($str);
#	print $i."  ".$seq."  ".$bpt."\n";
	if ($i==-1) {
		if ($bpt>@pos[0]) {
			$remain=substr($seq, 0, @pos[0]-1);
			$seq=substr($seq, @pos[0]-1, @pos[1]-@pos[0]+1);
#			print $seq."\n";
			$fpt+=@pos[1]-@pos[0]-1;
			$i=0;
			@pos[2]=@pos[1];
#			print $j++."\n";
		}		
	}
	elsif ($i==0) {
		if ($bpt>=@pos[1]) {
			print GENES substr($seq,$fpt-@pos[0],@pos[1]-@pos[0]+1)."\n";
#			print substr($seq,$fpt-@pos[0],@pos[1]-@pos[0]+1)." ";
			$seq=substr($seq,@pos[1]-$fpt+1);
			$fpt=@pos[1]+1;
#			print $fpt." ".$seq."\n";
			$i=1;
			if ($str = <POSITIONS>) {
				if ($str =~ m/(\d+)\s(\d+)/) {
					@pos[0]=$1;
					@pos[1]=$2;
				}
			}
			else {
#				print "\nRemainder: ".$seq;
				last;
			}
#			print $j++."\n";
		}
	}
	elsif ($i==1) {
		if ($bpt>@pos[0]) {
			print INTER substr($seq,$fpt-@pos[2]-1,@pos[0]-@pos[2]-1)."\n";
#			print substr($seq,$fpt-@pos[2]-1,@pos[0]-@pos[2]-1)." ";
			$seq=substr($seq,$fpt-@pos[2]+3);
			$fpt=@pos[0];
#			print $fpt." ".$seq."\n";
			$i=0;
			@pos[2]=@pos[1];
			print $j++."\n";
		}
	}
}
print INTER $seq.$remain;

close GENES;
close INTER;
close POSITIONS;
close SEQUENCE;