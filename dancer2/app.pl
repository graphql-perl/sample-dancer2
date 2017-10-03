#!/usr/bin/env perl

use strict; use warnings;
use Dancer2;
use GraphQL::Schema;
use GraphQL::Type::Object;
use GraphQL::Type::Scalar qw($String);
use GraphQL::Execution;

set serializer => 'JSON'; # allows request->parameters get JSON, must send_as HTML if mean that
set layout     => 'main';
set charset    => 'UTF-8';
set template   => 'simple';

my $schema = GraphQL::Schema->new(
    query => GraphQL::Type::Object->new(
        name => 'QueryRoot',
        fields => {
            helloWorld => { type => $String, resolve => sub { 'Hello, world!' } },
        },
    ),
);

get '/' => sub {
    send_as html => template 'index', {
        title => 'Perl-GraphQL demo app',
    };
};

post '/graphiql' => sub {
  send_as JSON => GraphQL::Execution->execute(
    $schema,
    body_parameters->{query},
    undef,
    undef,
    body_parameters->{variables},
    body_parameters->{operationName},
    undef,
  );
};

get '/graphiql' => sub {
    use Data::Dumper;
    warn "PARAMS " . Dumper params;
    send_as html => template 'graphiql', {
        title            => 'GraphiQL',
        graphiql_version => '0.11.2',
        queryString      => safe_serialise(params->{query}),
        operationName    => safe_serialise(params->{operationName}),
        resultString     => safe_serialise(params->{result}),
        variablesString  => safe_serialise(params->{variables}),
    };
};

my $JSON = JSON::MaybeXS->new->allow_nonref;
# spelled rite
sub safe_serialise {
  my ($data) = @_;
  return 'undefined' if !$data;
  my $json = $JSON->encode($data);
  $json =~ s#/#\\/#g;
  $json;
}

dance;

__END__
