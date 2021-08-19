package Apache::Session::Store::NoSQL::CHI;

use strict;
use CHI;

our $VERSION = '0.1';

sub new {
    my ( $class, $session ) = @_;
    my $self;

    $self->{cache} = CHI->new( %{ $session->{args} } );

    bless $self, $class;
}

sub insert {
    my ( $self, $session ) = @_;
    $self->{cache}
      ->set( $session->{data}->{_session_id}, $session->{serialized} );
}

*update = *insert;

sub materialize {
    my ( $self, $session ) = @_;
    $session->{serialized} =
      $self->{cache}->get( $session->{data}->{_session_id} )
      or die 'Object does not exist in data store.';
}

sub remove {
    my ( $self, $session ) = @_;
    $self->{cache}->remove( $session->{data}->{_session_id} );
}

1;
__END__

=pod

=head1 NAME

Apache::Session::Store::NoSQL::CHI - An implementation of Apache::Session::Store

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

Copyright (C) 2021 Liam Widdowson

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
