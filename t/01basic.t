use Test::More tests => 4;
BEGIN { use_ok('JSON::JOM') };
BEGIN { use_ok('JSON::JOM::Plugins::JsonPath') };

my $jom = JSON::JOM::to_jom({});

ok($jom->can('findNodes'), 'JOM can findNodes');
ok($jom->can('findNodes'), 'JOM can matchesPath');

#ok($jom->matchesPath('$'), 'JOM matchesPath seems to work');
#ok($jom->findNodes('$'), 'JOM findNodes seems to work');
#ok(!$jom->findNodes('$[0]'), 'JOM findNodes seems to work - 2');
