use 5.009005;
use strict;
use Test::More 'no_plan';#tests => 7;
use re::engine::PCR;

if ("abc" =~ /((.).)./) {
    pass 'zomg';
#    is($1->[0], "a");
}
