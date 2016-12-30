#!/usr/bin/env perl6
use v6;
use HTTP::Tinyish;
use JSON::Tiny;

my $http = HTTP::Tinyish.new: agent => 'Mozilla/4.0';
my %res = $http.get: "https://api.fixer.io/latest?base=USD;symbols=BRL";
my %data = from-json %res<content>;
say %data<rates><BRL>;
