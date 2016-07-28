== Rename recovered Canon raw files ==

After recovering a lot of Canon raw files using testdisk, all the files 
had the wrong filenames, making it difficult to re-associate with the
Lightroom catalogue.

To solve the problem, I made use of the [Perl Exif tool by Phil Harvey][1]:

=== To install: ===

1. git clone https://github.com/listedegarde/renamed-recovered-canon-raw.git
2. cd renamed-recovered-cannon-raw.git
3. wget http://www.sno.phy.queensu.ca/~phil/exiftool/Image-ExifTool-10.24.tar.gz
4. tar -zxvf Image-ExifTool-10.24.tar.gz
5. rm Image-ExifTool-10.24.tar.gz

=== To run: ===

Where ~/Recovered/ is the directory of the recovered files.  
DO NOT forget to include the trailing slash!
perl run.pl ~/Recovered/


Note that this will automatically copy and sort CR2 files into folders by year,
month, and day.  Example: ~/Recovered/2016/07/27/IMG_2555.CR2


[1]: http://www.sno.phy.queensu.ca/~phil/exiftool/
