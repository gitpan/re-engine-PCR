use 5.009005;
use strict;
use Test::More tests => 6;

use re::engine::PCR;

if ("abc" =~ /((.).)./) {
    pass "pattern matched";

    ok ${^MATCH}, '${^MATCH} true';
    isa_ok ${^MATCH}, 'Pugs::Runtime::Match';

    cmp_ok ${^MATCH}, 'eq', 'abc', 'stringified match';
    is ${^MATCH}->from, 0, '->from';
    is ${^MATCH}->to, 3, '->to';
} else {
    fail "didn't match";
}
