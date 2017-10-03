#!/usr/bin/env perl

use strict; use warnings;
use Dancer2;
use GraphQL::Schema;
use GraphQL::Type::Object;
use GraphQL::Type::Scalar qw/ $String /;
use GraphQL::Execution;

set serializer => 'JSON';
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

get '/graphiql' => sub {
    send_as html => template 'graphiql', {
        title            => 'GraphiQL',
        graphiql_version => '0.11.2',
        queryString      => safe_serialize( params->{'query'} ),
        operationName    => safe_serialize( params->{'operationName'} ),
        resultString     => safe_serialize( params->{'result'} ),
        variablesString  => safe_serialize( params->{'variables'} ),
    };
};

post '/graphiql' => sub {
    return GraphQL::Execution->execute(
        $schema,
        body_parameters->{'query'},
        undef,
        undef,
        body_parameters->{'variables'},
        body_parameters->{'operationName'},
        undef,
    );
};

my $JSON = JSON::MaybeXS->new->allow_nonref;

sub safe_serialize {
    my $data = shift or return 'undefined';

    my $json = $JSON->encode( $data );
    $json =~ s#/#\\/#g;

    return $json;
}

dance;

__END__
