package Db2::Audit::RecordBase;
use strict;
use Carp;
use Db2::Date;

our @COLUMNS = ();

sub init {
  my $class = shift;
  my $caller = caller;
  my $index = 0;
  no strict 'refs';
  for (@_) {
    {
      my ($col, $i) = ($_, $index);
      my $name = "${caller}::get$col->{name}";
      $name =~ s/\s*//g;
      *{$name} = sub  {
        my ($self, $wrapChar) = @_;
        return _format($self->[$i], $col, $wrapChar);
      };
    }
    $index++;
  }
}
sub _COLUMNS () {
  my $ref = ref shift;
  no strict 'refs';
  return \@{"${ref}::COLUMNS"};
}
sub _format ($$;$) {
  my ($val, $col, $wrapChar) = @_;
  return "" if ($val eq "");
  if (defined $col->{format}) {
    $val = $col->{format}->($val);
  }
  if (defined $col->{type}) {
    if ($col->{type} eq "int") {
      return int($val);
    } elsif ($col->{type} eq "hex") {
      return hex($val);
    } elsif ($col->{type} eq "bin") {
      return sprintf("x{%s}", join("", map { sprintf("%02x",$_) } unpack("C*", $val)));
    } elsif ($col->{type} eq "timestamp") {
      $val = db2strftime(db2parsedate($val));
    }
  }
  return $wrapChar ? $wrapChar.$val.$wrapChar : $val;
}
sub new {
  my $class = shift;
  my @list = @_;
  return bless \@list, $class;
}
sub header {
  my $self = shift;
  return map { $_->{name} } \@{$self->_COLUMNS};
}
sub length () {
  my $self = shift;
  return scalar @$self;
}
sub get ($;$) {
  my ($self, $num, $wrapChar) = @_;
  my $val = $self->[$num];
  carp "Index: $num: Value is undefined." unless (defined $val);
  my $col = $self->_COLUMNS()->[$num];
  carp "Index: $num: Column definition is undefined." unless (defined $col);
  return $col ? _format($val, $col, $wrapChar) : $val;
}
sub getAll () {
  my $self = shift;
  my $wrapChar = shift;
  my @indexes = @_;
  my $cols = $self->_COLUMNS;
  my @values = ();
  if (scalar @indexes == 0) {
    @indexes = (0 ... (scalar @$self -1));
  }
  foreach my $i (@indexes) {
    push(@values, $self->get($i, $wrapChar));
  }
  return @values;
}

1;

__END__

=head1 NAME

Db2::Audit::RecordBase - the base class for db2 audit record

=head1 DESCRIPTION

This module provides the base clas for Db2 audit record.
Audit record for each category will be based on this module.
So, this module will not be used directory by users.
But all methods of each records are provied this class.

Category:

=over 2

=item *

Audit - Db2::Audit::Audit

=item *

Checking - Db2::Audit::Checking

=item *

Objmaint - Db2::Audit::Objmaint

=item *

Secmaint - Db2::Audit::Secmaint

=item *

Sysadmin - Db2::Audit:Sysasmin

=item *

Validate - Db2::Audit::Validate

=item *

Context - Db2::Audit::Context

=item *

Execute - Db2::Audit::Execute

=back

=head1 METHODS

=head2 new C<ARRAY>

create an instance

=head2 header

returns Array of the COLUMN names

=head2 length

return length of the array

=head2 get C<index>

returns the B<formated> value at the specified C<index>

=head2 getAll

returns array of all B<formated> values.

=head1 SEE ALSO

=over 2

=item *
L<Db2::Audit::DelParser>

=item *
L<Db2::Audit::Audit>

=item *
L<Db2::Audit::Checking>

=item *
L<Db2::Audit::Objmaint>

=item *
L<Db2::Audit::Secmaint>

=item *
L<Db2::Audit::Sysadmin>

=item *
L<Db2::Audit::Validate>

=item *
L<Db2::Audit::Context>

=item *
L<Db2::Audit::Execute>

=back

