# Common Functions

# all?
# 이 코드의 경우, 문자열 리스트 ["foo", "bar", "hello"]의 각 요소에 대해 String.length(s) == 3 or >1 라는 조건을 검사합니다.
Enum.all?(["foo", "bar", "hello"], fn(s) -> String.length(s) == 3 end) # false
Enum.all?(["foo", "bar", "hello"], fn(s) -> String.length(s) > 1 end) # true

# any?
# true로 평가되는 아이템이 하나라도 있으면 any?/2는 true를 반환할 것입니다.
Enum.any?(["foo", "bar", "hello"], fn(s) -> String.length(s) == 5 end)


# chunk_every
# 컬렉션을 작은 묶음으로 쪼개야 한다면, chunk_every/2가 찾고 있을 그 함수입니다.
Enum.chunk_every([1, 2, 3, 4, 5, 6], 2)

# chunk_by
# 컬렉션을 크기가 아닌 다른 기준에 근거해서 묶을 필요가 있다면, chunk_by/2를 사용할 수 있습니다.
# 열거할 수 있는 컬렉션과 함수를 받아와서, 주어진 함수의 결과값이 변할 때마다 그룹을 새로 시작합니다.
Enum.chunk_by(["one", "two", "three", "four", "five"], fn(x) -> String.length(x) end)
Enum.chunk_by(["one", "two", "three", "four", "five", "six"], fn(x) -> String.length(x) end)


# map_every
# 가끔 컬렉션의 묶음을 뽑아내는 것만으로는 정확히 원하는 것을 얻기 힘들 때가 있습니다.
# map_every/3은 그런 경우에 매우 유용할 수 있습니다. 모든 n번째 아이템을 가져오며, 항상 첫번째 것에도 적용합니다.
Enum.map_every([1, 2, 3, 4, 5, 6, 7, 8], 3, fn x -> x + 1000 end)


# each
# 새로운 값을 만들어내지 않고 컬렉션에 대해 반복하는 건 중요할 수도 있습니다. 이런 경우에는 each/2를 사용합니다.
Enum.each(["one", "two", "three"], fn(s) -> IO.puts(s) end)


# map
# 각 아이템마다 함수를 적용하여 새로운 컬렉션을 만들어내고자 한다면 map/2 함수를 써보세요.
Enum.map([0, 1, 2, 3], fn(x) -> x - 1 end)


# min
# 컬렉션 내의 최소값을 찾습니다.
Enum.min([5, 3, 0, -1])
# 열거할 컬렉션이 비어있는 경우에 반환할 최소값을 익명 함수로 지정할 수 있습니다.
Enum.min([], fn -> :foo end)


# max
# 컬렉션 내의 최대값을 반환합니다.
Enum.max([5, 3, 0, -1])
# 열거할 컬렉션이 비어있는 경우에 반환할 최대값을 익명 함수로 지정할 수 있습니다.
Enum.max([], fn -> :bar end)


# filter
# 주어진 함수를 사용하여 ‘true’로 평가되는 요소만 포함하도록 컬렉션을 필터링합니다
Enum.filter([1, 2, 3, 4], fn(x) -> rem(x, 2) == 0 end)


# reduce
# 컬렉션을 하나의 값으로 추려낼 수 있습니다.
# 이를 이용하려면, 선택사항으로 축적자를(예를 들면 10) 함수에 전달합니다.
# 축적자를 제공하지 않으면, 열거할 목록의 첫 번째 원소가 그 역할을 대신합니다.
Enum.reduce([1, 2, 3], 10, fn(x, acc) -> x + acc end) # 16
Enum.reduce([1, 2, 3], fn(x, acc) -> x + acc end) # 6
Enum.reduce(["a","b","c"], "1", fn(x,acc)-> x <> acc end) # cba1


# sort
# 쉽게 컬렉션들을 정렬할 수 있습니다.
# sort/1은 정렬 순서로 Erlang의 텀(Term) 순서를 사용합니다.
Enum.sort([5, 6, 1, 3, -1, 4])
Enum.sort([:foo, "bar", Enum, -1, 4])
# 직접 정렬 함수를 만들 수 있습니다.
Enum.sort([%{:val => 4}, %{:val => 1}], fn(x, y) -> x[:val] > y[:val] end)
Enum.sort([%{:count => 4}, %{:count => 1}])
# 편의를 위해, sort/2에 정렬 함수 대신 :asc, :desc를 넘길 수 있습니다.
Enum.sort([2, 3, 1], :desc)


# uniq
# 열거 가능한 집합 내의 중복요소를 제거할 수 있습니다.
Enum.uniq([1, 2, 3, 2, 1, 1, 1, 1, 1])


# uniq_by
# 열거 가능한 집합에서 중복을 제거합니다만, 고유한지를 비교할 함수를 넘길 수 있습니다.
Enum.uniq_by([%{x: 1, y: 1}, %{x: 2, y: 1}, %{x: 3, y: 3}], fn coord -> coord.y end)


# Enum에서 캡쳐, 연산자 사용

# 1. 익명함수에서 갭처, 연산자 사용
Enum.map([1,2,3], fn number -> number + 3 end)
# 캡처 연산자(&)로 구현합니다.
# 숫자 리스트([1,2,3])의 각 요소를 캡처하고 매핑 함수를 통해 전달 될 때 변수 &1에 각 요소를 할당합니다
Enum.map([1,2,3], &(&1 + 3))
# 캡처 연산자를 미리 익명 함수를 변수에 할당하고 Enum.map/2 함수에서 호출하게 할 수 있습니다.
plus_three = &(&1 + 3)
Enum.map([1,2,3], plus_three)

# 2. 일반 함수에 캡쳐, 연산자 사용
defmodule Adding do
  def plus_three(number), do: number + 3
end
Enum.map([1,2,3], fn number -> Adding.plus_three(number) end)
# 캡처 연산자를 사용해 리팩터를 해보죠.
Enum.map([1,2,3], &Adding.plus_three(&1))
# 이름이 있는 함수를 직접 호출하면 가장 간결하게 작성할 수 있습니다
Enum.map([1,2,3], &Adding.plus_three/1)
