domains
nma,k=symbol
%nma = nama, k = kasir

predicates
nondeterm kasir(k,nma,nma,nma,nma,nma,nma)
nondeterm kasir(k,nma,nma,nma)
nondeterm nma_pagi(nma,nma,nma,nma)
nondeterm nma_siang(nma,nma,nma,nma)
nondeterm nma_malam(nma,nma,nma,nma)

clauses
kasir(kasir1,burhan,mansur,boy,pevita,selena,lebron).
kasir(kasir2,herman,ebi,aan).
kasir(kasir3,nando,adi,dina).
nma_pagi(mansur,pevita,herman,nando).
nma_siang(burhan,lebron,ebi,adi).
nma_malam(selena,aan,boy,dina).

goal
write("penjaga kasir yang menjaga kasir1:"),nl,kasir(kasir1,NMA1,NMA2,NMA3,NMA4,NMA5,NMA6);
nl,write("penjaga kasir yang menjaga kasir2:"),nl,kasir(kasir2,NMA1,NMA2,NMA3);
nl,write("penjaga kasir yang menjaga kasir3:"),nl,kasir(kasir3,NMA1,NMA2,NMA3);
nl,write("penjaga kasir yang jaga pagi:"),nl,nma_pagi(NMA1,NMA2,NMA3,NMA4);
nl,write("penjaga kasir yang jaga siang:"),nl,nma_siang(NMA1,NMA2,NMA3,NMA4);
nl,write("penjaga kasir yang jaga malam:"),nl,nma_malam(NMA1,NMA2,NMA3,NMA4);
nl,write("seluruh penjaga kasir:"),nl,kasir(_,NMA1,NMA2,NM3);kasir(_,NMA1,NMA2,NMA3,NMA4,NMA5,NMA6).
