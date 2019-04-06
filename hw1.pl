print getanswer("Transfer file name is Trans.fa",);

sub getanswer{
  $v1 = shift; #shift, pop
  print "Please tell me your file name : "; #push, unshift
  my $name = <STDIN>;
  chomp $name; # chomp �h�����ڪ�����Ÿ�
  
  # �g�J���
  use Bio::Seq; use Bio::SeqIO;
  $seqio_obj = Bio::SeqIO->new(-file => $name,
                               -format => "fasta" );
  $seq_obj = $seqio_obj->next_seq; # single sequence
  
  # part O(��l���)
  print "=======================================\n";
  print "Origin:\n";print $seq_obj->seq,"\n";
  print "=======================================\n";
  # part I(ATCG�ഫ+����)
  print "Transfer:\n";
  $a = $seq_obj->seq;$a =~ tr/atcgATCG/tagcTAGC/;$a = reverse $a;
  print $a,"\n";
  
  # ��X���G�ëإ��ɮ�
  $seq_obj = Bio::Seq->new(-seq=>$a,
                           -desc => "Transfer result:",
                           -alphabet => "dna" );
  $seqio_obj = Bio::SeqIO->new(-file => '>Trans.fa',
                               -format =>'fasta' );
  $seqio_obj->write_seq($seq_obj);
  print "=======================================\n";
  return $v1,"\n";
}


