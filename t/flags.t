use 5.009005;
use strict;
use Test::More tests => 1;
use re::engine::PCR;

if ("abc" =~ /((.).)./) {
    pass 'matched';
}
