package MyApp;
use Dancer2;
use GraphQL::Schema;
use GraphQL::Type::Object;
use GraphQL::Type::Scalar qw($String);
use GraphQL::Execution;

our $VERSION = '0.1';

set serializer => 'JSON'; # allows request->parameters get JSON, must send_as HTML if mean that

get '/' => sub {
    send_as html => template 'index' => { 'title' => 'MyApp' };
};

my $schema = GraphQL::Schema->new(query => GraphQL::Type::Object->new(
  name => 'QueryRoot',
  fields => {
    helloWorld => { type => $String, resolve => sub { 'Hello world!' } },
  },
));

post '/graphql' => sub {
  send_as JSON => GraphQL::Execution->execute($schema, body_parameters->{query});
};

get '/graphql' => sub {
  send_as html => template 'graphiql' => {
    title => 'GraphiQL',
    graphiql_version => '0.11.2',
    queryString => safe_serialise(params->{query}),
    operationName => safe_serialise(params->{operationName}),
    resultString => safe_serialise(params->{result}),
    variablesString => safe_serialise(params->{variables}),
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

true;
