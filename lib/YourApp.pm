package YourApp;

use strict;
use warnings;
use utf8;

use YourApp::Base;

# Instance example

sub model {
    my ($self, $name) = @_;
    YourApp::Base->model($name);
}

1;

