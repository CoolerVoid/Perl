#!/usr/bin/perl
use strict;
use warnings;
use GD::Graph::bars3d;

# exemplo de dados
my @notas = ('10','8','7','4','8','6','3');
my @muieh = ('mulher_melancia','tiazinha','daniele_winits','feiticeira','viviane_araujo','vivi_fernandez',
           'marcia_imperator');
# configurando as cores
my @colors;
for my $datum (@notas) {
push(@colors, get_color($datum));
}

# criando o grafico com dados
my @dataset = (\@muieh, \@notas);

# constructo para criar um novo grafico
my $graph = GD::Graph::bars3d->new( 400, 300 );

# Configurando grafico
$graph->set(
transparent       => '0',
bgclr             => 'lgray',
boxclr            => 'white',
fgclr             => 'gray',
x_label           => 'BotecoUnix.com.br',
y_label           => 'Boteco Unix qual a mais gostosa',
title             => 'Qual a mais Gostosa',
dclrs             => \@colors,
cycle_clrs        => 1, # ciclo de imagens
x_labels_vertical => 1,
);

# plot the graph
my $gd = $graph->plot(\@dataset);

# criando um arquivo "png" do grafico e pasando o grafico para o mesmo
open(IMG, ">gostosas.png") or die $!;
binmode IMG;
print IMG $gd->png;
# retorna a cor e nome
# para cada tipo da dado
sub get_color {
my $value = shift;
return "dpurple" if ($value == 6);
return "lpurple" if ($value == 8);
return "blue" if ($value == 7);
return "green" if ($value < 5); # tudo q for menor que 5 fica verde
return "yellow" if ($value < 4); # tudo que for menor q quatro fica amarelo
return "orange" if ($value == 10);
return "red" if ($value == 0);
}
