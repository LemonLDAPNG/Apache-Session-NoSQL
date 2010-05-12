package Apache::Session::NoSQL;

use strict;
use base qw(Apache::Session);
use Apache::Session::Store::NoSQL;
use Apache::Session::Generate::MD5;
use Apache::Session::Lock::Null;
use Apache::Session::Serialize::Base64;
#use Apache::Session::Serialize::Storable;

use vars qw($VERSION);
$VERSION = '0.01';

sub populate {
    my $self = shift;

    $self->{object_store} = new Apache::Session::Store::NoSQL $self;
    $self->{lock_manager} = new Apache::Session::Lock::Null $self;
    $self->{generate}     = \&Apache::Session::Generate::MD5::generate;
    $self->{validate}     = \&Apache::Session::Generate::MD5::validate;
    $self->{serialize}    = \&Apache::Session::Serialize::Base64::serialize;
    $self->{unserialize}  = \&Apache::Session::Serialize::Base64::unserialize;
    #$self->{serialize}    = \&Apache::Session::Serialize::Storable::serialize;
    #$self->{unserialize}  = \&Apache::Session::Serialize::Storable::unserialize;

    return $self;
}

1;

__END__

=head1 NAME

Apache::Session::NoSQL

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
