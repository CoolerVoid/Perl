#!/usr/bin/perl -io
# Coded By Cooler_, BSD license
$txt=$ARGV[0]; $cmd=$ARGV[1]; my @paper; my $cont=0; my %seen  = ( ) ; 
if((!$cmd)&&(!$txt)) {
 print "Url TRiad 0.1, clear any after the \"=\" string \n";
 print "follon example \"./programm.pl file.txt http:\/\/oi.com/sh.txt?\"\n";
} else {
 open(my $inj, "<$txt")|| die "error to open $txt $!\n";
 while(<$inj>) {
  if($_ =~ s/$\=.*/=$cmd/mg) {
   $paper[$cont].="$_"; $cont++;
   print "$_\n";
  }
 }
 close $inj; 
 print `./slowcat.pl -b 100000 art.ans`; sleep 1;
 my @unique  = grep {  ! $seen { $_  }++ } @paper ; 
 print "--------------\nTotal  $cont URLs cleareds\n";
 open my $out, '>', $txt; print {$out} @unique; close $out;
 print "save in $txt\n";
 close $out;
}
