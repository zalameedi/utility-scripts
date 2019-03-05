(*Programmer: Zeid Al-Ameedi
  Dates worked on 09/5/18 to 09/12/18*)
  
  
 (*Helper Functions scattered*)
 fun nthEle([], n) = 0 
	 | nthEle(x::rest, n) = if n=0 then x else nthEle(rest, n-1);
	 
fun length [] = 0
	| length (_::rest) = 1 + length rest;

	
(*Homework problems*)

fun exists (a, []) = false
	| exists(a, x::rest) = if a = x then true 
		else exists(a, rest); 

(*The reason it's double alpha is because we're doing a comparision or otherwise known as equality testing when we check 
the value extracted from the list against our target value. The ''a explicity tells the user that this type can only be subbed or used when equality testing is present*)

fun countInList [] v = 0
	| countInList (x::rest) v = if v=x then 1 + countInList rest v
	else countInList rest v;

(* fun listDiff ([], []) = []
	| listDiff (x::rest, []) = (x::rest)
	| listDiff(x::rest, y::rest2) = 
				if countInList rest2 x = 0 then listDiff(rest, y::rest2)
	else x::[];  *)
	
fun listDiff ([],[]) = []
	| listDiff ([], _) = []
	| listDiff (x::rest, y) = if countInList y x = 0 andalso not(exists(x,y)) then x::(listDiff(rest, y)) else (listDiff (rest, y) );
	
fun firstN [] k = []
	| firstN (x::rest) k = if k > 0 then x::firstN(rest)(k-1 ) else if k >= length(x::rest) then (x::rest) else [];

	
val buses = [
("Lentil",["Chinook", "Orchard", "Valley", "Emerald","Providence",
"Stadium", "Main", "Arbor", "Sunnyside", "Fountain", "Crestview",
"Wheatland", "Walmart", "Bishop", "Derby", "Dilke"]),
("Wheat",["Chinook", "Orchard", "Valley", "Maple","Aspen",
"TerreView", "Clay", "Dismores", "Martin", "Bishop", "Walmart",
"PorchLight", "Campus"]),
("Silver",["TransferStation", "PorchLight", "Stadium",
"Bishop","Walmart", "Shopco", "RockeyWay"]),
("Blue",["TransferStation", "State", "Larry", "TerreView","Grand",
"TacoBell", "Chinook", "Library"]),
("Gray",["TransferStation", "Wawawai", "Main",
"Sunnyside","Crestview", "CityHall", "Stadium", "Colorado"])
]	
	
fun busFinder myStop [] = [] 
	| busFinder myStop ((route, stops)::rest) = if exists(myStop, stops) then route::busFinder myStop (rest) else busFinder myStop (rest);
	
(*The reason the type is the following is because the comparision happens with the bus stop names (being compared to each other) and the compiler
views them as same type. The bus names themselves are not compared and can be excluded are independent types congruently different from each other. *)


(* fun pResistor [] = 0.0
	| pResistor (x::rest) = ((1.0 / x) + pResistor (rest)); *)

fun parallelResistors [] = 0.0
	| parallelResistors (x::rest) =
	let 
			fun pResistor [] = 0.0
				| pResistor (x::rest) = ((1.0 / x) + pResistor (rest))
	
	in 
		1.0 / pResistor(x::rest)
	end;
	
(*The reason the function returns those results is due to careful calculation of the formula. The formula is able to be broken down into pieces and priority given based on mathematical
knowledge. Thus the real time must be enabaled since we're dealing with division of a one.*)

(* fun nestLists [] n = []
	| nestLists (x::rest) n = if n <> 0 then x::nestLists (rest) (n-1) else nestLists(rest)(n);

fun nestLists2 [] = []
	| nestLists2 (x::rest) = (x::rest)::[];

fun storeRes [] L = []
	| storeRes (x::rest) L = (x::rest)@L; *)

(*Created my own standard template function to extract rest from a list*)
(* fun lastN(L, 0) = L
| lastN ([], k) = []
	| lastN(_::rest, k) = lastN(rest,k-1); *)

(*Tuple version of the firstN function for better format...*)
(* fun firstNtuple([], k) = []
	| firstNtuple(x::rest, n) = if n>0 then x::firstNtuple(rest, n-1) else []; *)
	
								
fun pairNright (N, L) = 
	let
		fun firstNtuple([], k) = []
		| firstNtuple(x::rest, n) = if n>0 then x::firstNtuple(rest, n-1) else []
		
		fun lastN(L, 0) = L
		| lastN ([], k) = []
		| lastN(_::rest, k) = lastN(rest,k-1)
		
		fun rightHelper (N, L, buffer) = if length(L) <= N then rev(L::rev(buffer)) else 
								rightHelper(N, lastN(L, N), rev((firstNtuple (L,N))::rev(buffer)))
	in 
			rightHelper(N, L, [])
	end;

fun pairNleft (N, L) = 
	let 
		fun firstNtuple([], k) = []
			| firstNtuple(x::rest, n) = if n>0 then x::firstNtuple(rest, n-1) else []
			
		fun lastN(L, 0) = L
	| lastN ([], k) = []
	| lastN(_::rest, k) = lastN(rest,k-1)
	
		fun leftHelper (N, [], buffer) = buffer 
			| leftHelper (N, L, buffer) = if length(L) mod N = 0 then leftHelper(N, lastN(L, N), rev(firstNtuple(L, N)::rev(buffer)))
										else leftHelper(N, lastN(L, length(L) mod N), rev(firstNtuple(L, length(L) mod N)::rev(buffer)))
	in 													
		leftHelper(N, L, [])
	end;


(*Test functions begin here*)

(*Problem 1 tested*)
fun existsTest() =
	let 
		val t1 = (exists(1,[]) = false);
		val t2 = (exists(1, [1,2,3]) = true);
		val t3 = (exists([1], [[3],[5]]) = false);
		val t4 = (exists("c", ["b","c","z"]) = true);
		val t5 = (exists(3, [1,2,3,3,3]) = true);
		val t6 = (exists("c", ["c","o", "m", "p"]) = true);
	in
		  print ("exists:-------------------- \n" ^
          "test1: " ^ Bool.toString(t1) ^ "\n" ^
	      "test2: " ^ Bool.toString(t2) ^ "\n" ^
	      "test3: " ^ Bool.toString(t3) ^ "\n" ^
	      "test4: " ^ Bool.toString(t4) ^ "\n" ^
	      "test5: " ^ Bool.toString(t5) ^
	      "\n----------------\n")
	end 
val _ = existsTest ()
		

(*Problem 1.3 tested*)
fun countInListTest() =
	let 
		val t1 = ((countInList ["3","5","5","-","4","5","1"] "5") = 3);
		val t2 = ((countInList [] "5") = 0);
		val t3 = ((countInList [true, false, false, false, true, true, true]  true) = 4);
		val t4 = ((countInList [1, 1, 1, 2, 2, 2, 3, 3, 3] 1) = 3);
		val t5 = ((countInList [[],[1,2],[3,2],[5,6,7],[8],[]]  []) = 2);
		val t6 = ((countInList ["a", "b", "c", "..."] "a") = 1);
	in
		  print ("countInList:-------------------- \n" ^
          "test1: " ^ Bool.toString(t1) ^ "\n" ^
	      "test2: " ^ Bool.toString(t2) ^ "\n" ^
	      "test3: " ^ Bool.toString(t3) ^ "\n" ^
	      "test4: " ^ Bool.toString(t4) ^ "\n" ^
	      "test5: " ^ Bool.toString(t5) ^
	      "\n----------------\n")
	end 
val _ = countInListTest ()

(*Problem 2 tested*)
fun listDiffTest() = 
	let 
		val t1= listDiff (["a", "b", "c"],["b"]) = ["a", "c"];
		val t2 = listDiff ([1,2,3],[1,1,2]) = [3];
		val t3 = listDiff ([],[]) = [];
	in 
		print ("listDiff:-------------------- \n" ^
          "test1: " ^ Bool.toString(t1) ^ "\n" ^
	      "test2: " ^ Bool.toString(t2) ^ "\n" ^
		  "test3: " ^ Bool.toString(t3) ^ "\n" ^		  
	      "\n----------------\n")
	end 
val _ = listDiffTest()

(*Problem 3*)
fun firstNTest() =
	let 
		val t1 = ((firstN ["3","5","5","-","4","5","1"] 3) = ["3","5","5"]);
		val t2 = ((firstN [1,2,3,4,5] 2) = [1,2]);
		val t3 = ((firstN [true, false, false, false, true, true, true]  4) = [true,false,false,false]);
		val t4 = ((firstN [[1,2,3],[4,5],[6],[],[7,8],[]] 4) = [[1,2,3],[4,5],[6],[]]);
		val t5 = ((firstN [] 5) = []);
		val t6 = ((firstN [1,2,3,4,5,6,7] 10) = [1,2,3,4,5,6,7]);
	in
		  print ("firstNTest:-------------------- \n" ^
          "test1: " ^ Bool.toString(t1) ^ "\n" ^
	      "test2: " ^ Bool.toString(t2) ^ "\n" ^
	      "test3: " ^ Bool.toString(t3) ^ "\n" ^
	      "test4: " ^ Bool.toString(t4) ^ "\n" ^
	      "test5: " ^ Bool.toString(t5) ^ "\n" ^
		  "test6: " ^ Bool.toString(t6) ^
	      "\n----------------\n")
	end 
val _ = firstNTest ()


(*Problem 4*)
fun busFinderTest () =
let    
  val buses = 
	[("Lentil",["Chinook", "Orchard", "Valley", "Emerald","Providence", "Stadium", "Main", "Arbor", "Sunnyside", "Fountain", "Crestview", "Wheatland", "Walmart", "Bishop", "Derby", "Dilke"]), 
	("Wheat",["Chinook", "Orchard", "Valley", "Maple","Aspen", "TerreView", "Clay", "Dismores", "Martin", "Bishop", "Walmart", "PorchLight", "Campus"]), 
	("Silver",["TransferStation", "PorchLight", "Stadium", "Bishop","Walmart", "Shopco", "RockeyWay"]),
	("Blue",["TransferStation", "State", "Larry", "TerreView","Grand", "TacoBell", "Chinook", "Library"]),
	("Gray",["TransferStation", "Wawawai", "Main", "Sunnyside","Crestview", "CityHall", "Stadium", "Colorado"])]
     
  val busFinderT1 = ((busFinder "Walmart" buses = ["Lentil","Wheat","Silver"]));
  val busFinderT2 = ((busFinder "Shopco" buses) = ["Silver"]);
  val busFinderT3 = ((busFinder "Chinook" buses) = ["Lentil","Wheat", "Blue"]);
  val busFinderT4 = ((busFinder "Main" buses) = ["Lentil","Gray"]);
  val busFinderT5 = ((busFinder "Sunnyside" buses) = ["Lentil","Gray"]);
  val busFinderT6 = ((busFinder "Stadium" buses) = ["Lentil","Silver","Gray"]);
  val busFinderT7 = ((busFinder "SomethingNotExisting" buses) = []);

 in 
     print ("busFinder:-------------------- \n"   ^ 
            "   test1: " ^ Bool.toString(busFinderT1) ^ "\n" ^ 
            "   test2: " ^ Bool.toString(busFinderT2) ^ "\n" ^  
            "   test3: " ^ Bool.toString(busFinderT3) ^ "\n" ^
			"   test4: " ^ Bool.toString(busFinderT4) ^ "\n" ^	
			"   test5: " ^ Bool.toString(busFinderT5) ^ "\n" ^
			"   test6: " ^ Bool.toString(busFinderT6) ^ "\n" ^
			"   test7: " ^ Bool.toString(busFinderT7) ^ "\n")
				
end
val _ = busFinderTest ()

(*problem 5*)
fun parallelResistorsTest() =
	let 
		val t1 = Real.==((parallelResistors [10.0, 10.0, 10.0, 10.0]), (2.5))
		val t2 = Real.==((parallelResistors [8.0, 16.0, 4.0, 16.0]),(2.0))
		val t3 = Real.==((parallelResistors [5.0, 10.0, 2.0]),(1.25))
		val t4 = Real.==((parallelResistors [0.0]),(0.0))
		val t5 = Real.==((parallelResistors [10.0, 20.0, 30.0, 40.0]),(4.8))
		val t6 = Real.==((parallelResistors [10.00, 10.00, 10.00, 10.00]),2.5)
	in
		  print ("parallelResistorsTest:-------------------- \n" ^
          "test1: " ^ Bool.toString(t1) ^ "\n" ^
	      "test2: " ^ Bool.toString(t2) ^ "\n" ^
	      "test3: " ^ Bool.toString(t3) ^ "\n" ^
	      "test4: " ^ Bool.toString(t4) ^ "\n" ^
	      "test5: " ^ Bool.toString(t5) ^ "\n" ^
		  "test6: " ^ Bool.toString(t6) ^
	      "\n----------------\n")
	end 
val _ = parallelResistorsTest ()

(*Problem 6 tested*)

fun pairNTest () =
	let 
		val t1 = pairNleft(2,[1,2,3,4,5]) = [[1], [2,3], [4,5]]
		val t2 = pairNright (2,[1, 2, 3, 4, 5]) = [[1, 2], [3, 4], [5]]
		val t3= pairNleft (3, [1, 2, 3, 4, 5]) = [[1, 2], [3, 4, 5]]
		val t4= pairNright (3, []) = [[]]
		val t5 = pairNleft (4, [1,2,3,4,5]) = [[1], [2,3,4,5]]
		val t6 = pairNright(3,[1,2,3,4,5]) = [[1,2,3], [4,5]]
		
	in 
		 print ("pairNTest:-------------------- \n" ^
          "test1: " ^ Bool.toString(t1) ^ "\n" ^
	      "test2: " ^ Bool.toString(t2) ^ "\n" ^
	      "test3: " ^ Bool.toString(t3) ^ "\n" ^
	      "test4: " ^ Bool.toString(t4) ^ "\n" ^
	      "test5: " ^ Bool.toString(t5) ^ "\n" ^
		  "test6: " ^ Bool.toString(t6) ^
	      "\n----------------\n")
	end 
val _ = pairNTest ()



	
	
	