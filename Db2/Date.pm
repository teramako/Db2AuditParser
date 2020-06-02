package Db2::Date;
use strict;
use Exporter qw(import);
use Time::Local;
use POSIX qw(strftime floor);

our @EXPORT = qw(db2parsedate db2strftime);

sub db2parsedate ($) {
  my $s = shift;
  my $microSec = int(substr($s,20,6)) / 1000000;
  my @t = (
    int(substr($s,17, 2)),
    int(substr($s,14, 2)),
    int(substr($s,11, 2)),
    int(substr($s, 8, 2)),
    int(substr($s, 5, 2)) -1,
    int(substr($s, 0, 4)) - 1900
  );
  return timelocal(@t) + $microSec;
}
sub db2strftime ($;$) {
  my ($time, $fmt) = @_;
  my $epoch = floor($time);
  my $microSec = sprintf("%06d", ($time - $epoch) * 1000000);
  if ($fmt) {
    $fmt =~ s/(?<!%)%f/$microSec/g;
    return strftime($fmt, localtime($epoch));
  }
  return strftime("%Y/%m%/%d %H:%M:%S.$microSec", localtime($epoch));
}
1;
__END__

=head1 NAME

Db2::Date - parse Db2 datetime format string and reformat

=head1 SYNOPSIS

    use Db2::Date;

    my $epoch = db2parsetime("2020-01-02-03.04.05.6789012");
    my $datestr = db2strftime($epoch, "%Y-%m-%dT%H:%M:%S");

=head1 FUNCTIONS

=head2 db2parsetime

Parses Db2 Timestamp format string and returns EPOCH time (+ microseconds).

=head2 db2strftime

Almost same as C<POSIX::strftime()>, but can use C<%f> (microseconds) format.

Arguments:

=over 4

=item 1.
EPOCH time

=item 2.
format, C<%Y/%m/%d %H:%M:%S.%f> is used if omitted.

=back

