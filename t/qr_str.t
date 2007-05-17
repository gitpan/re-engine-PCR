use 5.009005;
use strict;
use Test::More tests => 1;
use re::engine::PCR;

=head1 DESCRIPTION

Stringification of C<< qr// >>.

=cut

my $str = '<[a..z]>';
my $re = qr/$str/;

is("$re", $str);
