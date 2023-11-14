# StatefulWidget

<br>
<br>

### Wiget
- Widget은 모두 "불변"의 법칙을 갖고있다.
- 하지만 위젯의 값을 변경할때가 있다. (색변경등)
- 변경이 필요하면 기존 위젯을 삭제해버리고 완전 새로운 위젯으로 대체한다.

<br>
<br>


## StatelessWidget 라이프 사이클
- Constructor()로 생성되고 생성 되자마자 build() 함수가 실행된다.
- 이전 Container 예제와 마찬가지로 변경이 필요하면 새로운 위젯을 만들어버린다.
- 하나의 StatelessWidget은 라이프 사이클동안 단 한번만 build() 함수를 실행한다.


<br>
<br>

##### StatelessWidget -> 생명주기 중 딱 한번 생성 되었을때만 build 실행.
##### StatefulWidget -> StatelessWidget와 다르게 생명주기 중 build가 재실행 함.


<br>
<br>

## SatefulWidget의 기본적인 라이프 사이클
1. Constructor()가 실행된다.
2. Constructor() 생성 되자마자 createState() 함수가 실행된다.
3. State에 initState() 함수가 실행된다.
4. didChangeDependencies() 함수가 실행된다.
5. 상태가 dirty(더러움) 상태로 변경된다.
6. 상태가 지정이 되면 build() 함수가 호출된다.
7. build가 호출되면 상태가 clean(깨끗함) 상태로 변경된다.
8. State 삭제시 deactivate() 함수가 호출된다.
8-2. (삭제가 아닌 다른 작업시) didUpdateWidget() 혹은 setState() 함수가 호출될수 있음.
9. dispose()가 호출된다.



<br>
<br>

## 파라미터가 바뀌었을때 SatefulWidget의 라이프 사이클
1. Constructor()가 실행된다.
2. 기존에 있던 State 객체를 찾는다.
3. didUpdateWidget()가 실행된다. (이때 상태값은 clean이어야함 / clean이 아니면 각종 오류 발생)
4. 상태가 dirty 상태로 변경된다.
5. build()가 실행된다.
6. 상태가 다시 clean으로 변경된다.


<br>

Widget의 불변의 법칙 때문에 값 변경이 필요할때 기존위젯을 삭제하고 새로운 위젯이 생성되지만 기존에 있던 State를 찾아서 그 State의 값으로 코드가 계속 실행된다.



<br>
<br>


## setState()를 실행했을때 SatefulWidget의 라이프 사이클
1. setState()을 실행한다. (State객체 내부에서 직접 실행 가능 => 이 기능때문에 StatefulWidget을 많이 사용)
2. 상태가 dirty 상태로 변경된다.
3. build()가 실행된다.
4. 상태가 clean 상태로 변경된다.





