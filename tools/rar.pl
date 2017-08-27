#/usr/bin/perl

use warnings;
use strict;
use Term::ReadKey;
use Term::ANSIColor qw(:constants);
 
# $Term::ANSIColor::AUTORESET = 1;
$|++; # don't buffer

open my $tty, '<', '/dev/stdin';


my $line = "";
my $ignore = 0;
my $progress = 0;

while (! eof($tty))
{
  my $char = ReadKey 0, $tty;
  if ($char =~ m/\x08|\n/)
  {
    if ($line =~ m/^Calculating the control sum/)
    {
      # ignore that progress
      $ignore = 1;
    }
    elsif ($line =~ m/^Creating archive/)
    {
      $ignore = 0;
    }
    elsif ($line =~ m/\s+(\d+)%$/ && (! $ignore))
    {
      my $progress = $1;
      print BOLD.BLUE."[$ARGV[0]]".RESET.BOLD;
      print " $ARGV[1]".RESET.BLUE.BOLD;
      #print " $ARGV[2]" if (defined($ARGV[2]));
      printf " %3d %%\r", $progress;
      print RESET;
    }
    $line = "";
  }
  else
  {
    $line = $line . $char 
  }
}

$progress = 100;
print BOLD.GREEN."[$ARGV[0]]".RESET.BOLD." $ARGV[1] ".GREEN.BOLD;
#print "$ARGV[2] " if (defined($ARGV[2]));
printf "%3d %%\r", $progress;
print RESET;