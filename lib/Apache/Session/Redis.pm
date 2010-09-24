package Apache::Session::Redis;

use strict;
use base qw(Apache::Session::NoSQL);

our $VERSION = '0.01';

sub populate {
    my $self = shift;
    $self->{args}->{Driver} = 'Redis';
    return $self->SUPER::populate(@_);
}

1;
__END__

=pod

=head1 NAME

Apache::Session::Redis - An implementation of Apache::Session

=head1 SYNOPSIS

 use Apache::Session::Redis;
 
 tie %hash, 'Apache::Session::Redis', $id, {
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
