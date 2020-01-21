
%groups in royal.pl
%died died parent married male female 

:- consult('royal.pl').

%mother/2
%Returns A mohter M if given a child or returns the children (male/femal)e if given a mother M.
mother(M,C):- parent(M,C), female(M).

%Father/2
%same process as listed in mother comment.
father(F,C):- parent(F,C), male(F).

%spouse/2
%pretty simple if given P returns OP or vise versa, by looking at the married defs in royal.pl
spouse(P,OP):- married(P,OP).
spouse(P,OP):- married(OP,P).

%child/2
%returns a child C if given a parent or returns a parent if given a child C.
child(C,P):- parent(P,C), C \= P. 

%daughter/2
%Returns father then mother if given daughter. Or returns a daughter if given a parent mother/father. 
daughter(D,P):- parent(P,D), female(D).

%son/2
%works the same as daughter 
son(S,P):- parent(P,S), male(S).

%sibling/2
%By taking A or B it gets the parent (father) P and then returns the the other childrend from said 
%father P
sibling(A,B):- parent(P,A), parent(P,B), male(P), not(A=B), A \= B.

%brother/2
%uses sibling to return brother B by only returning siblings that are male.
%Or if given B it will return the brother and sisters of brother B.
brother(A,B):- sibling(A,B), male(B).

%sister/2
%works the same as brother
sister(A,B):- female(A), sibling(A,B).

%aunt/2
%first returns aunts that are siblings to mother and father.
%second returns aunts by marriage 
aunt(A,B):- parent(P,B), sibling(P,A), female(A).
aunt(A,B):- parent(P,B), sibling(P,S), spouse(S,A), female(A), not(A=B). 

%uncle/2
%first returns uncles by siblings to father/mother.
%second returns uncles by marriage.
uncle(A,B):- parent(P,B), sibling(P,S), spouse(S,A), male(A), not(A=B).
uncle(A,B):- parent(P,B), sister(P,S), spouse(S,A), male(A).



%grandparent/2
%pretty simple given B returns their grandparents, or given A returns the grandchildren
grandparent(A,B):- parent(P,B), parent(A,P).

%grandmother/2
%works the same as grandparent but only returns grandmother if given B or returns grandchildren 
%of grandma A. 
grandmother(A,B):- parent(P,B), parent(A,P), female(A).

%grandfather/2
%works the same as grandma.
grandfather(A,B):- parent(P,B), parent(A,P), male(A).

%grandchild/2 grandmo/fa is B
%returns grandchildren of B or returns grandparents of A.
grandchild(A,B):- child(C,B), child(A,C). 

%ancestor/2 A is a ancestor of B
%first is used for recursion to climb up the tree of parents so to speak or down.
%second starts the recursion.
ancestor(A,B):- parent(A,B).%used for recursion
ancestor(A,B):- parent(A,C), ancestor(C,B).

%descendant/2 A is descendant of B
%works the same as ancestor but climbs up and down the tree of children and parents called from
%the child rule.
descendant(A,B):- child(A,B).
descendant(A,B):- child(C,B), descendant(A,C).

%older/2
%pretty simple if given A it gets the birthdate and returns those with brithdays less than B.
%or if given B it returns those that are older.
older(A,B):- born(A,BD), born(B,BD2), BD<BD2.

%younger/2
%same as older but in reverse.
younger(A,B):- born(A,BD), born(B,BD2), BD>BD2.

%regentwhenborn/2
%regent works by if given A finds all the people that ruled under them by listing those that 
%fall withing the time they reigned.  If given B it finds there regent.  
%This is done by comparing the dates.
regentWhenBorn(A,B):- born(B,BD), reigned(A,S,E), BD>S, BD<E. 

%cousin
cousin(A,B):- parent(P,B), sibling(P,S), child(A,S).
%cousin(A,B):- parent(P,B), sibling(P,S), spouse(S,S2), child(A,S2).








