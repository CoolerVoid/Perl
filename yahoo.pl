#!/usr/bin/perl -io
# load modules
use LWP;
use URI;
use HTML::TokeParser;
use Term::ANSIColor;
print color 'yellow on_black';

sub limpa() {
 my $cmd=0; my $sys="$^O"; 
 if($sys eq "linux") { $cmd="clear"; } else {  $cmd="cls"; }
 print `$cmd`;
}

sub banner() {
 print q{
     ___           __               __ 
    /  _/___ _  _ _\ |___  _ __  | /  \ |
    \_  \ . \ \/ / . / ._\| `_/ \_\\\  //_/
    /___/  _/\  /\___\___\|_|    .'/()\`.
        |_\  /_/                 \ \  / /   
                     _____.___.      .__                   
                     \__  |   |____  |  |__   ____   ____  
                      /   |   \__  \ |  |  \ /  _ \ /  _ \ 
                      \____   |/ __ \|   Y  (  |_| |  |_| )
                      / ______(____  /___|  /\____/ \____/ 
                      \/           \/     \/               

 ---------------------------------------------
               Coded By Cooler_
 ---------------------------------------------
                 Version 0.1
}
}

my @config = (
 'User-Agent'=>'Mozilla/4.76 [en] (Win98; U)',
 'Accept'=>'image/gif,image/x-xbitmap,image/jpeg,image/pjpeg,image/png, */*',
 'Accept-Charset'=>'iso-8859-1',
 'Accept-Language'=>'en-US',
);

$busca=$ARGV[0]; $txt=$ARGV[1];
print "Searching to: $busca\n save in $txt\n\n";
if((!$busca)&&(!$txt)) { banner(); print "Please follow the example ./programm dork file.txt\n"; 
              print color 'reset'; exit; 
}

if(($busca)&&($txt)) { 
 for($num=1; $num<=100; $num+=10) {
  $url=URI->new('http://cade.search.yahoo.com/search');
  $url->query_form( 'p'=>$busca,'xargs'=>"0",'pstart'=>"1",'b'=>$num);
  $navegador=LWP::UserAgent->new;
  my $resultado=$navegador->get($url,@config);
  $res=$resultado->content;
  $p = HTML::TokeParser->new(\$res);
  while (my $token = $p->get_tag("a")) {
      my @clear; my @link = $token->[1]{href} || "-";
       my $text = $p->get_trimmed_text("/a");
      foreach(@link) { 
        if($_ =~ /^http\:\/\/cd\.wrs\.yahoo\.com\// ) {
         if($_ =~ s/.*3a\/\//http:\/\//) { 
          if($_ =~ /yahoo|74\.6/) { next; } 
          @clear="$_"; print "$_\n"; 
         }
        }
      }
   open(OUT, ">>$txt"); print OUT "@clear\n"; close(OUT);
  }
 }
 
 open(OUT,"<$txt"); $line=0; foreach(<OUT>) { if($_ =~ /\S/) { $line+=1; } }
 limpa(); banner();
 print "---------------\nTotal off links $line ,save in $txt\n"; 
 sleep 1; print color 'reset'; exit;
}
