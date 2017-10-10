requires 'Dancer2';
requires 'GraphQL';
requires 'Dancer2::Plugin::GraphQL';

on test => sub {
    requires 'HTTP::Request::Common';
    requires 'JSON::MaybeXS';
    requires 'Plack::Test';
};

# END

