package Db2::Audit::Audit;
use strict;
use parent qw(Db2::Audit::RecordBase);
our $VERSION = "1.0";
BEGIN {
  our @COLUMNS = (
    { name => "Timestamp",               type => "timestamp" },
    { name => "Category" },
    { name => "Audit Event" },
    { name => "Event Correlator",        type => "int" },
    { name => "Event Status",            type => "int" },
    { name => "User ID" },
    { name => "Authorization ID" },
    { name => "Database" },
    { name => "Origin Node Number",      type => "int" },
    { name => "Coordinator Node Number", type => "int" },
    { name => "Application ID" },
    { name => "Application Name" },
    { name => "Package Schema" },
    { name => "Package Name" },
    { name => "Package Section",         type => "int" },
    { name => "Package Version" },
    { name => "Local Transaction ID",    type => "bin" },
    { name => "Global Transaction ID",   type => "bin" },
    { name => "Client User ID" },
    { name => "Client Workstation Name" },
    { name => "Client Application Name" },
    { name => "Client Accounting String" },
    { name => "Trusted Context Name" },
    { name => "Connection Trust Type" },
    { name => "Role Inherited" },
    { name => "Policy Name" },
    { name => "Policy Association Object Type" },
    { name => "Policy Association Subobject Type" },
    { name => "Policy Association Object Name" },
    { name => "Policy Association Object Schema" },
    { name => "Audit Status" },
    { name => "Checking Status" },
    { name => "Context Status" },
    { name => "Execute Status" },
    { name => "Execute With Data" },
    { name => "Objmaint Status" },
    { name => "Secmaint Status" },
    { name => "Sysadmin Status" },
    { name => "Validate Status" },
    { name => "Error Type" },
    { name => "Data Path" },
    { name => "Archive Path" },
    { name => "Original User ID" },
    { name => "Instance Name" },
    { name => "Hostname" },
  );
  Db2::Audit::RecordBase->init(@COLUMNS);
}
1;
__END__

=head1 NAME

Db2::Audit::Audit - db2 audit record for AUDIT category

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
C<AUDIT>

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

=head2  6: User ID

User ID at time of audit event.

=head2  7: Authorization ID

Authorization ID at time of audit event.

=head2  8: Database

Name of the database for which the event was generated. Blank if this was an instance level audit event.

=head2  9: Origin Node Number

Member number at which the audit event occurred.

=head2 10: Coordinator Node Number

Member number of the coordinator Member.

=head2 11: Application ID

Application ID in use at the time the audit event occurred.

=head2 12: Application Name

Application name in use at the time the audit event occurred.

=head2 13: Package Schema

Schema of the package in use at the time of the audit event.

=head2 14: Package Name

Name of package in use at the time the audit event occurred.

=head2 15: Package Section

Section number in package being used at the time the audit event occurred.

=head2 16: Package Version

Version of the package in use at the time that the audit event occurred.

=head2 17: Local Transaction ID

The local transaction ID in use at the time the audit event occurred.
This is the SQLU_TID structure that is part of the transaction logs.

=head2 18: Global Transaction ID

The global transaction ID in use at the time the audit event occurred.
This is the data field in the SQLP_GXID structure that is part of the transaction logs.

=head2 19: Client User ID

The value of the CURRENT CLIENT USERID special register at the time the audit event occurred.

=head2 20: Client Workstation Name

The value of the CURRENT CLIENT_WRKSTNNAME special register at the time the audit event occurred.

=head2 21: Client Application Name

The value of the CURRENT CLIENT_APPLNAME special register at the time the audit event occurred.

=head2 22: Client Accounting String

The value of the CURRENT CLIENT_ACCTNG special register at the time the audit event occurred.

=head2 23: Trusted Context Name

The name of the trusted context associated with the trusted connection.

=head2 24: Connection Trust Type

Possible values are:

=over 4

=item C<''>
- NONE

=item C<'1'>
- IMPLICIT_TRUSTED_CONNECTION

=item C<'2'>
- EXPLICIT_TRUSTED_CONNECTION

=back

=head2 25: Role Inherited

The role inherited through a trusted connection.

=head2 26: Policy Name

The audit policy name.

=head2 27: Policy Association Object Type

The type of the object that the audit policy is associated with. Possible values include:

=over 4

=item *
C<N> = Nickname

=item *
C<S> = MQT

=item *
C<T> = Table (untyped)

=item *
C<i> = Authorization ID

=item *
C<g> = Authority

=item *
C<x> = Trusted context

=item *
blank = Database 

=back

=head2 28: Policy Association Subobject Type

The type of sub-object that the audit policy is associated with.
If the Object Type is ? (authorization id), then possible values are:

=over 4

=item *
C<U> = User

=item *
C<G> = Group

=item *
C<R> = Role

=back

=head2 29: Policy Association Object Name

The name of the object that the audit policy is associated with.

=head2 30: Policy Association Object Schema

The schema name of the object that the audit policy is associated with.
This is NULL if the Policy Association Object Type identifies an object to which a schema does not apply.

=head2 31: Audit Status

The status of the AUDIT category in an audit policy.
Possible values are:

=over 4

=item *
C<B> - Both

=item *
C<F> - Failure

=item *
C<N> - None

=item *
C<S> - Success

=back

=head2 32: Checking Status

The status of the CHECKING category in an audit policy.
Possible values are same as C<31: Audit Status>. 

=head2 33: Context Status

The status of the CONTEXT category in an audit policy.
Possible values are same as C<31: Audit Status>. 

=head2 34: Execute Status

The status of the EXECUTE category in an audit policy.
Possible values are same as C<31: Audit Status>. 

=head2 35: Execute With Data

The WITH DATA option of the EXECUTE category in the audit policy.
Possible values are:

=over 4

=item *
C<Y> - WITH DATA

=item *
C<N> - WITHOUT DATA

=back

=head2 36: Objmaint Status

The status of the OBJMAINT category in an audit policy.
Possible values are same as C<31: Audit Status>. 

=head2 37: Secmaint Status

The status of the SECMAINT category in an audit policy.
Possible values are same as C<31: Audit Status>. 

=head2 38: Sysadmin Status

The status of the SYSADMIN category in an audit policy.
Possible values are same as C<31: Audit Status>. 

=head2 39: Validate Status

The status of the VALIDATE category in an audit policy.
Possible values are same as C<31: Audit Status>. 

=head2 40: Error Type

The error type in an audit policy.
Possible values are:

=over 4

=item *
C<AUDIT>

=item *
C<NORMAL>

=back

=head2 41: Data Path

The path to the active audit logs specified on the C<db2audit configure> command.

=head2 42: Archive Path

The path to the archived audit logs specified on the C<db2audit configure> command.

=head2 43: Original User ID

The value of the CLIENT_ORIGUSERID global variable at the time the audit event occurred.

=head2 44: Instance Name

The instance name of the event occured.

=head2 45: Hostname

The server's hostname of the event occured.


=head1 SEE ALSO

L<Db2::Audit::RecordBase>

