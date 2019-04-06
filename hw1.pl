print getanswer("Transfer file name is Trans.fa",);

sub getanswer{
  $v1 = shift; #shift, pop
  print "Please tell me your file name : "; #push, unshift
  my $name = <STDIN>;
  chomp $name; # chomp 去掉尾巴的換行符號
  
  # 寫入資料
  use Bio::Seq; use Bio::SeqIO;
  $seqio_obj = Bio::SeqIO->new(-file => $name,
                               -format => "fasta" );
  $seq_obj = $seqio_obj->next_seq; # single sequence
  
  # part O(原始資料)
  print "=======================================\n";
  print "Origin:\n";print $seq_obj->seq,"\n";
  print "=======================================\n";
  # part I(ATCG轉換+反轉)
  print "Transfer:\n";
  $a = $seq_obj->seq;$a =~ tr/atcgATCG/tagcTAGC/;$a = reverse $a;
  print $a,"\n";
  
  # 輸出結果並建立檔案
  $seq_obj = Bio::Seq->new(-seq=>$a,
                           -desc => "Transfer result:",
                           -alphabet => "dna" );
  $seqio_obj = Bio::SeqIO->new(-file => '>Trans.fa',
                               -format =>'fasta' );
  $seqio_obj->write_seq($seq_obj);
  print "=======================================\n";
  return $v1,"\n";
}


