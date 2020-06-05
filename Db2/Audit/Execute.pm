package Db2::Audit::Execute;
use strict;
use parent qw(Db2::Audit::RecordBase);
our $VERSION = "1.0";
BEGIN {
  our @COLUMNS = (
    { name => "Timestamp",                          type => "timestamp" },
    { name => "Category" },
    { name => "Audit Event" },
    { name => "Event Correlator",                   type => "int" },
    { name => "Event Status",                       type => "int" },
    { name => "Database" },
    { name => "User ID" },
    { name => "Authoriazation ID" },
    { name => "Session Authorization ID" },
    { name => "Origin Node Number",                 type => "int" },
    { name => "Coordinator Node Number",            type => "int" },
    { name => "Application ID" },
    { name => "Application Name" },
    { name => "Client User ID" },
    { name => "Client Accounting String" },
    { name => "Client Workstation Name" },
    { name => "Client Application Name" },
    { name => "Trusted Context Name" },
    { name => "Connection Trust Type" },
    { name => "Role Inherited" },
    { name => "Package Schema" },
    { name => "Package Name" },
    { name => "Package Section" },
    { name => "Package Version" },
    { name => "Local Transaction ID",               type => "bin" },
    { name => "Global Transaction ID",              type => "bin" },
    { name => "UOW ID" },
    { name => "Activity ID" },
    { name => "Statement Invocation ID" },
    { name => "Statement Nesting Level" },
    { name => "Activity Type" },
    { name => "Statement Text" },
    { name => "Statement Isolation Level" },
    { name => "Compilation Environment Description" },
    { name => "Rows Modified",                      type => "int" },
    { name => "Rows Returned",                      type => "int" },
    { name => "Save Point ID",                      type => "int" },
    { name => "Statement Value Index",              type => "int" },
    { name => "Statement Value Type" },
    { name => "Statement Value Data" },
    { name => "Statement Value Extended Indicator", type => "int" },
    { name => "Local Start Time",                   type => "timestamp" },
    { name => "Original User ID" },
    { name => "Instance Name" },
    { name => "Hostname" },
  );
  Db2::Audit::RecordBase->init(@COLUMNS);
}

sub getStatementTextFromLob ($) {
  my ($self, $dir) = @_;
  my $lob = $self->getStatementText();
  if ($lob) {
    return $self->getDataFromLob($lob, $dir);
  }
}
sub getStatementValueDataFromLob ($) {
  my ($self, $dir) = @_;
  my $lob = $self->getStatementValueData();
  if ($lob) {
    return $self->getDataFromLob($lob, $dir);
  }
}

1;
__END__

=head1 NAME

Db2::Audit::Execute - db2 audit record for EXECUTE category

=head1 METHODS

=head2 C<get{ColumnName}>

Returns the value of the column name.
The metod name is used C<get> prefix and the column name removed white spaces.
See COLUMNS section for all column names.

example:
    $record->getTimestamp,
    $record->getAuditEvent

=head1 COLUMNS

=head2  1: Timestamp

Date and time of the audit event.

=head2  2: Category

Category of audit event. Possible values are:
C<EXECUTE>

=head2  3: Audit Event

Specific Audit Event.
For a list of possible values, refer to the section for the CHECKING category in Audit events.

=head2  4: Event Correlator

Correlation identifier for the operation being audited.
Can be used to identify what audit records are associated with a single event.

=head2  5: Event Status

Status of audit event, represented by an SQLCODE where
 Successful event > = 0
 Failed event  < 0

=head2  6: Database

Name of the database for which the event was generated. Blank if this was an instance level audit event.

=head2  7: User ID

User ID at time of audit event.
When the audit event is SWITCH_USER, this field
represents the user ID that is switched to.

=head2  8: Authorization ID

Authorization ID at time of audit event.
When the audit event is SWITCH_USER, this field
represents the authorization ID that is switched to.

=head2  9: Session Authorization ID

The Session Authorization ID at the time of the audit event.

=head2 10: Origin Node Number

Member number at which the audit event occurred.

=head2 11: Coordinator Node Number

Member number of the coordinator member

=head2 12: Application ID

Application ID in use at the time the audit event occurred.

=head2 13: Application Name

Application name in use at the time the audit event occurred.

=head2 14: Client User ID

The value of the CURRENT CLIENT USERID special register at the time the audit event occurred

=head2 15: Client Accounting String

The value of the CURRENT CLIENT_ACCTNG special register at the time the audit event occurred

=head2 16: Client Workstation Name

The value of the CURRENT CLIENT_WRKSTNNAME special register at the time the audit event occurred

=head2 17: Client Application Name

The value of the CURRENT CLIENT_APPLNAME special register at the time the audit event occurred

=head2 18: Trusted Context Name

The name of the trusted context associated with the trusted connection.

=head2 19: Connection Trust type

Possible values are:

=over 4

=item C<''>
- NONE

=item C<'1'>
- IMPLICIT_TRUSTED_CONNECTION

=item C<'2'>
- EXPLICIT_TRUSTED_CONNECTION

=back

=head2 20: Role Inherited

The role inherited through a trusted connection.

=head2 21: Package Schema

Schema of the package in use at the time of the audit event.

=head2 22: Package Name

Name of package in use at the time the audit event occurred.

=head2 23: Package Section

Section number in package being used at the time the audit event occurred.

=head2 24: Package Version

Version of the package in use at the time the audit event occurred.

=head2 25: Local Transaction ID

The local transaction ID in use at the time the audit event occurred.
This is the SQLU_TID structure that is part of the transaction logs.

=head2 26: Global Transaction ID

The global transaction ID in use at the time the audit event occurred.
This is the data field in the SQLP_GXID structure that is part of the transaction logs

=head2 27: UOW ID

The unit of work identifier in which an activity originates.
This value is unique within an application ID for each unit of work.

=head2 28: Activity ID

The unique activity ID within the unit of work.

=head2 29: Statement Invocation ID

An identifier that distinguishes one invocation of a routine from others at the same nesting level within a unit of work.
It is unique within a unit of work for a specific nesting level.

=head2 30: Statement Nesting Level

The level of nesting or recursion in effect when the statement was being run;
each level of nesting corresponds to nested or recursive invocation of a stored procedure or user-defined function (UDF).

=head2 31: Activity Type

The type of activity.
Possible values are:

=over 4

=item *
C<READ_DML>

=item *
C<WRITE_DML>

=item *
C<DDL>

=item *
C<CALL>

=item *
C<OTHER>

=back

=head2 32: Statement Text

Text of the SQL or XQuery statement, if applicable.

=head2 33: Statement Isolation Level

The isolation value in effect for the statement while it was being run.
Possible values are: 

=over 4

=item *
C<NONE> - no isolation specified

=item *
C<UR> - uncommitted read

=item *
C<CS> - cursor stability

=item *
C<RS> - read stability

=item *
C<RR> - repeatable read

=back

=head2 34: Compilation Environment Description

The compilation environment used when compiling the SQL statement.
You can provide this element as input to the COMPILATION_ENV table function, or to the SET COMPILATION ENVIRONMENT SQL statement

=head2 35: Rows Modified

Contains the total number of rows deleted, inserted, or updated as a result of both:

=over 4

=item *
The enforcement of constraints after a successful delete operation

=item *
The processing of triggered SQL statements from activated inlined triggers

=back

If compound SQL is invoked, contains an accumulation of the number of such rows for all sub-statements.
In some cases, when an error is encountered, this field contains a negative value that is an internal error pointer.
This value is equivalent to the L<sqlerrd(5)> field of the SQLCA.

=head2 36: Rows Returned

Contains the total number of rows returned by the statement.

=head2 37: Savepoint ID

The Savepoint ID in effect for the statement while it is being run.
If the Audit Event is SAVEPOINT, RELEASE_SAVEPOINT or ROLLBACK_SAVEPOINT, 
then the Savepoint ID is the save point that is being set, released, or rolled back to.

=head2 38: Statement Value Index

The position of the input parameter marker or host variable used in the SQL statement.

=head2 39: Statement Value Type

A string representation of the type of a data value associated with the SQL statement.
INTEGER or CHAR are examples of possible values.

=head2 40: Statement Value Data

A string representation of a data value to the SQL statement.
LOB, LONG, XML, and structured type parameters are not present.
Date, time, and timestamp fields are recorded in ISO format.

=head2 41: Statement Value Extended Indicator

The value of the extended indicator specified for this statement value.
The possible values are:

=over 4

=item *
C<0> - if the statement value was specified as assigned by the indicator value,

=item *
C<-1> - if NULL was specified by the indicator value,

=item *
C<-5> - if DEFAULT was specified by the indicator value,

=item *
C<-7> - if UNASSIGNED was specified by the indicator value.

=back

=head2 42: Local Start Time

The time that this activity began working on the partition.
This field can be an empty string when the activity does not require a package, that is, for CONNECT, CONNECT RESET, COMMIT, and ROLLBACK, as an example.
The value is logged in local time.

=head2 43: Original User ID

The value of the CLIENT_ORIGUSERID global variable at the time the audit event occurred.

=head2 44: Instance Name

The instance name of the event occured.

=head2 45: Hostname

The server's hostname of the event occured.

=head1 SEE ALSO

L<Db2::Audit::RecordBase>

