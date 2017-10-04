requires 'Dancer2';
requires 'GraphQL';

on test => sub {
    requires 'HTTP::Request::Common';
    requires 'JSON::MaybeXS';
    requires 'Plack::Test';
};

# END

