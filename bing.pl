#!/usr/bin/perl -io
# load modules
use LWP;
use URI;
use HTML::TokeParser;
use Term::ANSIColor;
print color 'red';

sub limpa() {
 my $cmd=0; my $sys="$^O"; 
 if($sys eq "linux") { $cmd="clear"; } else {  $cmd="cls"; }
 print `$cmd`;
}

sub banner() {
 #print `./slowcat.pl -b 100000 art.ans`;
 print q{
     ___           __               __ 
    /  _/___ _  _ _\ |___  _ __  | /  \ |
    \_  \ . \ \/ / . / ._\| `_/ \_\\\  //_/
    /___/  _/\  /\___\___\|_|    .'/()\`.
        |_\  /_/                 \ \  / /   
 ::::::::: ::::::::::: ::::    :::  ::::::::  
 :+:    :+:    :+:     :+:+:   :+: :+:    :+: 
 +:+    +:+    +:+     :+:+:+  +:+ +:+        
 +#++:++#+     +#+     +#+ +:+ +#+ :#:        
 +#+    +#+    +#+     +#+  +#+#+# +#+   +#+# 
 #+#    #+#    #+#     #+#   #+#+# #+#    #+# 
 ######### ########### ###    ####  ########  
 ---------------------------------------------
               Coded By Cooler
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
 for($num=0; $num<=100; $num++) {
  $url=URI->new('http://www.bing.com/search');
  $url->query_form( 'q'=>$busca,'go'=>'','filt'=>'all','first'=>$num.'1' );
  $navegador=LWP::UserAgent->new;
  my $resultado=$navegador->get($url,@config);
  $res=$resultado->content;
  #open(OUT, ">>index.html"); print OUT "$res\n"; close(OUT);
  #$p = HTML::TokeParser->new("index.html");
  $p = HTML::TokeParser->new(\$res);
  while ($p->get_tag("cite")) {
      my @link = $p->get_trimmed_text("/cite");
      foreach(@link) { print "$_\n"; }
      open(OUT, ">>$txt"); print OUT "@link\n"; close(OUT);
      #unlink("index.html");
  }
 } 
 open(OUT,"<$txt"); $line=0; foreach(<OUT>) { if($_ =~ /\S/) { $line+=1; } }
 limpa(); banner();
 print "---------------\nTotal off links $line ,save in $txt\n"; 
 sleep 1; print color 'reset'; exit;
}
