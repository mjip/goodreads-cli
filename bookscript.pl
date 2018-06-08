#!/usr/bin/perl

use XML::LibXML;
use HTML::Restrict;
use Term::ANSIColor;
use POSIX;

# install dependencies with cpanm --installdeps from the cpanfile

# for optimal output use a xterm-256color, size 8 Tlwg Typewriter Regular terminal

# gets rid of wide character error printouts
binmode STDOUT, ":encoding(UTF-8)";

my $file = 'books.xml';

my $dom = XML::LibXML->load_xml(location => $file);

# fetches all book data
my @titleblocks = $dom->findnodes('//book/title');
my @titles;
my $i = 0;
foreach my $titlename (@titleblocks){
	$titles[$i] = $titlename->to_literal;
	$i++;
}

my @pageblocks = $dom->findnodes('//book/num_pages');
my @pages;
$i = 0;
foreach my $pagename (@pageblocks){
	$pages[$i] = $pagename->to_literal;
	$i++;
}

my @descblocks = $dom->findnodes('//book/description');
my @descs;
$i = 0;
my $hr = HTML::Restrict->new();
foreach my $descname (@descblocks){
	$descs[$i] = $hr->process($descname->to_literal);
	$i++;
}

#breaks when there are multiple authors, probably
my @authorblocks = $dom->findnodes('//authors/author/name');
my @authors;
$i = 0;
foreach my $authorname (@authorblocks){
	$authors[$i] = $authorname->to_literal;
	$i++;
}

my @yearblocks = $dom->findnodes('//book/published');
my @years;
$i = 0;
foreach my $yearname (@yearblocks){
	$years[$i] = $yearname->to_literal;
	$i++;
}

my @shelves = $dom->findnodes('//shelves/shelf');
my @shelfnames;
$i = 0;
foreach my $shelfname (@shelves){
	$shelfnames[$i] = $shelfname->getAttribute('name');
	$i++;
}

my $count = 0;
my @taken1;
my $ran;
my @filter1 = grep(/currently-reading/, @shelves);
if ((scalar @filter1) eq 0) {
	print color('green');
	print "This user is not currently reading anything. \n\n";	
} elsif ((scalar @filter1) eq 1) {
	print color('green');
	print "Currently reading: \n\n";
	for (my $a = 0; $a < (scalar @titles); $a++ ){
		if ( $shelfnames[$a] eq 'currently-reading'){
			print color('magenta') . "Title: " . color('blue') . $titles[$a] . "\n";
			print color('magenta') . "Author: " . color('blue') . $authors[$a] . "\n";
			if ($years[$a] ne "") {print color('magenta') . "Published: " . color('blue') . $years[$a] . "\n";}
			if ($pages[$a] ne "") {print color('magenta') . "Pages: " . color('blue') . $pages[$a] . "\n";}
			if ($descs[$a] ne "") {print color('magenta') . "Description: " . color('blue') . $descs[$a] . "\n";}
			print "\n";
		}		
	}
} else {
	print color('green');
	print "Currently reading: \n\n";
	while ( $count ne 2 ){
		$ran = floor(rand(scalar @titles)); # generates random numbers from 0 ... len(titles)-1
		if ( $shelfnames[$ran] eq 'currently-reading' && $taken1[0] ne $ran ){
			print color('magenta') . "Title: " . color('blue') . $titles[$ran] . "\n";
			print color('magenta') . "Author: " . color('blue') . $authors[$ran] . "\n";
			if ($years[$ran] ne "") {print color('magenta') . "Published: " . color('blue') . $years[$ran] . "\n";}
			if ($pages[$ran] ne "") {print color('magenta') . "Pages: " . color('blue') . $pages[$ran] . "\n";}
			if ($descs[$ran] ne "") {print color('magenta') . "Description: " . color('blue') . $descs[$ran] . "\n";}
			print "\n";
			$count++;
			$taken1[0] = $ran;
		}
	}
}

$count = 0;
my @taken2;
my @filter2 = grep(/to-read/, @shelves);
if ((scalar @filter2) eq 0) {
	print color('green');
	print "This user is not anticipating reading anything. \n\n";	
} elsif ((scalar @filter2) eq 1) {
	print color('green');
	print "To read: \n\n";
	for (my $a = 0; $a < (scalar @titles); $a++ ){
		if ( $shelfnames[$a] eq 'to-read'){
			print color('magenta') . "Title: " . color('blue') . $titles[$a] . "\n";
			print color('magenta') . "Author: " . color('blue') . $authors[$a] . "\n";
			if ($years[$a] ne "") {print color('magenta') . "Published: " . color('blue') . $years[$a] . "\n";}
			if ($pages[$a] ne "") {print color('magenta') . "Pages: " . color('blue') . $pages[$a] . "\n";}
			if ($descs[$a] ne "") {print color('magenta') . "Description: " . color('blue') . $descs[$a] . "\n";}
			print "\n";
		}		
	}
} else {
	print color('green');
	print "To read: \n\n";
	while ( $count ne 2 ){
		$ran = floor(rand(scalar @titles)); 
		if ( $shelfnames[$ran] eq 'to-read' && $taken2[0] ne $ran ){
			print color('magenta') . "Title: " . color('blue') . $titles[$ran] . "\n";
			print color('magenta') . "Author: " . color('blue') . $authors[$ran] . "\n";
			if ($years[$ran] ne "") {print color('magenta') . "Published: " . color('blue') . $years[$ran] . "\n";}
			if ($pages[$ran] ne "") {print color('magenta') . "Pages: " . color('blue') . $pages[$ran] . "\n";}
			if ($descs[$ran] ne "") {print color('magenta') . "Description: " . color('blue') . $descs[$ran] . "\n";}
			print "\n";
			$count++;
			$taken2[0] = $ran;
		}
	}
}
