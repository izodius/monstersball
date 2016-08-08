#!/usr/bin/perl

use strict;
use warnings;
package Monsters::Controller::Public;
use Mojo::Base 'Mojolicious::Controller';

sub welcome {

	my $self = shift;
	$self->render(text=> 'Look you got here, and you don\'t know what you\'re doing.  Go away.');
#	$self->render(json => { ObjectName => [1, 'test', 3], Object2 => 'hello'});

};

1;
