use strict;
use warnings;
use Test::More;

{
  package TestApp;

  use base 'Catalyst';
  use Catalyst;
  use CatalystX::RoleApplicator;
  __PACKAGE__->setup;
}

{
  package TestRole;
  use Moose::Role;
}

my @classes = qw(request response dispatcher stats);
push @classes, 'engine' unless Catalyst->VERSION >= 5.90000;

for (@classes) {
  TestApp->${\"apply_$_\_class_roles"}('TestRole');
  ok(
    Class::MOP::class_of(TestApp->${\"$_\_class"})->does_role('TestRole'),
    "$_\_class does TestRole",
  );
}

done_testing;
