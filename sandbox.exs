list_concat = 
  fn (list1, list2) ->
  	list1 ++ list2
  end

answer = list_concat.(['a','b','c'], ['d','e','f'])

IO.puts answer

sum = 
  fn (x, y, z) ->
  	x + y + z
  end

answer = sum.(1,2,3)

IO.puts answer

pair_tuple_to_list = 
  fn (tuple) ->
  	Tuple.to_list(tuple)
  end

IO.puts pair_tuple_to_list.({99,101,3})

System.halt(0)