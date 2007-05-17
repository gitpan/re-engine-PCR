use strict;
use inc::Module::Install;

name 're-engine-PCR';

perl_version '5.009005';

author 'Ævar Arnfjörð Bjarmason <avar@cpan.org>';

abstract_from 'PCR.pm';
license_from  'PCR.pm';
version_from  'PCR.pm';

# PCR.pm
requires 'XSLoader';
requires 're::engine::Plugin'   => '0.02';
requires 'Pugs::Compiler::Rule' => '0.22';

# t/
build_requires 'Test::More' => 0; # 5.007003

tests 't/*.t';

auto_install;
WriteAll;
