package YourApp::Base;

use strict;
use warnings;
use utf8;

use YourApp::Lib::Container;

my $container;

sub container {
    unless ( defined($container) ) {
        $container = YourApp::Lib::Container->instance;
    }
    return $container;
}

# your methods e.g. sub log { my ($class) = @_; $class->container->get('.... 

1;

