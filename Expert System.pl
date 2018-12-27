
:- use_module(library(jpl)).
start :-sleep(0.4),	
		write('-----------------------------------------------------------------'),nl,
		sleep(0.4),
		write('*****************************************************************'),nl,
		sleep(0.2),
		write("########||| EXPERT SYSTEM FOR DYSGRAPHIA DIAGNOSIS |||########"),nl,
		sleep(0.4),
		write('*****************************************************************'),nl,
		sleep(0.4),
		write('-----------------------------------------------------------------'),nl,nl,nl,
		
/*Calling front end of expert system*/	
		
		interface0.
		
	/*12 symptomps to check in order to diagnose dysgraphia*/   
    %S1    
    symptom(wrong_in_holding_pen) :- verify(" Holds pen or pencil wrongly (y/n) ?").
    %S2
    symptom(unideal_font_size) :- verify(" Written font size is unideal (y/n) ?").
  %S3
    symptom(thin_writing) :- verify(" Thin writing (y/n) ?").
   %S4
    symptom(slow_writing) :- verify(" Slow writing (y/n) ?").
    %S5
    symptom(up_downhill) :- verify(" Up or downhill writing (y/n) ?").
    %S6
    symptom(irr_ltr_space) :- verify(" Irregular distance between letters (y/n) ?").
	%S7
    symptom(unideal_shape) :- verify(" Unideal shape of the letter (y/n) ?").
 %S8
    symptom(quick_tired) :- verify(" Hands quickly feels tired (y/n) ?").
   %S9
    symptom(mixed_ltr) :- verify(" Capital letters and lowercase letters are still mixed (y/n) ?").
  %S10
    symptom(incomplete) :- verify(" Incomplete writing (y/n) ?").
   %S11
    symptom(misperception) :- verify(" Letter misperception (y/n) ?").
	%S12
    symptom(unable_finish) :- verify(" Unable to finish writing test (y/n) ?").
		
ask(Question) :-
	write(Question),
	/*read(N),
	( (N == yes ; N == y)
      ->
       assert(yes(Question)) ;
       assert(no(Question)), fail),*/
	
	interface(' ','student',Question),
	write('Loading.'),nl,
	sleep(1),
	nl.
	
:- dynamic yes/1,no/1.		
	
verify(S) :-
   (yes(S) 
    ->
    true ;
    (no(S)
     ->
     fail ;
     ask(S))).
	 
undo :- retract(yes(_)),fail. 
undo :- retract(no(_)),fail.
undo.

pt4:- (symptom(unable_finish) -> interface3('student probably have ','severe','Dysgraphia.')
       ; interface3(', student probably have ','moderate ','Dysgraphia.')
       ).

pt3:-((symptom(mixed_ltr),symptom(incomplete),symptom(misperception)) -> interface3('student probably have ','severe ','Dysgraphia.')
       ; pt4).

pt2:- (symptom(quick_tired)-> pt3;interface3('student probably have ','moderate ','Dysgraphia.')
       ).

pt1:- (symptom(slow_writing)
       ->pt2;interface3('student probably have ','light ','Dysgraphia.')
       ).

pt:- ((symptom(wrong_in_holding_pen),symptom(unideal_font_size),symptom(thin_writing))
      -> pt1;
		interface3('student probably have ','normal ','Dysgraphia.')).
        
end :-
		nl,nl,nl,
		sleep(0.7),
		write('*****************************************************************'),nl,
		sleep(0.4),
		write("################||| THANK YOU FOR USE ME |||#####################"),nl,
		sleep(0.4),
		write('*****************************************************************'),nl.

interface(X,Y,Z) :-
	atom_concat(Y,X, FAtom),
	atom_concat(FAtom,Z,FinalAtom),
	jpl_new('javax.swing.JFrame', ['Expert System'], F),
	jpl_new('javax.swing.JLabel',['--- EXPERT SYSTEM ---'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showInputDialog, [F,FinalAtom], N),
	jpl_call(F, dispose, [], _), 
	write(N),nl,
	( (N == yes ; N == y)
      ->
       assert(yes(Z)) ;
       assert(no(Z)), fail).
	   		



interface0 :-
	jpl_new('javax.swing.JFrame', ['Expert System for diagnosis of Dysgraphia'], F),
	jpl_new('javax.swing.JLabel',['--- EXPERT HELPER ---'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showMessageDialog, [F,'Dectate following paragraph to your student once he is done writing click OK: On Sunday my father and I went to grandma\'s house in
town. We rode our bikes together. Upon arriving at
Grandma\'s house, we were greeted cheerfully by the
grandmother'], N),
	jpl_call(F, dispose, [], _), 
	/*write(N),nl,*/
	(	N == @(null)
		->	write('you cancelled'),interface3('you cancelled. ','Thank you ','for use ','me.'),end,fail
		;	write("Hi! dectet : "),write(N),nl,pt
	).





	
	
interface3(W1,D,W2) :-
	atom_concat(W1,D,B),
	atom_concat(B,W2,W3),
	jpl_new('javax.swing.JFrame', ['Expert System'], F),
	jpl_new('javax.swing.JLabel',['--- MEDICAL EXPERT SYSTEM ---'],LBL),
	jpl_new('javax.swing.JPanel',[],Pan),
	jpl_call(Pan,add,[LBL],_),
	jpl_call(F,add,[Pan],_),
	jpl_call(F, setLocation, [400,300], _),
	jpl_call(F, setSize, [400,300], _),
	jpl_call(F, setVisible, [@(true)], _),
	jpl_call(F, toFront, [], _),
	jpl_call('javax.swing.JOptionPane', showMessageDialog, [F,W3], N),
	jpl_call(F, dispose, [], _), 
	/*write(N),nl,*/
	(	N == @(void)
		->	write('')
		;	write("")
	).
	
help :- write("To start the expert system please type 'start.' and press Enter key").