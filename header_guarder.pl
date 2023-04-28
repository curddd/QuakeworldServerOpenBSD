#!/usr/bin/perl

die "Usage: $0 <directory_path>\n" unless @ARGV == 1;

$dir = $ARGV[0];

opendir($dh, $dir) or die "Can't open $dir: $!";

while (readdir $dh) {
    next unless /(.+)\.h$/;
    $header_file = "$dir/$_";
    $header_guard = uc $1 . "_H";
    $new_file = $header_file."tmp";
    open($fh_in, '<', "$header_file") or die "Can't open $header_file: $!";
    open($fh_out, '>', "$new_file") or die "Can't write to $new_file: $!";
    print $fh_out "#ifndef $header_guard\n";
    print $fh_out "#define $header_guard\n\n";
    while (<$fh_in>) {
        print $fh_out $_;
    }
    print $fh_out "\n#endif /* $header_guard */\n";
    close $fh_in;
    close $fh_out;
    rename $new_file, $header_file or die "Can't rename $new_file to $header_file: $!";
}
closedir $dh;

