package Apache::Session::Store::NoSQL::Redis;

use strict;
use Redis;

our $VERSION = '0.01';

sub new {
    my ( $class, $session ) = @_;
    my $self;

    $self->{cache} = Redis->new( %{$session} );
    print STDERR Dumper(\@_);use Data::Dumper;

    bless $self, $class;
}

sub insert {
    my ( $self, $session ) = @_;
    $self->{cache}->set($session->{data}->{_session_id},$session->{serialized});
}

*update = *insert;

sub materialize {
    my ( $self, $session ) = @_;
    $self->{cache}->get($session->{data}->{_session_id}) or die 'Object does not exist in data store.';
}

sub remove {
    my ( $self, $session ) = @_;
    $self->{cache}->del($session->{data}->{_session_id});
}

1;
__END__
=pod

=head1 NAME

Apache::Session::Store::NoSQL::Redis - An implementation of Apache::Session::Store

=head1 SYNOPSIS

 use Apache::Session::NoSQL;

 #if you want Apache::Session to open new DB handles:

 tie %hash, 'Apache::Session::MySQL', $id, {
    Driver => 'Redis',
    # optional: default to localhost
    server => '127.0.0.1:6379',
 };

=head1 DESCRIPTION

This module is an implementation of Apache::Session::NoSQL. It uses the Redis
storage system

=head1 AUTHOR

This module was written by Xavier Guimard <x.guimard@free.fr>

=head1 SEE ALSO

L<Apache::Session::NoSQL>, L<Apache::Session>
