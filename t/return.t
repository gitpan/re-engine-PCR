use Test::More tests => 1;
use re::engine::PCR;

if ("abc" =~ q/$<z> := (.) { return "bar" }/) {
    is(${^MATCH}->(), "bar");
}
