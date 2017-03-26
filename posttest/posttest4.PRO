/*****************************************************************************

		Copyright (c) 1984 - 2000 Prolog Development Center A/S

 Project:  
 FileName: CH04E12.PRO
 Purpose: 
 Written by: PDC
 Modifyed by: Eugene Akimov
 Comments: 
******************************************************************************/

trace
domains
  name,sex,occupation,object,vice,substance = symbol
  age=integer

predicates
  person(name,age,sex,occupation) - nondeterm (o,o,o,o), nondeterm (i,o,o,i), nondeterm (i,o,i,o)
  had_affair(name,name) - nondeterm (i,i), nondeterm (i,o)
  killed_with(name,object) - determ (i,o)
  killed(name) - procedure (o)
  killer(name) - nondeterm (o)
  motive(vice) - nondeterm (i)
  smeared_in(name,substance) - nondeterm (i,o), nondeterm (i,i)
  owns(name,object) - nondeterm (i,i)
  operates_identically(object,object) - nondeterm (o,i)
  owns_probably(name,object) - nondeterm (i,i)
  suspect(name) - nondeterm (i)

/* * * Facts about the murder * * */
clauses 
  person(bert,55,m,carpenter).
  person(allan,25,m,football_player).
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).

  had_affair(barbara,john).
  had_affair(barbara,bert).
  had_affair(susan,john).

  killed_with(susan,club).%% orang yang terbunuh
  killed(susan).%% orang yang terbunuh

  motive(money).%% motif-motif yang mendasari penyebab terjadinya pembunuhan
  motive(jealousy).
  motive(righteousness).

  smeared_in(bert,blood).
  smeared_in(susan,blood).
  smeared_in(allan,mud).
  smeared_in(john,chocolate).
  smeared_in(barbara,chocolate).

  owns(bert,wooden_leg).
  owns(john,pistol).

/* * * Background knowledge * * */

  operates_identically(wooden_leg, club).
  operates_identically(bar, club).
  operates_identically(pair_of_scissors, knife).
  operates_identically(football_boot, club).

  owns_probably(X,football_boot):-
	person(X,_,_,football_player).
  owns_probably(X,pair_of_scissors):-
	person(X,_,_,hairdresser).
  owns_probably(X,Object):-
	owns(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * *
 * Suspect all those who own a weapon with   *
 * which Susan could have been killed.       *
 * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	killed_with(susan,Weapon) ,%% di curigai terbunuhnya susan pelaku menggunakan senjata
	operates_identically(Object,Weapon) ,
	owns_probably(X,Object).

/* * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect men who have had an affair with Susan.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):- %% di curigai motif pembunuhan di karenakan adanya kecemburuan
	motive(jealousy)
	person(X,_,m,_),
	had_affair(susan,X).

/* * * * * * * * * * * * * * * * * * * * *
 * Suspect females who have had an       *
 * affair with someone that Susan knew.  *
 * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	motive(jealousy),
	person(X,_,f,_),
	had_affair(X,Man),
	had_affair(susan,Man).

/* * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Suspect pickpockets whose motive could be money.  *
 * * * * * * * * * * * * * * * * * * * * * * * * * * */

  suspect(X):-
	motive(money),
	person(X,_,_,pickpocket).

  killer(Killer):- %% melacak data yang cocok dengan goal 
	person(Killer,_,_,_),%%memanggil subgoal
	killed(Killed),%%mencari siapa korban yang di bunuh
	Killed <> Killer, /* It is not a suicide */
	suspect(Killer),%% mencari alasan yang di curigai sebagai pembunuh 
	smeared_in(Killer,Goo),%%mencari orang yang ternodai dengan darah
	smeared_in(Killed,Goo).

goal%% goal dari program ini adalah mencari siapa pelaku yang membunuh
  killer(X).
  
  %%langkah pertama program akan mengecek siapa korban yang terbunuh
  %%dan pada langkah ke dua program akan mengecek siapa pelaku pembunuhan, setalah di cek ternyata bert adalah pelaku pembunuhan
  %%lalu program melakukan pengecekan kembali pada bert
  %%lalu pada kecurigaan pertama program akan mencari orang yang mempunyai alat berupa pentungan yang di gunakan sebagai alat untuk membunuh sang korban
  %%ternyata bert mempunya tanda-tanda alt yang serupa dengan pentungan yaitu wooden_leg (kaki kayu)
  %%dan program mengecek di tubuh yang terdapat noda darah
  %%dan setelah di cek ternyata noda darah ada di tubuh bert dan susan, dan korban yang terbunuh adalah susan dan ternodai darah maka bert yang menjadi pembunuhnya di karenakan bert juga mempunyai noda yang sama
  %%  kesimpulannya adalah Pembunuhan dari program yang di buat adalah bert , yang menjdikan korban bert adalah susan dikarenakan bert tidak memiliki uang dan juga kecemburuan sehingga menimbulkan dendam sehingga terjadi pembunuhan yang menelan korban jiwa 
