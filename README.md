# Db2AuditParser

parse db2 audit files extracted by `db2audit extract delasc`

## example
```perl
use Db2::Audit::DelParser;
use File::Basename qw(dirname basename);

my %PKG_TABLE = (
  'audit.del'    => 'Db2::Audit::Audit',
  'checking.del' => 'Db2::Audit::Checking',
  'objmaint.del' => 'Db2::Audit::Objmaint',
  'secmaint.del' => 'Db2::Audit::Secmaint',
  'sysadmin.del' => 'Db2::Audit::Sysadmin',
  'context.del'  => 'Db2::Audit::Context',
  'execute.del'  => 'Db2::Audit::Execute',
  'validate.del' => 'Db2::Audit::Validate'
);

foreach my $file (@ARGV) {
  my $filename = basename($file);
  my $pkg = $PKG_TABLE{$filename};
  if ($pkg) {
    my $csv = new Db2::Audit::DelParser(File => $file, Package => $pkg);
    # output header
    print join(",", $csv->header);
    $csv->procss(sub {
      my ($record, $count) = @_;
      if ($record->getAuthorizationID() eq "DB2INST1") {
        print join(",", $record->getAll());
      }
    });
    $csv->close();
  }
}
```

## example) get SQL Statement
```perl
my $csv = new Db2::Audit::DelParser(File => "$dir/execute.del", Package => 'Db2::Audit::Execute');
$csv->process(sub {
  my ($rec, $c) = @_;
  my $statement = $rec->getStatementTextFromLob($dir);
  if ($statement) {
    printf("%s %s\n", $rec->getTimestamp(), $statement);
  }
  my $paramValue = $rec->getStatementValueDataFromLob($dir);
  if ($paramValue) {
    printf("Index:%2d Type:%s Value:`%s'\n",
      $rec->getStatementValueIndex(), $rec->getStatementValueType(), $paramValue);
  }
});
```

