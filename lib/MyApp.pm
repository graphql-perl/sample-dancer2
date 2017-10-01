package MyApp;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'MyApp' };
};

get '/graphql' => sub {
  template 'graphiql' => {
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
