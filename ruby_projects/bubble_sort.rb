def bubble_sort(list)
  bubble_sort_by(list) do |left, right|
    right - left
  end
  return list
end


def bubble_sort_by(list)
 for i in 0..list.length() - 1
  for j in 0..list.length() - 2
    if (yield(list[j], list[j + 1]) < 0)
      t = list[j + 1]
      list[j + 1] = list[j]
      list[j] = t
    end
  end
 end
 list
end 

sorted1 = bubble_sort([4,3,78,2,0,2])
p sorted1
sorted2 = bubble_sort_by(["hi", "hello", "hey"]) do |left, right|
  right.length - left.length
end
p sorted2
