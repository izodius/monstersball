#!/usr/bin/perl

use strict;
use warnings;
package Monsters::Controller::GMLU;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON;

# Let's define some data into some hashes (ok these are kind of arrays, just deal with it)
# Just assume when we're hitting them, we'd normally be using a MySQL db


my %monstername = (
	1 => 'Godzilla',
	2 => 'Mothra',
	3 => 'Gigan',
	4 => 'Rodan'
);


my %monsteract = (
	'Godzilla' => 'Thrashing Tokyo.',
	'Mothra'   => 'Knocking out New York',
	'Gigan'    => 'Chillin in California',
	'Rodan'    => 'Wrecking Russia'
);


sub help {
	my $self = shift;
	$self->render(text => 'Here it is.');
	#$self->render(json => { Option => '1' , OptionName => 'lookup'};
	#$self->render(json => { Option => '2' , OptionName => 'activity'};
};

sub lookup {

	my $self = shift;
	my $monster_id = $self->stash('monsterid');
	my $monster_name = $monstername { $monster_id };
	
	if ($monster_name) {
		$self->render(json => { MonsterId => $monster_id, MonsterName => $monster_name } );
	} else {
		$self->render(json => { MonsterId => $monster_id, MonsterName => 'Error no monster found.' } );
	}
	
};


sub activity {
	
	my $self = shift;
	# lets make this case insensitive but pretty so the caller doesn't have to be precise
	my $monster_name_in = ucfirst (lc $self->stash('monstername'));
	my $monster_act = $monsteract { $monster_name_in };
	
	if ($monster_act) {
		$self->render(json => { MonsterId => $monster_name_in, MonsterActivity => $monster_act } );
	} else {
		$self->render(json => { MonsterId => $monster_name_in, MonsterActivity => 'Error no monster found.' } );
	}
};

1;
