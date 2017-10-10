use strict; use warnings;

package DemoApp;

use Dancer2;
use GraphQL::Schema;
use GraphQL::Type::Object;
use GraphQL::Type::Scalar qw/ $String /;
use Dancer2::Plugin::GraphQL;

set charset    => 'UTF-8';
set template   => 'simple';
set plugins => { 'GraphQL' => { graphiql => 1 } }; # equivalent of config file

get '/' => sub {
    send_as html => template 'index', {
        title => 'Perl-GraphQL demo app',
    };
};

my $schema = GraphQL::Schema->new(
    query => GraphQL::Type::Object->new(
        name => 'QueryRoot',
        fields => {
            helloWorld => {
                type => $String,
                resolve => sub { 'Hello, world!' },
            },
        },
    ),
);

graphql '/graphql' => $schema;

1; # return true

__END__
