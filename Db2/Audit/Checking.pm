package Db2::Audit::Checking;
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
    { name => "Database" },
    { name => "User ID", },
    { name => "Authorization ID" },
    { name => "Origin Node Number",      type => "int" },
    { name => "Coordinator Node Number", type => "int" },
    { name => "Application ID" },
    { name => "Application Name" },
    { name => "Package Schema" },
    { name => "Package Name" },
    { name => "Package Section Number",  type => "int" },
    { name => "Object Schema", },
    { name => "Object Name" },
    { name => "Object Type" },
    { name => "Access Approval Reason" },
    { name => "Access Attempted" },
    { name => "Package Version" },
    { name => "Checked Authorization ID" },
    { name => "Local Transaction ID",    type => "bin" },
    { name => "Global Transaction ID",   type => "bin" },
    { name => "Client User ID" },
    { name => "Client Workstation Name" },
    { name => "Client Application Name" },
    { name => "Client Accounting String" },
    { name => "Trusted Context Name" },
    { name => "Connection Trust Type" },
    { name => "Role Inherited" },
    { name => "Original User ID" },
    { name => "Instance Name" },
    { name => "Hostname" },
    { name => "Access Control Manager",  type => "int" },
  );
  Db2::Audit::RecordBase->init(@COLUMNS);
}
1;
__END__

=head1 NAME

Db2::Audit::Checking - db2 audit record for CHECKING category

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
C<CHECKING>

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

=head2  8: Authorization ID

Authorization ID at time of audit event.

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

=head2 15: Package Section Number

Section number in package being used at the time the audit event occurred.

=head2 16: Object Schema

Schema of the object for which the audit event was generated.

=head2 17: Object Name

Name of object for which the audit event was generated.

=head2 18: Object Type

Type of object for which the audit event was generated.
Possible values include: those shown in the topic titled "Audit record object types".

=head2 19: Access Approval Reason

Indicates the reason why access was approved for this audit event.
Possible values include: those shown in the topic titled "List of possible CHECKING access approval reasons".

=head2 20: Access Attempted

Indicates the type of access that was attempted.
Possible values include: those shown in the topic titled "List of possible CHECKING access attempted types".

=head2 21: Package Version

Version of the package in use at the time that the audit event occurred.

=head2 22: Checked Authorization ID

Authorization ID is checked when it is different than the authorization ID at the time of the audit event.
For example, this can be the target owner in a TRANSFER OWNERSHIP statement.

When the audit event is SWITCH_USER, this field represents the authorization ID that is switched to.

=head2 23: Local Transaction ID

The local transaction ID in use at the time the audit event occurred.
This is the SQLU_TID structure that is part of the transaction logs.

=head2 24: Global Transaction ID

The global transaction ID in use at the time the audit event occurred.
This is the data field in the SQLP_GXID structure that is part of the transaction logs.

=head2 25: Client User ID

The value of the CURRENT CLIENT USERID special register at the time the audit event occurred.

=head2 26: Client Workstation Name

The value of the CURRENT CLIENT_WRKSTNNAME special register at the time the audit event occurred.

=head2 27: Client Application Name

The value of the CURRENT CLIENT_APPLNAME special register at the time the audit event occurred.

=head2 28: Client Accounting String

The value of the CURRENT CLIENT_ACCTNG special register at the time the audit event occurred.

=head2 29: Trusted Context Name

The name of the trusted context associated with the trusted connection.

=head2 30: Connection Trust Type

Possible values are:

=over 4

=item C<''>
- NONE

=item C<'1'>
- IMPLICIT_TRUSTED_CONNECTION

=item C<'2'>
- EXPLICIT_TRUSTED_CONNECTION

=back

=head2 31: Role Inherited

The role inherited through a trusted connection.

=head2 32: Original User ID

The value of the CLIENT_ORIGUSERID global variable at the time the audit event occurred.

=head2 33: Instance Name

The instance name of the event occured.

=head2 34: Hostname

The server's hostname of the event occured.

=head1 SEE ALSO

L<Db2::Audit::RecordBase>

