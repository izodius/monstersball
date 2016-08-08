#!/usr/bin/perl

use strict;
use warnings;
package Monsters;
use Mojo::Base 'Mojolicious';

sub startup {

	my $self = shift;
	
	# Set The Routes Available Godzilla is the main route, and public.  
	
	my $godzilla = $self->routes;
	
	# Mothra requires authorization from the under sub.
	# Consider it a child of Godzilla.  All routing done through Mothra is secured via the APIKEY
	# so calls to it must be like :  http://ourdomain.com/gmlu/lookup/331012?apikey=1235

	my $mothra = $godzilla->under ( 
		sub {
			my $self = shift;
			my $token = $self->param('apikey'); 
			if ( $token eq '1235' ) {
			 	return 1;
			 } else { 
				$self->render(text=> 'Access denied.', status=>'403');
				return undef;
			} 
		});


	# This is a public route / method (long way)
	
	$godzilla -> get('/') -> to (controller => 'Public', action => 'welcome');

	# EVERYTHING BELOW HERE IS A PROTECTED ROUTE DUE TO THE under EXECUTION.
	# under is a special action, that always occurs at the start of a route, so it always executes FIRST

	# This handles the GMLU.pm methods, add, lookup, etc.  
	# That's Global Monster Look Up :)
	# Standard naming convention would be Gmlu.pm but that's ugly for this situation.
	# Now not only is it standard but the first letter MUST be CAPS so Glmu is valid but glmu is not.

	# I've written these all three possible ways 
	# There's a very long way, a long way, and the short way.
	
	# the stupid very long way - note nothing passed via the stash
	$mothra -> route ('/gmlu/help') -> via ('GET') -> to (controller => 'GMLU', action => 'help');

	# long way - note monsterid is passed in the stash a call would look like
	# http://ourdomain.com/glmu/lookup/5403?apikey=1235
	$mothra -> get('/gmlu/lookup/:monsterid/') -> to (controller => 'GMLU', action => 'lookup');
	
	# short easy way  contoller#action alternatively think module#method
	$mothra -> get('/gmlu/activity/:monstername/') -> to ( 'GMLU#activity');
	#note: can use get/post/any /put?
}
1;
