# Compiler & Processor
## Obligatory things TODO:
* if/else
* while
* functions
* arithmetic expressions
* basic errors

## Optional things TODO:
* errors in depth
* embedded fonctions
* types
* pointers
* structs
* tables
* preprocessor
* just in time compilator

## 16.4. ->
* prochain fois, on va continuer avec processeur - doit finir les trucs de compilateur avant la prochaine séance

# 14.5.

* fonctions !
* bonus: ptr, ternaires

## Processeur

* instructions -> recuperer valeurs dans les registres -> pipeline "reg" -> ALU -> pipeline -> memoire
* conditions -> pause
* chemin critique pour ameliorer la vitesse

### Pipeline

p_in: 5 entrees de 16 bits
p_out: 5 sorties de 16 bits


begin
	process(clk)
	begin
		if(clk='1') then
			p_out <= p_in;
		end if;
	end;
end;

### ALU
A,B,op,S,flag

signal 	R 16b
				Rmul 32b
				Radd 17b

begin
	Rmul <= A*B;
	R <= 	Radd(15 dto 0) 	when op=x"00" else
				A-B 						when op=x"01"...
				Rmul(15 dto 0) 	...
	f2 <= '1' when R=x"0000" else
	S <= R;
	Radd <=('0'&A)+('0'&B);
end;




end;


