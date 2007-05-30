=pod

Test the example given in the L<SYNOPSIS|re::engine::PCR/SYNOPSIS>.

=cut

use Test::More tests => 7;
use re::engine::PCR;

if ("abc" =~ /((.).)./) {
    is(${^MATCH}, "abc");
    is(${^MATCH}->from, 0);
    is(${^MATCH}->to,   3);
    is(${^MATCH}->[0], "ab");
    is($1, "ab");
    is(${^MATCH}->[0][0], "a");
    is($1->[0], "a");
}
