requires 'Dancer2';
requires 'GraphQL' => '0.17';
requires 'Dancer2::Plugin::GraphQL' => '0.03';

on test => sub {
    requires 'HTTP::Request::Common';
    requires 'JSON::MaybeXS';
    requires 'Plack::Test';
};

# END

