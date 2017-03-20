predicates			%digunakan untuk mendeklarasikan predikat
  laki(symbol) - nondeterm (o)
  perempuan(symbol) - nondeterm (o)
  kembaran(symbol,symbol) - nondeterm (o,o)

clauses				%digunakan untuk mendefinisikan predikat, atau isi dari predikat
  laki(nando).			%laki adalah predikat, nando adalah deklarasi isi defenisi dari predikat
  
  laki(linus).
  laki(burhan).

  perempuan(ursula).
  perempuan(stela).

  kembaran(nando,ursula).
  kembaran(linus,stela).
  kembaran(nando,burhan).
goal			%goal adalah tujuan yang akan mengoutput dari perytaan yang di berikan di bawah			
 kembaran(Kembaran,X).	%memanggil nama orang yang kembar(Kembaran)
