package JSON::JOM::Plugins::JsonPath;

use 5.010;
use strict;
use utf8;

use Carp qw[];
use JSON::JOM qw[];
use JSON::Path qw[];
use Object::AUTHORITY;

BEGIN
{
	$JSON::JOM::Plugins::JsonPath::AUTHORITY = 'cpan:TOBYINK';
	$JSON::JOM::Plugins::JsonPath::VERSION   = '0.002';
}

sub extensions
{
	my ($class) = @_;
	return (
		['ARRAY', 'findNodes',    \&findNodes ],
		['HASH',  'findNodes',    \&findNodes ],
		['ARRAY', 'matchesPath',  \&matchesPath ],
		['HASH',  'matchesPath',  \&matchesPath ],
		);
}

sub findNodes
{
	my ($self, $path) = @_;
	Carp::croak("Must provide a path") unless $path;
	$path = JSON::Path->new("$path");
	return $path->values($self);
}

sub matchesPath
{
	my ($self, $path) = @_;
	Carp::croak("Must provide a path") unless $path;
	$path = JSON::Path->new("$path");
	
	if (grep { $_==$self } $path->values($self->rootNode))
	{
		return $self;
	}
	return;
}

1;

__END__

=head1 NAME

JSON::JOM::Plugins::JsonPath - search for nodes using JSONPath.

=head1 SYNOPSIS

 use JSON::JOM;
 
 my $jom = to_jom({
   test => {
     foo  => [{quux=>1},{quux=>2},{quux=>3}],
     bar  => [{quux=>4},{quux=>5},{quux=>6}],
   },
 });
 
 my @nodes = $jom->{test}->findNodes("\$[*][*]");
 foreach my $node (@nodes)
 {
   if ($node->matchesPath("\$[*]['bar'][*]"))
   {
     print "bar has object with quux=".$node->{quux}."\n";
   }
 }

=head1 DESCRIPTION

This JOM plugin adds the following method to JOM objects and arrays:

=over 4

=item * C<findNodes> - search for descendant nodes using a JSONPath path.

=item * C<matchesPath> - check to see if a node matches a search path.

=back

Note that the core JOM functionality includes a C<nodePath> method to get
a canonical JSONPath path for each node.

=head1 BUGS

Please report any bugs to L<http://rt.cpan.org/>.

=head1 SEE ALSO

L<JSON::JOM>, L<JSON::JOM::Plugins>.

L<JSON::Path>.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

Copyright 2010-2011 Toby Inkster

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=cut

