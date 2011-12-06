#!/usr/bin/perl -io
use HTTP::Request;
use LWP::UserAgent;
use Term::ANSIColor;
use threads;  $|++;

sub limpa() {
 my $cmd=0; my $sys="$^O"; 
 if($sys eq "linux") { $cmd="clear"; } else {  $cmd="cls"; }
 print `$cmd`;
}

sub banner() {
 print `./slowcat.pl -b 100000 art.ans`;
 print color 'green';
 print q{
Hulk
  _________                   __________   _____.__ 
 /   _____/ ____ _____    ____\______   \_/ ____\__|
 \_____  \_/ ___\\\\__  \  /    \|       _/\   __\|  |
 /        \  \___ / __ \|   |  \    |   \ |  |  |  |
/_______  /\___  >____  /___|  /____|_  / |__|  |__|
        \/     \/     \/     \/       \/       
 ---------------------------------------------
         LFI and RFI Scan Coded By Cooler
 ---------------------------------------------
                 Version 0.1
}
}

sub process() {
@pro=@_; my $page=$pro[0]; my $url=$pro[1]; my $busca=$pro[2];
if ($page =~ m/$busca/) { 
         open (TA, ">>vuln.txt"); 
         print TA "$url\n"; close(TA);            
         print color 'red';
         print "Vulnerable: $url";
         print color 'green';
         $vuln.="$url";
       } 
}

sub spyder() {
 unlink("resposta.txt");
 my @page=@_; my $site=$page[0];
$ua = new LWP::UserAgent; $ua->timeout(5); 
 my $pedido1 = new HTTP::Request GET =>"$site";
 my $resposta1 = $ua->request($pedido1);
 if ($resposta1->is_success) { 
  my $res1 = $resposta1->content;
  return "$res1";
 } else { return 0; }
}

my $busca=$ARGV[0]; my $txt=$ARGV[1];
print "Searching to: $busca\n and save in $txt\n\n";
 
 if(($busca=~/\S/)&&($txt=~/\S/)) { 
  &limpa; &banner;
  print "search to $busca in links in file $txt\n"; sleep 2;
  open(OUT,"<$txt");
   while (<OUT>) {
     my $url="http:\/\/$_"; my $page=&spyder($url);
      if(!$page) {} else { 
       print "scan: $url"; 
       my $thr1 = threads->create(\&process, "$page","$url","$busca");
      }
     foreach (threads->list){ $_->join; }
   }
  close(OUT); &banner(); 
  print "Sites with word $busca saved in \"vuln.txt\"\n\n";
  print "$vuln\n"; print color 'red on_black';
  sleep 1; print color 'reset'; exit;
 } else { 
   &limpa(); &banner(); 
   print "error, please follow example\n ./programm dork file.txt\n";
   sleep 3; &limpa();  exit;  
 }
