:- dynamic movies/5,category/1,language/1 .

/*list */
category(["'Drama'","'Science'","'Fantasy'","'Mystery'","'Action'","'Crime'","'Romance'","'Comedy'","'Animation'","'Horror'"]).
language(["'English'","'Korean'","'Indian'","'Japanese'","'No preference'"]).



/*movies(title,category,language).*/

movies('Doctor Sleep',"'Horror'","'English'").
movies('Midway',"'Action'","'English'").
movies('The Goldfinch',"'Drama'","'English'").
movies('Toy Story 4',"'Animation'","'English'").
movies('Noelle',"'Fantasy'","'English'").
movies('Crawl',"'Action'","'English'").
movies('Motherless Brooklyn',"'Crime'","'English'").
movies('Let It Snow',"'Romance'","'English'").

movies('Until I Meet Septembers Love',"'Romance'","'Japanese'").
movies('Snow Flower',"'Romance'","'Japanese'").
movies('Kingdom',"'Action'","'Japanese'").
movies('Weathering with You',"'Animation'","'Japanese'").
movies('Parallel World Love Story',"'Mystery'","'Japanese'").
movies('Hit Me Anyone One More Time',"'Comedy'","'Japanese'").
movies('12 Suicidal Teens',"'Mystery'","'Japanese'").
movies('Sadako',"'Horror'" ,"'Japanese'").
movies('Bento Harassment',"'Drama'","'Japanese'").
movies('Makuko',"'Science'","'Japanese'").

movies('Gully Boy',"'Drama'","'Indian'").
movies('Kabir Singh',"'Romance'","'Indian'").
movies('De De Pyaar De',"'Comedy'","'Indian'").
movies('Chhichhore',"'Comedy'","'Indian'"). 
movies('Mission Mangal',"'Drama'","'Indian'").
movies('The Zoya Factor ',"'Romance'","'Indian'"). 
movies('Article 15 ',"'Crime'","'Indian'").
movies('Section 375 ',"'Crime'","'Indian'"). 
movies('9: Nine ',"'Horror'","'Indian'").
movies('Bypass Road',"'Drama'","'Indian'").
movies('706 ',"'Horror'","'Indian'").
movies('Ghost ',"'Horror'","'Indian'").

movies('Extreme Job',"'Action'","'Korean'").
movies('The Gangster, the Cop, the Devil',"'Action'","'Korean'").
movies('The Divine Fury',"'Horror'","'Korean'").
movies('Parasite',"'Comedy'","'Korean'").
movies('The Man Inside Me',"'Comedy'","'Korean'").
movies('Bad Guys: The Movie',"'Crime'","'Korean'").
movies('Eorin uiroein',"'Drama'","'Korean'").
movies('No Mercy',"'Action'","'Korean'").
movies('Exit',"'Action'","'Korean'").
movies('Tazza: One Eyed Jack',"'Crime'","'Korean'").
movies('Witness',"'Crime'","'Korean'").
movies('Birthday',"'Drama'","'Korean'").
movies('Idol',"'Crime'","'Korean'").
movies('Romang',"'Romance'","'Korean'").


/*start Rule*/
start:-
      write('*** Movies Recommendation System ***'),nl,nl,
      menu.
/*Main menu rule*/
menu:- 
     nl,nl,
     write('Do you want to watch a movie? "Select 1 or 2"'),nl,
     write('1- Yes'),nl,
     write('2- No'),nl,

write('Enter your choice:'),nl,
read(X),
option(X).

/*second menu rule*/
menutwo:-
nl,nl,
write('Do you want another recommendation? "Select 1 or 2"'),nl,
write('1- Yes'),nl,
write('2- No'),nl,
write('Enter your choice:'),nl,
read(X),
option(X).



/*menu option rule*/
option(1):-
         write(' What is your mode? "Select from 1 to 10"'),nl,
         category(L),
         (display(L,0);true),
         write('Enter your choice:'),
         nl,read(X),
		 checkinput(X,L),
		 nb_getval(checkresult,S),
		 mode(S).

option(2):-
         write('Thank you for using our system').

/* movie's filter questions*/

mode(X):-
         T is X-1,
         category(L),
         nth0(T,L,Result1),
         nb_setval(result1,Result1),
	   nb_setval(result1,Result1),
         write('What is your preferred movies language? "Select from 1 to 5 or 0 to print recommendation"'),nl,
         language(R),
         (display(R,0);true),
         write('Enter your choice:'),nl,
         read(S), checkinput(S,R),
	   nb_getval(checkresult,A),
         (A =:= 0 ->( nb_setval(flag,1),end );(languageRest(A))).


languageRest(X):-
                N is X-1,
                language(R),
                nth0(N,R,Result2),
				(Result2 == "'No preference'"  ->( nb_setval(result2," "));(nb_setval(result2,Result2))),
                
      	    nb_setval(flag,2)
                ,end.
		
end:- nb_getval(flag,Flag),print(Flag).
	
/* movie's filter result*/
print(1):- 
         
         nb_getval(result1,Result1),nl,
         write('** Based on your preferences **'),nl,
         write('Category: ') ,write(Result1),nl,
         write('I Recommend: '),
		 nl, (printFinalResult(Result1,_);true),
		 nl,nl,write('**Note: if there is no result that it is mean there is no match with your preferences**'),
		 menutwo.

print(2):-  
         nb_getval(result1,Result1),
         nb_getval(result2,Result2),
         write('** Based on your preferences **'),nl,
         write('Category: ') ,write(Result1),nl,
         write('Language: '), ( Result2 == " "->(write(' No preferences '),nb_setval(result2,_));(write(Result2))),nl,
	     write('I Recommend: '), 
		 nb_getval(result2,Result2new),
		 nl, (printFinalResult(Result1,Result2new);true),
		 nl,nl,write('**Note: if there is no result that it is mean there is no match with your preferences**'),
		 menutwo.


printFinalResult(Result1,Result2):-
                                    nl,
                                    movies(J,Result1,Result2),
                                    nl,
                                    write(J).

display([]).
display([H|T],A):-  
                  M is A+1,
                  write(M),
                  write('- '),
                  write(H),
			      nl,
                  write(' '),
                  display(T,M).    

checkinput(A,L):-
         length(L,Len),
		 ( A>Len ->(write('Please enter valid number: '),read(D),checkinput(D,L) ) ; (nb_setval(checkresult,A),nl) ).