package re::engine::PCR;
use 5.009005;
use strict;
use base 'Regexp';

use re::engine::Plugin ();

use Pugs::Compiler::Token;
use Pugs::Compiler::Regex;
use Pugs::Compiler::Rule;

our $VERSION = '0.01_01';

sub import
{
    # Populates %^H with re::engine::Plugin hooks
    re::engine::Plugin->import(
        comp => \&comp,
        exec => \&exec,
    );
}

*unimport = \&re::engine::Plugin::unimport;

sub comp
{
    my ($re) = @_;

    # The /pattern/
    my $pattern = $re->pattern;

    # The /flags
    my %mod = $re->mod;

    # Options for PCR
    my %option;

    $option{Perl5}    = 1 if exists $mod{s};
    $option{sigspace} = 0 if exists $mod{x};
    $option{ratchet}  = 1 if exists $mod{i};

    # Compile a PCR with the pattern & our flags
    my $rule = Pugs::Compiler::Rule->compile( $pattern => \%option );

    # Put the rule object in the stash to use in ->exec
    $re->stash( $rule );

    # Return value discarded
    undef;
}

sub exec
{
    my ($re, $str) = @_;

    # Get the rule object from the stash
    my $rule = $re->stash;

    # Get a match object for this string
    my $match = $rule->match( $str );

    # No match, return false
    return unless $match;

    # Named captures, $1->[0] eqv $match->[0][0]
    $re->num_captures(
        FETCH => sub {
            my ($re, $n) = @_;

            # $` & $'
            return if $n < 0;

            # $& | ${^MATCH}
            return $match if $n == 0;

            # $1, $2, ...
            return $match->[$n - 1];
        }
    );

    # Matched
    return 1;
}

__END__

=head1 NAME

re::engine::PCR - L<Pugs::Compiler::Rule> regex engine

=head1 SYNOPSIS

    use 5.10;
    use re::engine::PCR;

    if ("abc" =~ q/((.).)./) {
        say ${^MATCH};           # "abc"
        say ${^MATCH}->from;     # 0
        say ${^MATCH}->to;       # 3
        say ${^MATCH}->[0];      # "ab"
        say $1;                  # "ab" (same as above)
        say ${^MATCH}->[0][0];   # "a"
        say $1->[0];             # "a"  (same as above)
    }

=head1 DESCRIPTION

Replaces the perl regular expression engine in a given lexical scope
with the engine provided by L<Pugs::Compiler::Rule>.

=head1 CAVEATS

Although C<< $& >> is more succinct than C<< ${^MATCH} >> using the
former (along with C<< $` >> and C<< $' >>) imposes a considerable
performance penalty on all regular expression matches, so don't do
that.

=head1 TODO

=over

=item *

Sends a SEGV in blead with L<Pugs::Compiler::Rule> 0.22, let's smoke this!

=item *

Doesn't handle C<s///> and C<split //>, see L<re::engine::Plugin's
TODO|re::engine::Plugin/TODO>.

=back

=head1 BUGS

Please report any bugs that aren't already listed at
L<http://rt.cpan.org/Dist/Display.html?Queue=re-engine-PCR> to
L<http://rt.cpan.org/Public/Bug/Report.html?Queue=re-engine-PCR>

=head1 AUTHOR

E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason <avar@cpan.org>

=head1 LICENSE

Copyright 2007 E<AElig>var ArnfjE<ouml>rE<eth> Bjarmason.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut
