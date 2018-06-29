#!C:/Strawberry/perl/bin/perl.exe

use DBI;
print "Content-type:text-html\n\n";
    $dbh = DBI->connect("DBI:mysql:database=access_log","root","");
$LOGFILE = "log2";
open(LOGFILE) or die("Could not open log file.");
foreach $line (<LOGFILE>) {
    $w = "(.+?)";
    $line =~ m/^$w $w $w \[$w:$w $w\] "$w $w $w" $w $w $w $w$/;


    $RANDOM        = $1;
    $IP            = $2;
    $MENE          = $3;
    $DATE          = $4;
    $TIME          = $5;
    $GMT           = $6;
    $REQ           = $7;
    $URL           = $8;
    $PROTOCOL      = $9;
    $STATUS        = $10;
    $gatau1        = $11;
    $gatau2        = $12;
    $gatau3        = $13;

    $sql = "INSERT INTO log (log,ip,date,time,gmt,req,file,proto,status, c1,c2,c3) VALUES ('$RANDOM', '$IP', '$DATE','$TIME', '$GMT', '$REQ', '$URL', '$PROTOCOL', '$STATUS', '$gatau1', '$gatau2', '$gatau3');";
    $sth = $dbh->prepare($sql);
    $sth->execute();

    # do line-by-line processing.
}
print "
<!DOCTYPE html>
<html>
  <head>
    <meta charset='utf-8'>
    <title>Learn perl</title>
  </head>
  <body>
  <table border='1'>
    <thead>
      <tr>
        <td>log</td>
        <td>ip</td>
        <td>date</td>
        <td>time</td>
        <td>gmt</td>
        <td>req</td>
        <td>file</td>
        <td>proto</td>
        <td>status</td>
        <td>c1</td>
        <td>c2</td>
        <td>c3</td>
      </tr>
    </thead>
    <tbody>
  ";
my $sql = "SELECT * FROM log";
my $sth = $dbh->prepare($sql);
$sth->execute();
while (my @row = $sth->fetchrow_array()) {
  my ($log, $ip, $date, $time, $gmt, $req, $file, $proto, $status, $c1, $c2, $c3) = @row;
print "
  <tr>
          <td>$log</td>
          <td>$ip</td>
          <td>$date</td>
          <td>$time</td>
          <td>$gmt</td>
          <td>$req</td>
          <td>$file</td>
          <td>$proto</td>
          <td>$status</td>
          <td>$c1</td>
          <td>$c2</td>
          <td>$c3</td>
        </tr>
        ";
}

close(LOGFILE);

$sql = "SELECT COUNT(*) FROM log";
$sth = $dbh->prepare($sql);
$sth->execute();
$count  = $sth->fetchrow_array;

print "JUMLAH ROW = $count";
