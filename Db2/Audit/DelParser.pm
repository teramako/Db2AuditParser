package Db2::Audit::DelParser;
use strict;
use Carp;
use constant {
  MODE_NORMAL => 0,
  MODE_NON_QUOTE => 1,
  MODE_IN_QUOTE => 2,
  CH_SPACE => 0x20,
  CH_COMMA => 0x2c,
  CH_TAB => 0x09,
  CH_LF => 0x0a,
};

sub new {
  my $class = shift;
  my %args = ref $_[0] eq "HASH" ? %{@_} : @_;
  my $self = {
    FH => $args{Handler} || undef,
    File => $args{File} || undef,
    Package => $args{Package} || 'Db2::Audit::RecordBase',
    Delimiter => $args{Delimiter} || '"',
    _packageLoaded => 0,
    _rawRecordIterator => undef,
    currentRecord => undef,
    currentRecordCount => 0,
  };
  return bless $self, $class;
}
sub loadPackage {
  my ($self, $pkg) = @_;
  if (defined $pkg) {
    return $pkg if ($pkg eq $self->{Package} and $self->{_packageLoaded});
    $self->{Package} = $pkg;
    $self->{_packageLoaded} = 0;
  } elsif ($self->{_packageLoaded}) {
    return $self->{Package};
  }
  eval qq(require $self->{Package}) or confess "$@";
  $self->{_packageLoaded} = 1;
  return $self->{Package};
}
sub open {
  my $self = shift;
  if (defined $self->{FH}) {
    return $self->{FH};
  }
  if (defined $_[0]) {
    $self->{File} = $_[0];
  }
  CORE::open($self->{FH}, "<:raw", $self->{File}) or croak "$!";
  return $self->{FH};
}
sub close {
  my $self = shift;
  if (defined $self->{FH}) {
    CORE::close($self->{FH}) or croak "$!";
    $self->{FH} = undef;
    $self->{_rawRecordIterator} = undef;
    $self->{currentRecord} = undef;
    $self->{currentRecordCount} = 0;
  }
}
sub header {
  my $self = shift;
  my $pkg = $self->loadPackage();
  no strict 'refs';
  return map { $_->{name} } @{"${pkg}::COLUMNS"};
}
sub _char_iter {
  my $self = shift;
  my @data = ();
  my $fh = $self->open();
  return sub {
    if ($#data == -1) {
      my $line = <$fh>;
      if (defined $line) {
        @data = unpack("C*", $line);
      }
    }
    return shift @data;
  };
}
sub rawRecordIterator {
  my $self = shift;
  if (defined $self->{_rawRecordIterator}) {
    return $self->{_rawRecordIterator};
  }
  my $delm = int($self->{Delimiter}) > 0 ? $self->{Delimiter} : (unpack("C",$self->{Delimiter}))[0];
  my $chrIter = $self->_char_iter();
  my $count = 0;
  my $iter = $self->{_rawRecordIterator} = sub {
    my $mode = MODE_NORMAL;
    my $record = $self->{currentRecord} = [];
    my $buf = [];
    while (defined(my $c = $chrIter->())) {
      if ($mode == MODE_NORMAL) {
        if ($c == $delm) {
          $mode = MODE_IN_QUOTE;
        } elsif ($c == CH_COMMA) {
          push(@$record, pack("C*", @$buf));
          $buf = [];
        } elsif ($c == CH_LF) {
          last;
        } elsif ($c == CH_SPACE or $c == CH_TAB) {
          next;
        } else {
          $mode = MODE_NON_QUOTE;
          push(@$buf, $c);
        }
      } elsif ($mode == MODE_NON_QUOTE) {
        if ($c == CH_COMMA) {
          $mode = MODE_NORMAL;
          push(@$record, pack("C*", @$buf));
          $buf = [];
        } elsif ($c == CH_LF) {
          last;
        } else {
          push(@$buf, $c);
        }
      } else { # $mode == MODE_IN_QUOTE
        if ($c == $delm) {
          $mode = MODE_NORMAL;
        } else {
          push(@$buf, $c);
        }
      }
    }
    push(@$record, pack("C*", @$buf)) if (scalar @$buf > 0);

    if (scalar @$record > 0) {
      $self->{currentRecordCount} = ++$count;
      return $record;
    }
    return undef;
  };
  return $iter;
}
sub process (&) {
  my ($self, $func) = @_;
  croak "Agument 1 must be a subrutine." unless (defined($func) and ref($func) eq 'CODE');
  my $recordIterator = $self->rawRecordIterator();
  my $recordPkg = $self->loadPackage();
  while (defined(my $record = $recordIterator->())) {
    my $retVal = $func->($recordPkg->new(@$record), $self->{currentRecordCount});
    last if (defined($retVal) and $retVal < 0);
  }
  return $self->{currentRecordCount};
}
sub getNext () {
  my $self = shift;
  my $recordPkg = $self->loadPackage();
  my $recordIterator = $self->rawRecordIterator();
  my $rawRecord = $recordIterator->();

  return defined $rawRecord ? $recordPkg->new(@$rawRecord) : undef;
}

1;
__END__

=head1 NAME

Db2::Audit::DelParser - parse the Db2 audit del file

=head1 SYNOPSIS

    use Db2::Audit::DelParser;

    my $csv = new Db2::Audit::DelParser(
      File => '<file>',
      Package => 'Db2::Audit::Checking',
      Delimiter => '"');
    $csv->process(sub {
      my ($record, $count) = @_;
      print join(",", $reocrd->getAll());
    });
    $csv->close();

or

    while (my $record = $csv->getNext()) {
      print join(",", $record->getAll());
    }

=head1 ARGUMENTS

=over 4

=item FH

the file handle

=item File

the target file.

=item Package

the package for each records.

=item Delimiter

the enclosed character, if omitted C<"> is used.

=back

=head1 METHODS

=head2 new

create an instance.

=head2 process C<Subrutine>

starts parsing the file or file-handle,
and call the C<Subrutine> every records.

=head3 arguments:

=over 4

=item 1.
the record instance packaged by specified C<Package>

=item 2.
current record count.

=back

=head2 getNext

starts parsing the file or file-handle,
and returns the next record instance.

=head2 header

returns array of the C<Package> column names

=head2 open

open the file.

=head2 close

close the file-handle.

