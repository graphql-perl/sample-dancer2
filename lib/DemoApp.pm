use strict; use warnings;

package DemoApp;

use Dancer2;
use GraphQL::Schema;
use Dancer2::Plugin::GraphQL;

set charset    => 'UTF-8';
set template   => 'simple';
set plugins => { 'GraphQL' => { graphiql => 1 } }; # equivalent of config file

get '/' => sub {
    send_as html => template 'index', {
        title => 'Perl-GraphQL demo app',
    };
};

my $schema = GraphQL::Schema->from_doc(<<'EOF');
schema {
  query: QueryRoot
}
type QueryRoot {
  helloWorld: String
}
EOF

graphql '/graphql' => $schema, { helloWorld => 'Hello, world!' };

1; # return true

__END__
