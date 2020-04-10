#!/usr/bin/env perl
$lualatex = 'lualatex -halt-on-error %O %S';
$biber = 'biber --bblencoding=utf8 -u -U --output_safechars %O %B';
$clean_ext = 'bbl';
push @generated_exts, 'run.xml';
