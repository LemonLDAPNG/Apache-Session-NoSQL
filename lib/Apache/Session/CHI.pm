package Apache::Session::CHI;

use strict;
use base qw(Apache::Session::NoSQL);

our $VERSION = '0.1';

sub populate {
    my $self = shift;
    $self->{args}->{Driver} = 'CHI';
    return $self->SUPER::populate(@_);
}

1;
__END__

=pod

=head1 NAME

Apache::Session::CHI - An implementation of Apache::Session

=head1 SYNOPSIS

 use Apache::Session::NoSQL;
 
 tie %hash, 'Apache::Session::NoSQL', $id, {
        Driver => 'CHI',
	# CHI arguments
	driver => 'Memory', global => 1, expires_in => 3600,
 };

=head1 DESCRIPTION

This module is an implementation of Apache::Session::NoSQL. It uses the CHI
caching framework. This permits using any number of CHI back-ends and 
level 1 caches, etc. You should specify the expiry time of the cache
to match your sessions in the constructor.

=head1 AUTHOR

This module was written by Liam Widdowson.

=head1 SEE ALSO

L<Apache::Session::NoSQL>, L<Apache::Session>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2021 by Liam Widdowson

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
