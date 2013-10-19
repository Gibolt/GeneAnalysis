open PROBBEG,">begPositionProbability.txt";
open PROBEND,">endPositionProbability.txt";
open BPROB,">begSeqProbability.txt";
open EPROB,">endSeqProbability.txt";
#open FREQ,">sequenceFrequency.txt";
open IN, "allMatchingHits.txt";


$lseq1=6;
$lseq2=6;
$cnt=0;
@comp = ("A", "T", "C", "G");

#while ($str = <IN>) {8
#	$cnt++;
%hBeg=(); %hEnd=();
for (1..24) {
#	push(@arr,%hash);
	push(@beg,0);
	push(@end,0);
}

print "\n---Find Position Frequencies\n";
print "(1/2) Calculating Position Frequencies...\n";
while($str = <IN>) {
#for ($cnt=1; $cnt<=20; $cnt++) {	
#	$str = <IN>;
	$cnt++;
	if ($str =~ m/\.([ATGC]+)\s/) {
		$begSeq=substr($1,0,$lseq1);
		$endSeq=substr($1,length($1)-$lseq2,$lseq2);
		$hBeg{$begSeq}+=1;
		$hEnd{$endSeq}+=1;
		print $cnt." ".$begSeq." ".$endSeq;
		for ($i=0; $i<6; $i++) {
#			$@arr[$i]{(substr($begSeq,$i,1))}+=1;
			$testBeg = substr($begSeq,$i,1);
			$testEnd = substr($endSeq,$i,1);
			for ($j=0; $j<4; $j++) {
				if ($testBeg eq $comp[$j]) {
					$beg[$i*4+$j]+=1;
				}
				if ($testEnd eq $comp[$j]) {
					$end[$i*4+$j]+=1;
				}
			}
		}
		print "\n";
	}
}
print "\n";
#print $hBeg;

#print "\n";
#while (($key, $value) = each(%hBeg)){
#     print $key.", ".$value."\n";
#}
#print "\n";
print "(2/2) Generating Results...\n";
print $cnt;

print PROBBEG $begSeq." ".$comp[0].$comp[1].$comp[2].$comp[3]."\n";
for ($i=0; $i<6; $i++) {
	print PROBBEG $beg[$i*4]." ".$beg[$i*4+1]." ".$beg[$i*4+2]." ".$beg[$i*4+3]."\n";
}

print PROBEND $endSeq." ".$comp[0].$comp[1].$comp[2].$comp[3]."\n";
for ($i=0; $i<6; $i++) {
	print PROBEND $end[$i*4]." ".$end[$i*4+1]." ".$end[$i*4+2]." ".$end[$i*4+3]."\n";
}

foreach $value (sort {$hBeg{$b} cmp $hBeg{$a}} keys %hBeg){
	print BPROB $value." ".($hBeg{$value}/$cnt*100)."\n";
};

foreach $value (sort {$hEnd{$b} cmp $hEnd{$a}} keys %hEnd){
	print EPROB $value." ".($hEnd{$value}/$cnt*100)."\n";
};

close PROBBEG;
close PROBEND;
close BPROB;
close EPROB;
close IN;