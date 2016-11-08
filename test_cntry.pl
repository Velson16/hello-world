#!/usr/bin/perl
use strict;
use warnings;
use carp;

my $inputfile1 = shift;
my $self = {};

#Country Hash - 07 Oct 2016
my %country_dtls = ();

$self->{country_dtls} = \%country_dtls;

open (INFILE,"$inputfile1") || die "Cannot open input file\n\n";

while (<INFILE>)
{	
	my $curr_record = $_;
	my @curr_record_split = split (/ /,$curr_record) ;
	$self->{country_dtls}->{uc($curr_record_split[0])}=$curr_record_split[1];

}

foreach  (keys %country_dtls) {
	my $key_length = length($_);
	print "key_length of $_ is $key_length and country code is $country_dtls{$_} \n";
}

&iso_code("VelsonThomas|EKMHouse|MTY|Kerala|Ind");
#---------------------------------------------------------------------------
# Sub to get ISO code from the Country name which is passed
#---------------------------------------------------------------------------
sub iso_code
{
my $iso_code;
my $Addrs_string = shift;
$Addrs_string = uc($Addrs_string);

my @addr_array = split (/\|/,$Addrs_string);

foreach my $element (reverse @addr_array) 
{
	my $str_len = length($element);
	print "$element element length is $str_len \n";
	foreach  (keys %country_dtls) 
	{
		my $key_length = length($_);
		print "$_ key length is $key_length \n";
		if ($str_len >= $key_length) 
		{
			my $start_pos = $str_len-$key_length;
			print " start pos is $start_pos \n";
			my $cntry_val = substr($_,$start_pos,$key_length);
			print " cntry value is $cntry_val \n";
			my $cntry_var_len = length($cntry_val);
			if ($cntry_var_len==$key_length && $cntry_val eq $element) 
			{	
				$iso_code = $country_dtls{$_};
				
			}
		}
	}
}

#my $iso_code = $hash_ref_2->{$Addrs_string};
print  " $Addrs_string ISO code is $iso_code";
#return $iso_code if($iso_code) || return "100";
}