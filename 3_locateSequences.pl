open HIT,">allMatchingHits.txt";
open IN, "intergeneSpace.txt";

$seq1="TTGACA";
$seq2="TATAAT";
$lseq1=$#seq1;
$lseq2=$#seq2;
$dis1=15;
$dis2=19;
$cnt=0;

print "\n---Locate Gene Sequences\n";
print "(1/2) Finding All Sequence Hits...\n";
while ($str = <IN>) {
	$cnt++;
#for ($cnt=1; $cnt<=50; $cnt++) {
	@beg=();
	@end=();
	print $cnt."\n";
#	$str = <IN>;
	$pos=0;
#	while (length($str)-$pos < $dis2-$dis1-$lseq2) {
	while ($#str-$pos > $dis1+$lseq1+$lseq2) {
		push(@beg,&seqCount($seq1, substr($str,$pos,$lseq1)));
		push(@end,&seqCount($seq2, substr($str,$pos+$dis1+$lseq1,$lseq2)));
		$pos++;
	}
	for ($i=0; $i<=$#beg; $i++) {
		$j=0;
		while ($i+$j+$dis1+$lseq1+$lseq2 <= $i+$dis2+$lseq1+$lseq2 && $i+$j+$dis1+$lseq1+$lseq2 <= $#str) {
			if (@beg[$i]+@end[$i+$j]>=8) {
				print HIT $cnt.".".($i+1).".".($i+$j+$dis1+$lseq1+$lseq2).".".substr($str,$i,$j+$dis1+$lseq1+$lseq2)."\n";
#				print ($i+1).".".($i+$j+$dis1+$lseq1+$lseq2).".".substr($str,$i,$j+$dis1+$lseq1+$lseq2)."\n";
			}
			$j++;
		}
	}
}

print "(2/2) Generating Results...\n";
sub seqCount {
	my($seq, $in) = @_;	
	$total = 0;
	for ($i = 0; $i<$#seq; $i++) {
		if (substr($seq,$i,1) eq substr($in,$i,1)) {
			$total++;
		}
	}
	return $total;
}

close HIT;
close IN;