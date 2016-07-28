#!/usr/bin/perl -w

BEGIN {push @INC, './Image-ExifTool-10.24/lib/'}

use strict;
use warnings;
use File::Find;
use File::Copy;
use File::Path;
use Image::ExifTool ':Public';


# Parse CR2 and JPG Exif data and send to be renamed 
sub ParseInfo{
   my $file = shift or die "Please specify file";
   my $extension = shift or die "Please specify extension";
   my $directory = shift or die "Please specify directory";
   my $date = "";
   my $id = "";

   my $info = ImageInfo($file);
   foreach (keys %$info) {
      #print "$_ : $info->{$_}\n";
      if ($_ eq "FileNumber") {
         $id = $info->{$_};
      }
      if ($_ eq "DateTimeOriginal") {
         $date = $info->{$_};
      }
   }
   if (defined $id && defined $date) {
     RenameFile($directory, $file, $extension, $date, $id);
   }
}

# Move and rename file:
sub RenameFile{
   my $directory = shift or die "No directory specified.";
   my $filename = shift or die "No filename specified.";
   my $fileext = shift or die "No extension specified.";
   my $filedate = shift or die "No date specified.";
   my $fileid = shift or die "No id specified.";

   my $year = substr $filedate, 0, 4;
   my $month = substr $filedate, 5, 2;
   my $day = substr $filedate, 8, 2;
   my ($id) = $fileid =~ /\-([^-]+)$/;

   my $newpath = "$directory$year/$month/$day/";
   my $newfile = "$directory$year/$month/$day/IMG_$id" . $fileext;
   
   mkpath($newpath);
   copy($filename,$newfile) or die "Failed: $filename copy to $newfile: $!";

   print "===================\n";
   print "$filename";
   print " copied to: ";
   print "$newfile\n";
}

# This requires the inupt of a directory.
# @TODO: Parse the directory and add trailing slash, prn
my $directory = shift or die "Please specify directory";
my @files;

# Search for all files
# @TODO: Search only for CR2 files here, rather than excluding later.
find( 
   sub { push @files, $File::Find::name unless -d; }, 
   $directory
);

# Loop through the found files and send them to be parsed.
for my $file (@files) {
   my ($ext) = $file =~ /(\.[^.]+)$/;
   if (defined $ext && ($ext eq ".cr2" || $ext eq ".jpg")) {
      ParseInfo($file, $ext, $directory);
   }
}

