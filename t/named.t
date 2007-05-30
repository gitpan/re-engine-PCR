use Test::More tests => 2;
use re::engine::PCR;

if ("123" =~ q/$<x> := (.) $<y> := (.)/) {
    is($+{x}, "1");
    is($+{y}, "2");
}
