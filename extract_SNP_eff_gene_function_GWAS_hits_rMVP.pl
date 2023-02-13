#!/usr/bin/perl
#

%hash = ();
open(IN,"$ARGV[0]") or die $!;
##INFO=<ID=ANN,Number=.,Type=String,Description="Functional annotations: 'Allele | Annotation | Annotation_Impact | Gene_Name | Gene_ID | Feature_Type | Feature_ID | Transcript_BioType | Rank | HGVS.c | HGVS.p | cDNA.pos / cDNA.length | CDS.pos / CDS.length | AA.pos / AA>
#glyma.Wm82.gnm4.Gm18    55997272        18_55997272     G       A       .       .       ANN=A|intergenic_region|MODIFIER|||||||||||||
#glyma.Wm82.gnm4.Gm02    16122575        2_16122575      G       C       .       .       ANN=C|intergenic_region|MODIFIER|Glyma.02G140100-CHR_END|glyma.Wm82.gnm4.ann1.Glyma.02G140100-CHR_END|intergenic_region|glyma.Wm82.gnm4.ann1.Glyma.02G140100-CHR_END|||n.16122575G>C|||
#glyma.Wm82.gnm4.Gm02    6665132 2_6665132       T       C       .       .       ANN=C|missense_variant|MODERATE|Glyma.02G077200|glyma.Wm82.gnm4.ann1.Glyma.02G077200|transcript|glyma.Wm82.gnm4.ann1.Glyma.02G077200.1|protein_coding|2/4|c.154T>C|p.Ser52Pro|574/2944|154/2187
while ($line = <IN>){
        chomp($line);
        if($line =~ /^\S+\t\S+\t(\S+)\t\S+\t\S+\t\S+\t\S+\t(\S+)/){
                $hash{$1} = $2;
        }
}
close IN;

#glyma.Wm82.gnm4.Gm01    phytozomev13    gene    27344   28430   .       -       .       ID=glyma.Wm82.gnm4.ann1.Glyma.01G000100;Name=Glyma.01G000100;ancestorIdentifier=Glyma.01G000100.Wm82.a2.v1;Dbxref=Gene3D:G3DSA:3.30.390.10;Note=protein PHYLLO%2C chloroplastic-like isoform X1 [Glycine max]
%hash1 = ();
open(IN,"$ARGV[1]") or die $!;
while ($line = <IN>){
        chomp($line);
        if($line =~ /^\S+\t\S+\tgene\t\d+\t\d+\t\S+\t\S+\t\S+\tID=(\S+);Name=\S+.*;Note=(.*)$/){
                $hash1{$1} = $2;
        }
}
close IN;
#print %hash1;

#10      1246351 10_1246351      A       T       6.58687552474146e-06    0.061624649859944       357     0.988858125911306
#10      1246380 10_1246380      G       A       6.58687552474146e-06    0.061624649859944       357     0.988858125911306
#10      1246482 10_1246482      C       A       6.58687552474146e-06    0.061624649859944       357     0.988858125911306
#6       12338454        6_12338454      T       C       2.25403225117535e-06    0.0856269113149847      327     0.612267891436702
#6       12339918        6_12339918      C       T       2.25403225117535e-06    0.0856269113149847      327     0.612267891436702
#9       38457008        9_38457008      C       A       5.23697222355238e-06    0.284403669724771       327     0.612267891436702

@arr = ();
open(IN,"$ARGV[2]") or die $!;
open(OUT,">$ARGV[3]") or die $!;
while ($line = <IN>){
       chomp($line);
        if($line =~ /^\S+\t\d+\t(\S+)\t(.*)$/){
                @arr = split(/\|/, $hash{$1});
                print OUT "$line\t$arr[0]\t$arr[1]\t$arr[2]\t$arr[4]\t$arr[7]\t$arr[9]\t$arr[10]\t$hash1{$arr[4]}\n";
                @arr = ();
        }
}
close IN;
close OUT
