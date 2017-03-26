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
clauses %% clause berisi tentang 
  person(bert,55,m,carpenter).%% bert adalah seorang tukang kayu yang berusia 55 thn
  person(allan,25,m,football_player).%%alan adalah seorang pemain sepak bola yang berusia 25 thn
  person(allan,25,m,butcher).
  person(john,25,m,pickpocket).%%jhon adalah seorag pencopet yang berusia 25 thn

  had_affair(barbara,john).%%barbara berselingkuh dengan jhon
  had_affair(barbara,bert).%%barbara berselingkuh dengan bert
  had_affair(susan,john).%%susan berselingkuh dengan jhon

  killed_with(susan,club).%% susan terbunuh dengan pentungan
  killed(susan).
  
%% motif-motif yang mendasari penyebab terjadinya pembunuhan
  motive(money).
   motive(jealousy).
  motive(righteousness).
%%orang yang ternodai dengan darah,lumpur dan coklat
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

  suspect(X):-%% X dicurigai apabila
	motive(money),%%bermotivkan uang
	person(X,_,_,pickpocket).%%X adalah pencopet

  killer(Killer):- %% pembunuh dikatakan pembunuh apabila 
	person(Killer,_,_,_),%dan orang tersebut adalah pembunuh
	killed(Killed),%%jika orang tersebut pembunuh
	Killed <> Killer, /* It is not a suicide */
	suspect(Killer),%% pembunuh di curigai
	smeared_in(Killer,Goo),%%pembunuh ternodai oleh zat
	smeared_in(Killed,Goo).

goal%% goal dari program ini adalah mencari siapa pelaku yang membunuh
  killer(X).
  %%goal dari program adalah mencari siapa pelaku yang membunuh
  %%pembunuhnya adalah bert
  %%di karenakan pembunuhnya yang ternodai zat adalah bert
  %%karena di goal yang di cari adalah pembunuh maka jawabannya adalah bert
  %%  kesimpulannya adalah Pembunuhan dari program yang di buat adalah bert , yang menjdikan korban bert adalah susan dikarenakan bert tidak memiliki uang dan juga kecemburuan sehingga menimbulkan dendam sehingga terjadi pembunuhan yang menelan korban jiwa 
