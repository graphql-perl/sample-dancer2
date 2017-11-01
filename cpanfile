requires 'Dancer2';
requires 'GraphQL' => '0.20'; # convert plugin
requires 'Dancer2::Plugin::GraphQL' => '0.05'; # convert plugin

on test => sub {
    requires 'HTTP::Request::Common';
    requires 'JSON::MaybeXS';
    requires 'Plack::Test';
};

# END

