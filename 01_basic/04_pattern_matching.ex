# Pattern Matching

# Match Operator

# Elixir에서 =는 사실 대수에서 등호와 같은 역할을 하는 매치 연산자입니다.
# 이것을 쓰면 전체 표현식이 방정식으로 바뀌고 Elixir가 왼쪽의 값과 오른쪽의 값을 매치시킵니다.
# 매치가 성공하면 방정식의 값을 반환하고, 그렇지 않을 경우 에러를 발생시킵니다
x = 1
1 = x

2 = x # error

list = [1, 2, 3]
[1, 2, 3] = list

[] = list # error

[1 | tail] = list # [1, 2, 3]
tail # [2,3]

[2 | _] = list # error


{:ok, value} = {:ok, "Successful!"}

value # "Successful!"

{:ok, value} = {:error} # error


# Pin Operator

# 매치 연산자의 좌변에 변수가 포함되어 있을 때에는 값의 대입이 일어납니다.
# 하지만 경우에 따라서는, 변수에 새로운 값이 대입되는 것을 원치 않을 수도 있습니다.
# 이러한 상황에서는 핀 연산자 ^를 사용해야 합니다.


# 핀 연산자를 이용하여 변수를 고정시키면 변수에 새 값을 대입하지 않고 기존의 값과 매칭을 하게 됩니다
x = 1 # 1
^x = 2 # error

{x, ^x} = {2, 1} # {2, 1}
x # 2

# Elixir 1.2에서는 맵의 키와 함수의 절에 대한 핀이 도입되었습니다.
key = "hello" # "hello"
%{^key => value} = %{"hello" => "world"} # %{"hello" => "world"}
value # "wolrd"
%{^key => value} = %{:hello => "world"} # error


greeting = "Hello" # "Hello"

greet = fn
  (^greeting, name) -> "Hi #{name}"
  (greeting, name) -> "#{greeting}, #{name}"
end

# "Mornin" 예시에서 greeting 변수에 "Mornin"을 재할당하는 것은 오직
# 함수 내부에서만 발생한다는 점에 주목하세요.
# 함수 바깥에 있는 greeting 변수는 여전히 "Hello"입니다.

greet.("Hello", "Sean") # "Hi Sean"
greet.("Mornin'", "Sean") # "Mornin', Sean"
greeting # "Hello"
