#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";


# use this block if you don't need middleware, and
# only have a single target Dancer app to run here
use MyApp;

MyApp->to_app;

=begin comment

# use this block if you want to include middleware such as
# Plack::Middleware::Deflater (if you have it installed)
use MyApp;
use Plack::Builder;

builder {
    enable 'Deflater';
    MyApp->to_app;
}

=end comment

=cut

=begin comment

# use this block if you are serving more than one app
use MyApp;
use MyApp_admin;

builder {
    mount '/'      => MyApp->to_app;
    mount '/admin' => MyApp_admin->to_app;
}

=end comment

=cut

