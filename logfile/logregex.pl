#!C:/Strawberry/perl/bin/perl.exe

use DBI;
print "Content-type:text-html\n\n";
    $dbh = DBI->connect("DBI:mysql:database=your name database","root","");
$LOGFILE = "your log file";
open(LOGFILE) or die("Could not open log file.");
foreach $line (<LOGFILE>) {
    $w = "(.+?)";
    $line =~ m/^$w $w $w \[$w:$w $w\] "$w $w $w" $w $w $w $w$/;

    $variable1     = $1;
    $variable2     = $2;
    $variable3     = $3;
    $variable4     = $4;
    $variable5     = $5;
    $variable6     = $6;
    $variable7     = $7;
    $variable8     = $8;
    $variable9     = $9;
    $variable10    = $10;
    $variable11    = $11;
    $variable12    = $12;
    $variable13    = $13;
    
    $sql = "INSERT INTO log (log,ip,date,time,gmt,req,file,proto,status, c1,c2,c3) VALUES ('$variable1', '$variable2', '$variable4','$variable5', '$variable6', '$variable7', '$variable8', '$variable9', '$variable10', '$variable11', '$variable12', '$variable13');";
    $sth = $dbh->prepare($sql);
    $sth->execute();

    # do line-by-line processing.

close(LOGFILE);

$sql = "SELECT COUNT(*) FROM your name table database";
$sth = $dbh->prepare($sql);
$sth->execute();
$count  = $sth->fetchrow_array;

print "JUMLAH ROW = $count";
