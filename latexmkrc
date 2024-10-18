@default_files                     = ('main.tex');
$cleanup_includes_cusdep_generated = 1;
add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
add_cus_dep( 'glo', 'gls', 0, 'makeglossaries' );
$clean_ext .=
  " aux bbl blg idx ind lof lot out toc acn acr alg glg glo gls xdy";
$clean_ext .=
" fls log fdb_latexmk snm synctex(busy) synctex.gz(busy) nav %R.mtc* maf tdo pyh %R.figlist";
# Uncomment to clean generated figures when running latex clean command
# $clean_ext .=
#   " _%R_tikz_externalize_out/* %R-figure*";
$clean_ext .=
  " %R.makefile fls.tmp";
  

sub makeglossaries {
    my ( $base_name, $path ) = fileparse( $_[0] );
    my @args = ( "-d", $path, $base_name );
    if ($silent) { unshift @args, "-q"; }
    return system "makeglossaries", @args;
}
