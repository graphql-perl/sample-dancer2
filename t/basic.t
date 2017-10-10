use strict; use warnings;
use Test::More;
use Plack::Test;
use HTTP::Request::Common;
use JSON::MaybeXS;
use FindBin qw/ $RealBin /;
use lib "$RealBin/../lib";
use DemoApp;
my $app = 'DemoApp'->to_app;
my $test = Plack::Test->create( $app );

{
    my $response = $test->request( GET '/' );
    is $response->code, 200,                                            'Got a 200 response code from "/"';
    like $response->decoded_content, qr/Perl GraphQL Dancer2 Demo App/, 'Content as expected';
}

{
    my $response = $test->request( GET '/graphql', Accept => 'text/html' );
    is $response->code, 200,                                            'Got a 200 response code from "/graphql"';
    like $response->decoded_content, qr/React.createElement\(GraphiQL/, 'Content as expected';
}

{
    my $json = JSON::MaybeXS->new->allow_nonref;
    my $response = $test->request(
        POST '/graphql',
        content => $json->encode({ query => '{helloWorld}' }),
    );
    is $response->code, 200,                                            'Got a 200 response code from POSTing the schema';
    is_deeply eval { $json->decode( $response->decoded_content ) },
              { 'data' => { 'helloWorld' => 'Hello, world!' } },        'Content as expected';
}


done_testing;

__END__
