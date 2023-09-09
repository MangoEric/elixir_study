# list

# 리스트(list)는 값들의 간단한 컬렉션입니다. 리스트는 여러 타입을 포함할 수 있으며 중복된 값들도 포함할 수 있습니다.
[3.14, :pie, "Apple"]

# Elixir는 연결 리스트로서 리스트 컬렉션을 구현, 리스트의 길이를 구하는 것은 선형의 시간O(n)이 걸리며,
# 이러한 이유로 리스트의 앞에 값을 추가하는 것이 뒤에 추가하는 것보다 보통 빠릅니다.

list = [3.14, :pie, "Apple"]
[3.14, :pie, "Apple"]

# 앞에 추가(빠름)
["π" | list]

# 뒤에 추가(느림)
list ++ ["Cherry"]

# 리스트 이어붙이기
# 리스트는 ++/2 연산자를 이용해서 서로 이어붙일 수 있습니다.
[1, 2] ++ [3, 4, 1]

# 리스트 뺴기
# --/2 연산자를 이용하면 리스트에 대한 뺄셈 연산이 가능합니다. 존재하지 않는 값은 빼도 안전합니다.
["foo", :bar, 42] -- [42, "bar"]


# Head / Tail
hd [3.14, :pie, "Apple"]
tl [3.14, :pie, "Apple"]


# Tuples

# 튜플(tuples)은 리스트와 비슷하지만 메모리에 연속적으로 저장됩니다.
# 이 때문에 튜플의 길이를 구하는 것은 빠르지만 수정하는 것은 비용이 비쌉니다.
# 새로운 튜플이 통째로 메모리에 복사되어야 하기 때문이지요. 튜플은 중괄호를 사용해서 정의합니다.

{3.14, :pie, "Apple"}
File.read("/Users/jy/Documents/GitHub/elixir_study/01_basic/02_collection.ex")


# 키워드 리스트

# 1. 모든 키는 애텀입니다.
# 2. 키는 정렬되어 있습니다.
# 3. 키는 유일하지 않아도 됩니다.
[foo: "bar", hello: "world"]
[{:foo, "bar"}, {:hello, "world"}]


# Map

# Elixir에서 맵(maps)은 매우 유용한 키-값 저장소입니다.
# 키워드 리스트와는 다르게 맵의 키는 어떤 타입이든 될 수 있고 순서를 따르지 않습니다.
# 맵은 %{} 문법을 이용해서 정의할 수 있습니다.
map = %{:foo => "bar", "hello" => :world}

map[:foo]
map["hello"]

# 변수를 Map의 key로 사용할 수 있다.
key = "hello"
%{key => "world"}

# 중복된 키가 맵에 추가되면 이전의 값을 새 값으로 교체합니다.
%{:foo => "bar", :foo => "hello world"}

# 모든 키가 애텀인 맵을 정의하기 위한 특별한 문법도 존재합니다.
%{foo: "bar", hello: "world"}
%{foo: "bar", hello: "world"} == %{:foo => "bar", :hello => "world"} # true

# 애텀 키에 접근하기 위한 특별한 문법
map = %{foo: "bar", hello: "world"}
map.hello

# 맵의 또 다른 흥미로운 특성은 맵의 업데이트를 위하여 고유한 구문을 제공한다는 것입니다(참고: 이것은 새로운 맵을 만듭니다):
map = %{foo: "bar", hello: "world"}
%{map | foo: "baz"}

# 새로운 키를 만드려면 Map.put/3을 사용
map = %{hello: "world"}
%{map | foo: "baz"} # error
Map.put(map, :foo, "baz")
