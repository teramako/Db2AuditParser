package Db2::Audit::Secmaint;
use strict;
use parent qw(Db2::Audit::RecordBase);
our $VERSION = "1.0";
BEGIN {
  our @COLUMNS = (
    { name => "Timestamp",                           type => "timestamp" },
    { name => "Category" },
    { name => "Audit Event" },
    { name => "Event Correlator",                    type => "int" },
    { name => "Event Status",                        type => "int" },
    { name => "Database" },
    { name => "User ID" },
    { name => "Authorization ID" },
    { name => "Origin Node Number",                  type => "int" },
    { name => "Coordinator Node Number",             type => "int" },
    { name => "Application ID" },
    { name => "Application Name" },
    { name => "Package Schema" },
    { name => "Package Name" },
    { name => "Package Section Number",              type => "int" },
    { name => "Object Schema" },
    { name => "Object Name" },
    { name => "Object Type" },
    { name => "Grantor" },
    { name => "Grantee" },
    { name => "Grantee Type" },
    { name => "Privilege" },
    { name => "Package Version" },
    { name => "Access Type" },
    { name => "Assumable Authid" },
    { name => "Local Transaction ID",                type => "bin" },
    { name => "Global Transaction ID",               type => "bin" },
    { name => "Grantor Type" },
    { name => "Client User ID" },
    { name => "Client Workstation Name" },
    { name => "Client Application Name" },
    { name => "Client Accounting String" },
    { name => "Trusted Context User" },
    { name => "Trusted Context User Authentication", type => "int" },
    { name => "Trusted Context Name" },
    { name => "Connection Trust Type" },
    { name => "Role Inherited" },
    { name => "Associated Object Name" },
    { name => "Associated Object Schema" },
    { name => "Associated Object Type" },
    { name => "Associated Subobject Type" },
    { name => "Associated Subobject Name" },
    { name => "Alter Action" },
    { name => "Secured" },
    { name => "State" },
    { name => "Access Control" },
    { name => "Original User ID" },
    { name => "Instance Name" },
    { name => "Hostname" },
  );
  Db2::Audit::RecordBase->init(@COLUMNS);
}

1;
__END__

=head1 NAME

Db2::Audit::Secmaint - db2 audit record for SECMAINT category

=head1 COLUMNS

=head2  1: Timestamp

Date and time of the audit event.

=head2  2: Category

Category of audit event. Possible values are:
C<SECMAINT>

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

Member number of the coordinator member.

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

If the object type field is ACCESS_RULE then this field contains the security policy name associated with the rule.
The name of the rule is stored in the field Object Name.

If the object type field is SECURITY_LABEL, then this field contains the name of the security policy that the security label is part of.
The name of the security label is stored in the field Object Name.

=head2 17: Object Name

Name of object for which the audit event was generated.
Represents a role name when the audit event is any of: 

=over 4

=item *
C<ADD_DEFAULT_ROLE>

=item *
C<DROP_DEFAULT_ROLE>

=item *
C<ALTER_DEFAULT_ROLE>

=item *
C<ADD_USER>

=item *
C<DROP_USER>

=item *
C<ALTER_USER_ADD_ROLE>

=item *
C<ALTER_USER_DROP_ROLE>

=item *
C<ALTER_USER_AUTHENTICATION>

=back

If the object type field is ACCESS_RULE then this field contains the name of the rule.
The security policy name associated with the rule is stored in the field Object Schema.

If the object type field is SECURITY_LABEL, then this field contains the name of the security label.
The name of the security policy that it is part of is stored in the field Object Schema.

=head2 18: Object Type

Type of object for which the audit event was generated.
Possible values include: those shown in the topic titled "Audit record object types".
The value is ROLE when the audit event is any of: 

=over 4

=item *
C<ADD_DEFAULT_ROLE>

=item *
C<DROP_DEFAULT_ROLE>

=item *
C<ALTER_DEFAULT_ROLE>

=item *
C<ADD_USER>

=item *
C<DROP_USER>

=item *
C<ALTER_USER_ADD_ROLE>

=item *
C<ALTER_USER_DROP_ROLE>

=item *
C<ALTER_USER_AUTHENTICATION>

=back

=head2 19: Grantor

The ID of the grantor or the revoker of the privilege or authority.

=head2 20: Grantee

Grantee ID for which a privilege or authority was granted or revoked.
Represents a trusted context object when the audit event is any of:

=over 4

=item *
C<ADD_DEFAULT_ROLE>

=item *
C<DROP_DEFAULT_ROLE>

=item *
C<ALTER_DEFAULT_ROLE>

=item *
C<ADD_USER>

=item *
C<DROP_USER>

=item *
C<ALTER_USER_ADD_ROLE>

=item *
C<ALTER_USER_DROP_ROLE>

=item *
C<ALTER_USER_AUTHENTICATION>

=back

=head2 21: Grantee Type

Type of the grantee that was granted to or revoked from.
Possible values include: USER, GROUP, ROLE, AMBIGUOUS, or is TRUSTED_CONTEXT when the audit event is any of: 

=over 4

=item *
C<ADD_DEFAULT_ROLE>

=item *
C<DROP_DEFAULT_ROLE>

=item *
C<ALTER_DEFAULT_ROLE>

=item *
C<ADD_USER>

=item *
C<DROP_USER>

=item *
C<ALTER_USER_ADD_ROLE>

=item *
C<ALTER_USER_DROP_ROLE>

=item *
C<ALTER_USER_AUTHENTICATION>

=back

=head2 22: Privilege

Indicates the type of privilege or authority granted or revoked.
Possible values include: those shown in the topic titled "List of possible SECMAINT privileges or authorities".
The value is ROLE MEMBERSHIP when the audit event is any of the following:

=over 4

=item *
C<ADD_DEFAULT_ROLE>

=item *
C<DROP_DEFAULT_ROLE>

=item *
C<ALTER_DEFAULT_ROLE>

=item *
C<ADD_USER>

=item *
C<DROP_USER>

=item *
C<ALTER_USER_ADD_ROLE>

=item *
C<ALTER_USER_DROP_ROLE>

=item *
C<ALTER_USER_AUTHENTICATION>

=back

=head2 23: Package Version

Version of the package in use at the time the audit event occurred.

=head2 24: Access Type

The access type for which a security label is granted.
Possible values: 

=over 4

=item *
C<READ>

=item *
C<WRITE>

=item *
C<ALL>

=back

The access type for which a security policy is altered.
Possible values:

=over 4

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

=back

=head2 25: Assumable Authid

When the privilege granted is a SETSESSIONUSER privilege this is the authorization ID that the grantee is allowed to set as the session user.

=head2 26: Local Transaction ID

The local transaction ID in use at the time the audit event occurred.
This is the SQLU_TID structure that is part of the transaction logs.

=head2 27: Global Transaction ID

The global transaction ID in use at the time the audit event occurred.
This is the data field in the SQLP_GXID structure that is part of the transaction logs.

=head2 28: Grantor Type

Type of the grantor. Possible values include: USER.

=head2 29: Client User ID

The value of the CURRENT CLIENT USERID special register at the time the audit event occurred.

=head2 30: Client Workstation Name

The value of the CURRENT CLIENT_WRKSTNNAME special register at the time the audit event occurred.

=head2 31: Client Application Name

The value of the CURRENT CLIENT_APPLNAME special register at the time the audit event occurred.

=head2 32: Client Accounting String

The value of the CURRENT CLIENT_ACCTNG special register at the time the audit event occurred.

=head2 33: Trusted Context User

Identifies a trusted context user when the audit event is ADD_USER or DROP_USER.

=head2 34: Trusted Context User Authentication

Specifies the authentication setting for a trusted context user when the audit event is ADD_USER, DROP_USER or ALTER_USER_AUTHENTICATION

=over 4

=item *
C<1> : Authentication is required

=item *
C<0> : Authentication is not required 

=back

=head2 35: Trusted Context Name

The name of the trusted context associated with the trusted connection.

=head2 36: Connection Trust Type

Possible values are:

=over 4

=item C<''>
- NONE

=item C<'1'>
- IMPLICIT_TRUSTED_CONNECTION

=item C<'2'>
- EXPLICIT_TRUSTED_CONNECTION

=back

=head2 37: Role Inherited

The role inherited through a trusted connection.

=head2 38: Associated Object Name

Name of the object for which an association exists.
The meaning of the association depends on the Object Type for the event.
If the Object Type is PERMISSION or MASK, then the Associated Object is the table on which that permission or mask has been created.

=head2 39: Associated Object Schema

Name of the object schema for which an association exists.
The meaning of the association depends on the Object Type of the event.

=head2 40: Associated Object Type

The type of the object for which an association exists.
The meaning of the association depends on the Object Type of the event.

=head2 41: Associated Subobject Type

The type of the subobject for which an association exists.
The meaning of the association depends on the Object Type of the event.
If the Object Type is MASK and the Associated Object type is TABLE,
then the associated subobject is the column of the table on which the mask has been created.

=head2 42: Associated Subobject Name

Name of the subobject for which an association exists.
The meaning of the association depends on the Object Type of the event.

=head2 43: Alter Action

Specific Alter Action.
Possible values include:

=over 4

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

=head2 44: Secured

Specifies if the object is a secure object.

=head2 45: State

Specifies the state of the object. The state depends on the Object Type.
Possible values include: C<ENABLED> or C<DISABLED>

=head2 46: Access Control

Specifies what access control type the object is protected with.
Possible values include:

=over 4

=item *
C<ROW> - Row access control has been activated for the object

=item *
C<COLUMN> - Column access control has been activated for the object

=item *
C<ROW_COLUMN> - Row and column access have been activated for the object

=back

=head2 47: Original User ID

The value of the CLIENT_ORIGUSERID global variable at the time the audit event occurred.

=head2 48: Instance Name

The instance name of the event occured.

=head2 49: Hostname

The server's hostname of the event occured.

=head1 SEE ALSO

L<Db2::Audit::RecordBase>

