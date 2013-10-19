print "Preparing to run all scripts...\n"

system "perl 1_createListOfGenes.pl" || die "Cannot open createListOfGenes.pl"
system "perl 2_removeGeneSpace.pl" || die "Cannot open removeGeneSpace.pl"
system "perl 3_locateSequences.pl" || die "Cannot open locateSequences.pl"
system "perl 4_findPositionFrequencies.pl" || die "Cannot open findPositionFrequencies.pl"

print "\nRunning all scripts complete!"