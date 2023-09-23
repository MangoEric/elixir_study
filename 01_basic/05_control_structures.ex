# if 와 unless

# Elixir에서는 nil과 부울 값 false만이 거짓으로 간주됨을 유의하십시오.
if String.valid?("Hello") do
  "Valid string!"
else
  "Invalid string."
end # "Valid string!"

if "a string value" do
  "Truthy"
end # "Truthy"

# unless
# 법은 if/2와 같지만 정반대로 동작

unless is_integer("hello") do
  "Not an Int"
end # "Not an Int"


# case
# 여러 패턴에 대해 매치해야 한다면 case/2를 이용

case {:ok, "Hello World"} do
  {:ok, result} -> result
  {:error} -> "Uh oh!"
  _ -> "Catch all"
end # "Hello World"

# _ 변수는 case/2 구문에서 중요한 요소입니다.
# _ 없으면 일치하는 패턴을 찾지 못했을 때 오류가 발생
# _를 “그 외의 모든 것”에 매치되는 else처럼 생각

case :even do
  :odd -> "Odd"
end # error

case :even do
  :odd -> "Odd"
  _ -> "Not Odd"
end # "Not Odd"

# ase/2는 패턴 매칭에 의존하기 때문에 같은 규칙과 제약이 모두 적용됩니다.
# 기존의 변수에 매치하고자 한다면 핀 연산자 ^/1를 사용해야 합니다.
pie = 3.14

case "cherry pie" do
  ^pie -> "Not so tasty"
  pie -> "I bet #{pie} is tasty"
end # "I bet cherry pie is tasty"


# case/2의 또다른 멋진 점은 가드 구문을 지원한다는 것입니다.
case {1, 2, 3} do
  {1, x, 3} when x > 0 ->
    "Will match"
  _ ->
    "Won't match"
end # "Will match"


# cond
# 값이 아닌 조건식에 매치해야 할 때에는 cond/1를 사용하면 됩니다.
# 이는 다른 언어의 else if나 elseif와 유사합니다.
cond do
  2 + 2 == 5 ->
    "This will not be true"
  2 * 2 == 3 ->
    "Nor this"
  1 + 1 == 2 ->
    "But this will"
end # "But this will"

# case/2와 마찬가지로, cond/1도 일치하는 조건식이 없을 경우 에러를 발생시킵니다.
# 이를 해결하려면 true 조건식을 정의합니다.

ond do
  7 + 1 == 0 -> "Incorrect"
  true -> "Catch all"
end # "Catch all"


# with

# 특별한 구문인 with/1는 중첩된 case/2 구문이 쓰일만한 곳이나 깔끔하게 파이프 연산을 할 수 없는 상황에서 유용합니다.
# with/1식은 키워드, 제너레이터, 그리고 식으로 구성되어 있습니다.

user = %{first: "Sean", last: "Callan"}

with {:ok, first} <- Map.fetch(user, :first),
     {:ok, last} <- Map.fetch(user, :last),
     do: last <> ", " <> first #"Callan, Sean"

# 식의 매치가 실패하는 경우에는 매치되지 않은 값이 반환됩니다
user = %{first: "doomspork"}

with {:ok, first} <- Map.fetch(user, :first),
     {:ok, last} <- Map.fetch(user, :last),
     do: last <> ", " <> first # :error


# case 문을 with문으로 리펙토링 해보자.
case Repo.insert(changeset) do
  {:ok, user} ->
    case Guardian.encode_and_sign(user, :token, claims) do
      {:ok, token, full_claims} ->
        important_stuff(token, full_claims)

      error ->
        error
    end

  error ->
    error
end

# 해당 case문을 with문으로 리펙토링 하면, 보다 간결하게 표현할 수 있다.
with {:ok, user} <- Repo.insert(changeset),
     {:ok, token, full_claims} <- Guardian.encode_and_sign(user, :token, claims) do
  important_stuff(token, full_claims)
end

# with/1구문에서 else를 사용할 수 있습니다.

import Integer

m = %{a: 1, c: 3}

a =
  with {:ok, res} <- Map.fetch(m, :a),
       true <- is_even(res) do
    IO.puts("Divided by 2 it is #{div(res, 2)}")
    :even
  else
    :error ->
      IO.puts("We don't have this item in map")
      :error

    _ ->
      IO.puts("It's odd")
      :odd
  end
# 이는 오류를 처리할 때 case같은 패턴매칭을 사용할 수 있도록 도와줍니다.
# 넘겨지는 값은 첫 번째 매치하지 않은 표현식입니다
