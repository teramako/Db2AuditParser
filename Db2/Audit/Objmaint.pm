package Db2::Audit::Objmaint;
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
    { name => "User ID" },
    { name => "Authorization ID" },
    { name => "Origin Node Number",      type => "int" },
    { name => "Coordinator Node Number", type => "int" },
    { name => "Application ID" },
    { name => "Application Name" },
    { name => "Package Schema" },
    { name => "Package Name" },
    { name => "Package Section Number",  type => "int" },
    { name => "Object Schema" },
    { name => "Object Name" },
    { name => "Object Type" },
    { name => "Package Version" },
    { name => "Security Policy Name" },
    { name => "Alter Action" },
    { name => "Protected Column Name" },
    { name => "Column Security Label" },
    { name => "Security Label Column Name" },
    { name => "Local Transaction ID",    type => "bin" },
    { name => "Global Transaction ID",   type => "bin" },
    { name => "Client User ID" },
    { name => "Client Workstation Name" },
    { name => "Client Application Name" },
    { name => "Client Accounting String" },
    { name => "Trusted Context Name" },
    { name => "Connection Trust Type" },
    { name => "Role Inherited" },
    { name => "Object Module" },
    { name => "Associated Object Name" },
    { name => "Associated Object Schema" },
    { name => "Associated Object Type" },
    { name => "Associated Subobject Type" },
    { name => "Associated Subobject Name" },
    { name => "Secured" },
    { name => "State" },
    { name => "Acces Control" },
    { name => "Original User ID" },
    { name => "Instance Name" },
    { name => "Hostname" },
  );
  Db2::Audit::RecordBase->init(@COLUMNS);
}

1;
__END__

=head1 NAME

Db2::Audit::Objmaint - db2 audit record for OBJMAINT category

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

=head2 19: Package Version

Version of the package in use at the time that the audit event occurred.

=head2 20: Security Policy Name

The name of the security policy if the object type is TABLE and that table is associated with a security policy.

=head2 21: Alter Action

Specific Alter operation
Possible values include: 

=over 4

=item *
ADD_PROTECTED_COLUMN>

=item *
C<ADD_COLUMN_PROTECTION>

=item *
C<DROP_COLUMN_PROTECTION>

=item *
C<ADD_ROW_PROTECTION>

=item *
C<ADD_SECURITY_POLICY>

=item *
C<ADD_ELEMENT>

=item *
C<ADD COMPONENT>

=item *
C<USE GROUP AUTHORIZATIONS>

=item *
C<IGNORE GROUP AUTHORIZATIONS>

=item *
C<USE ROLE AUTHORIZATIONS>

=item *
C<IGNORE ROLE AUTHORIZATIONS>

=item *
C<OVERRIDE NOT AUTHORIZED WRITE SECURITY LABEL>

=item *
C<RESTRICT NOT AUTHORIZED WRITE SECURITY LABEL>

=item *
C<SECURE>

=item *
C<UNSECURE>

=item *
C<ENABLE>

=item *
C<DISABLE>

=item *
C<ACTIVATE_ROW_ACCESS_CONTROL>

=item *
C<ACTIVATE_COLUMN_ACCESS_CONTROL>

=item *
C<ACTIVATE_ROW_COLUMN_ACCESS_CONTROL>

=back

=head2 22: Protected Column Name

If the Alter Action is C<ADD_COLUMN_PROTECTION> or C<DROP_COLUMN_PROTECTION> this is the name of the affected column.

=head2 23: Column Security Label

The security label protecting the column specified in the field Column Name.

=head2 24: Security Label Column Name

Name of the column containing the security label protecting the row.

=head2 25: Local Transaction ID

The local transaction ID in use at the time the audit event occurred.
This is the SQLU_TID structure that is part of the transaction logs.

=head2 26: Global Transaction ID

The global transaction ID in use at the time the audit event occurred.
This is the data field in the SQLP_GXID structure that is part of the transaction logs.

=head2 27: Client User ID

The value of the CURRENT CLIENT USERID special register at the time the audit event occurred.

=head2 28: Client Workstation Name

The value of the CURRENT CLIENT_WRKSTNNAME special register at the time the audit event occurred.

=head2 29: Client Application Name

The value of the CURRENT CLIENT_APPLNAME special register at the time the audit event occurred.

=head2 30: Client Accounting String

The value of the CURRENT CLIENT_ACCTNG special register at the time the audit event occurred.

=head2 31: Trusted Context Name

The name of the trusted context associated with the trusted connection.

=head2 32: Connection Trust Type

Possible values are:

=over 4

=item C<''>
- NONE

=item C<'1'>
- IMPLICIT_TRUSTED_CONNECTION

=item C<'2'>
- EXPLICIT_TRUSTED_CONNECTION

=back

=head2 33: Role Inherited

The role inherited through a trusted connection.

=head2 34: Object Module

Name of module to which the object belongs.

=head2 35: Associated Object Name

Name of the object for which an association exists.
The meaning of the association depends on the Object Type for the event.
If the Object Type is PERMISSION or MASK, then the associated object is the table on which the permission or mask has been created.

=head2 36: Associated Object Schema

Name of the object schema for which an association exists.
The meaning of the association depends on the Object Type for the event.

=head2 37: Associated Object Type

The type of the object for which an association exists.
The meaning of the association depends on the Object Type for the event.

=head2 38: Associated Subobject Type

The type of the subobject for which an association exists.
The meaning of the association depends on the Object Type for the event.
If the Object Type is MASK and the associated object type is TABLE,
then the associated subobject is the column of the table on which the mask has been created.

=head2 39: Associated Subobject Name

Name of the subobject for which an association exists.
The meaning of the association depends on the Object Type for the event.

=head2 40: Secured

Specifies if the object is a secured object.

=head2 41: State

The state of the object. The state depends on the Object Type.
Possible values include:

=over 4

=item *
C<ENABLED>

=item *
C<DISABLED>

=back

=head2 42: Access Control

Specifies what access control the object is protected with.
Possible values include:

=item C<ROW>
- Row access control has been activated on the object

=item C<COLUMN>
- Column access control has been activated on the object

=item C<ROW_COLUMN>
- Row and column access control has been activated on the object

=back

=head2 43: Original User ID

The value of the CLIENT_ORIGUSERID global variable at the time the audit event occurred.

=head2 44: Instance Name

The instance name of the event occured.

=head2 45: Hostname

The server's hostname of the event occured.

=head1 SEE ALSO

L<Db2::Audit::RecordBase>

