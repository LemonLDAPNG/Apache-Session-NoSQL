package Apache::Session::Store::NoSQL;

use strict;

use vars qw($VERSION);
$VERSION = '0.01';

sub new {
    my ( $class, $session ) = @_;
    my $self;

    if ( $session->{args}->{Driver} ) {
      my $driver = $session->{args}->{Driver};
      $self->{driver} = $driver
      $self->{cache} = new Apache::Session::Store::NoSQL::$driver;
    }
    else {
      die 'No driver specified.';
    }

    bless $self,$class;
}

sub insert {
    my ( $self, $session ) = @_;
    $self->{cache}->set(
        $session->{data}->{_session_id},
        $session->{serialized} );
}

sub update {
    my ( $self, $session ) = @_;
    $self->{cache}->replace(
        $session->{data}->{_session_id},
        $session->{serialized} );
}

sub materialize {
    my ( $self, $session ) = @_;
    $session->{serialized} = $self->{cache}->get(
        $session->{data}->{_session_id})
        or die 'Object does not exist in data store.';
}

sub remove {
    my ( $self, $session ) = @_;
    $self->{cache}->delete( $session->{data}->{_session_id} );
}

1;

__END__

=head1 NAME

Apache::Session::Store::NoSQL

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 SEE ALSO

=head1 AUTHOR

Thomas Chemineau, E<lt>thomas.chemineau@gmail.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2010 by Thomas Chemineau

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.10.0 or,
at your option, any later version of Perl 5 you may have available.

=cut
