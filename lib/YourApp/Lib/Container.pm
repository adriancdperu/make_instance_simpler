package YourApp::Lib::Container;

use strict;
use warnings;
use utf8;

use parent qw(Micro::Container);
use Carp;
use Module::Pluggable::Object;
use YourApp;
use YourApp::Lib::Config::Base;

sub instance {
    my ($self) = @_;
    my $container = $self->SUPER::instance;
    {
        no strict 'refs';
        no warnings 'redefine';
        *{ __PACKAGE__ . '::instance' } = sub { $container };
    }
    $self->_initialize($container);

    return $container;
}

sub _initialize {
    my ( $self, $container ) = @_;

    __PACKAGE__->register_modules(
        namespace => 'YourApp::Model',
        args      => [ container => $container, ],
    );
}

sub register_modules {
    my ( $class, %args ) = @_;

    my $namespace = $args{namespace};
    my $module_args = $args{args} || [];

    croak unless ref $module_args eq 'ARRAY';

    my @modules = Module::Pluggable::Object->new(
        require          => 1,
        search_path      => [$namespace],
        on_require_error => sub {
            my ( $plugin, $error ) = @_;
            die "can't require ${plugin}:${error}";
        },
        $args{except} ? ( except => $args{except} ) : (),
    )->plugins;

    for my $module (@modules) {
        __PACKAGE__->register( $module => $module_args );
    }
}

1;
