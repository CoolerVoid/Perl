#!/usr/bin/perl -w
####################### Load Modulos
use Tk;
use utf8;
use DBI;
####################### Conectando DB
my $dbh=DBI->connect("dbi:SQLite:dbname=banco.db");
####################### Criando janela inicial
inicio:
   $mw = MainWindow->new;
   $mw->title ("SQLite agenda eletronica");
   $mw->Photo('logo', -file => "mago2.gif");
   $mw->Label('-image' => 'logo')->pack();
$mw->Button(
        -relief => 'groove',
        -text => 'Creditos',
        -command => sub{ creditos(); }
    )->pack(-side => 'top', -anchor => 'n');

$mw->Button(
        -relief => 'groove',
        -text => 'Adicionar cadastro',
        -command => sub{ adicionar(); }
    )->pack(-side => 'top', -anchor => 'n');

$mw->Button(
        -relief => 'groove',
        -text => 'Remover cadastro',
        -command => sub{ remover(); }
    )->pack(-side => 'top', -anchor => 'n');

$mw->Button(
        -relief => 'groove',
        -text =>'Procurar cadastro',
        -command => sub{ procurar(); }
    )->pack(-side => 'top', -anchor => 'n');
$mw->Button(
        -relief => 'groove',
        -text =>'Deletar todos cadastros',
        -command => sub{ removall(); $box->DESTROY; $scroll->DESTROY; list(); }
    )->pack(-side => 'top', -anchor => 'n');
list();

###################### Mostrando a lista de cadastros
sub list {
$box = $mw->Listbox(
         -selectmode => "browse",
         -relief => 'sunken',
         -height  => 12,
         -setgrid => 5,
    )->pack();
 my $sth=$dbh->prepare("SELECT * FROM agenda ORDER BY nome");
 $sth->execute();
 while ((@db)=$sth->fetchrow_array) {
 $box->insert('end', "nome: $db[0] tell: $db[1] cidade: $db[2]");  
 }
    #   $box->insert('end', $_);
    $scroll = $mw->Scrollbar(-command => ['yview', $box]);
    $box->configure(-yscrollcommand => ['set', $scroll]);
    $box->pack(-side => 'left',-fill => 'both', -expand => 1);
    $scroll->pack(-side => 'left', -fill => 'y');
}

sub creditos {
my $texto="Coded by c00l3r_\n\nthanks voidpointer,dr4k3,b4rtb0y,_mlk_,r0t3d,edenc,st4t1c\nbotecounix.com.br";
my $aviso1 =  MainWindow->new;
$aviso1->title ("Agenda com SQlite");
janela($aviso1, $texto);

sub janela {
        my ($window, $header) = @_;
        $window->Label( -relief => 'groove',
                        -text => $header)->pack;
        $window->Button(
            -relief => 'groove',
            -text    => 'Voltar',
            -command => [$window => 'destroy']
        )->pack;
}
}


sub procurar {
 my $m = MainWindow->new;

    $m->Label(-text => 'Digite um nome para procurar')->pack;
    my $procuranome = $m->Entry(-width => 30);
    $procuranome->pack;

    $m->Button(
       -text => 'procurar',
       -command => sub{procnome($procuranome); sleep 2; }
    )->pack;
}

sub remover {
 my $m = MainWindow->new;

    $m->Label(-text => 'Digite o nome do cadastrado para remover')->pack;
    my $name_remove = $m->Entry(-width => 30);
    $name_remove->pack;

    $m->Button(
       -text => 'remover',
       -command => sub{rm($name_remove); sleep 2; $m->DESTROY; $box->DESTROY; $scroll->DESTROY; list(); }
    )->pack;
}

sub adicionar {
 my $m = MainWindow->new;

    $m->Label(-text => 'Nome')->pack;
    my $name = $m->Entry(-width => 30);
    $name->pack;

    $m->Label(-text => 'Telefone')->pack;
    my $tell = $m->Entry(-width => 10);
    $tell->pack;

$m->Label(-text => 'cidade')->pack;
    my $city = $m->Entry(-width => 10);
    $city->pack;

    $m->Button(
       -text => 'adicionar',
       -command => sub{add($name, $tell, $city); sleep 2; $m->DESTROY; $box->DESTROY; $scroll->DESTROY; list(); }
    )->pack;
}

sub add {
 my ($name, $tell, $city) = @_ ;
 my $n=$name->get;
 my $t=$tell->get;
 my $c=$city->get;
 $dbh->do("INSERT INTO agenda \(nome, telefone, cidade\) VALUES \(\"$n\",\"$t\",\"$c\"\)");
}

sub rm {
my ($name_remove) = @_ ;
my $r=$name_remove->get;
$dbh->do("DELETE FROM agenda WHERE nome=\"$r\"");
}

sub removall {
$dbh->do("DELETE FROM agenda");
}

sub procnome {
my ($procuranome) = @_;
my $r=$procuranome->get;
my $sth=$dbh->prepare("SELECT * FROM agenda WHERE nome LIKE \'$r\'");
 $sth->execute();

$window =  MainWindow->new;
$window->title ("Agenda com SQlite");
        $window->Label( -relief => 'groove',
                        -text => 'RESULTADOS')->pack;
        $window->Button(
            -relief => 'groove',
            -text    => 'Voltar',
            -command => [$window => 'destroy']
        )->pack;
$box = $window->Listbox(
         -selectmode => "browse",
         -relief => 'sunken',
         -height  => 12,
         -setgrid => 5,
    )->pack();

while ((@db)=$sth->fetchrow_array) {
 $box->insert('end', "nome: $db[0] tell: $db[1] cidade: $db[2]");  
 }
    #   $box->insert('end', $_);
    $scroll = $window->Scrollbar(-command => ['yview', $box]);
    $box->configure(-yscrollcommand => ['set', $scroll]);
    $box->pack(-side => 'left', -fill => 'both', -expand => 1);
    $scroll->pack(-side => 'right', -fill => 'y');

}
MainLoop;
