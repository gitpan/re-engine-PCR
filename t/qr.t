use strict;
use Test::More skip_all => "TODO: implement";# 'no_plan';
use re::engine::PCR;

my $rule = qr[
    rule: \$<x> = ([ab|z])
];

my $token = qr[
    token: \$<x> = ([ab|z])
];

my $regex = qr[
    regex => \$<x> = ([ab|z])
];

$pattern =~ s/ ^ \s* ([Rr]ule|[Tt]oken|[Rr]egex) \s* (?: => | :) \s* //xs;

$regex->install( rule => 
