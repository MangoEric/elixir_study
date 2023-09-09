# 정수
222

# 실수
3.14

# Boolean
true
false

# atom - 값이 되는 상수
:foo
:bar

# String
"hello"

# 수치 연산
2+2
div(10, 5)

# 논리 연산

# 연산자로 ||와 &&, !를 타입에 관계없이 사용할 수 있습니다.
-20 || true

!42

# 반면 and, or, not은 반드시 첫번째 인자가 부울 값(true나 false)이어야 합니다.
true and 42

42 and true

# 비교연산
# ==, !=, ===, !==, <=, >=, <, > 같은 다른 언어에서도 익숙했던 비교 연산자를 Elixir에서도 사용할 수 있습니다.
1 > 2

2 <= 3

#

# 숫자 < 애텀 < 참조 < 함수 < 포트 < pid < 튜플 < 맵 < 리스트 < 비트스트링

#
:hello > 999
{:hello, :world} > [1, 2, 3]


# 문자 내부식 전개
name = "MangoEric"
"Hello #{name}"


# 문자열 합치기
name = "MangoEric"
"Hello" <> name
