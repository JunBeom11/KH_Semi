
# inCorona

코로나19 상황이 지속됨에 따라, 기존 코로나 현황 사이트들의 단점을 개선 및 보완한 웹사이트를 기획함</br>
코로나에 관련된 신뢰성 있는 정보를 한눈에 알아볼 수 있고, 사용자들끼리 소통하고 정보를 공유하는 커뮤니티 기능이 있는 사이트 구축


### 구현 기능
1. **메인 페이지** 
   
   - 상단 메뉴 : 메인, 뉴스, 주변 병원/선별진료소, 정보공유게시판, 로그인/로그아웃, 마이페이지
   
   - 확진자 현황, 지역별 거리두기 단계 현황
![](https://i.imgur.com/IUWmbB2.png)
   
   
   
2. **뉴스 페이지**

   - 관리자만 등록/수정/삭제 가능 
   
   ![](https://i.imgur.com/CNfdY0z.png)

   ![](https://i.imgur.com/amzNEdk.png)

   ![](https://i.imgur.com/7tRmZGD.png)


3. **병원/선별 진료소 페이지**
   - 하단에 지도와 함께 표시
   ![](https://i.imgur.com/NTGbH4s.png)


​     

4. **정보공유게시판 페이지**
   - 지역별로 말머리 기능
   ![](https://i.imgur.com/Ct2zoKv.png)


​     

5. **회원가입/로그인**
   
   - 아이디, 비밀번호 입력
   - 계정이 없을 경우 회원가입(아이디, 비밀번호, 생년월일, 지역, 닉네임 정보 받기)
   - 본인인증 후 아이디 찾기, 비밀번호 재설정
![](https://i.imgur.com/6ir25ok.png)
   
![](https://i.imgur.com/Qaqe6HG.png)
   
![](https://i.imgur.com/HiBiPIz.png)
   
  
   
6. **마이 페이지**
   
   - 정보변경 : 아이디 외 변경 가능, 탈퇴
   - 본인이 작성한 글/댓글 삭제 가능
   - 관리자일 경우 모든 글/댓글 삭제 가능	
![](https://i.imgur.com/gFyiQE3.png)
   
![](https://i.imgur.com/LJq4mSN.png)
   
   ![](https://i.imgur.com/bfc7avT.png)

### 설계 주안점
1. 사용자 편의성을 고려한 UI/UX 설계
2. 모바일 환경에서도 가독성을 높일 수 있는 반응형 웹사이트 제작
3. 간편 회원가입을 통한 접근성 증가
4. 관련 뉴스 및 정보 제공
5. 게시판을 활용한 사용자 간 실시간 정보공유
6. 사용자가 선택한 지역의 인근 병원/선별진료소를 효율적으로 안내



### 역할
- 김희주 : 메인페이지/ 내 글, 댓글 관리, (마이페이지)비밀번호 재확인
- 박진영 : 마이페이지/개인정보 수정
- 손현종 : 로그인/회원가입/아이디찾기/비밀번호 재설정/로그아웃
- 이준범 : 병원/선별진료소
- 최은교 : 뉴스게시판/정보공유게시판



### 사용기술 및 개발환경
- 운영체제 : Windows OS
- DBMS : Oracle
- Languages : Java, Javascript, jsp, css, sql
- API : KakaoMap API, 보건복지부_코로나19 감염_현황 공공 API
- Server : Apache Tomcat v9.0
- Tool : Git, sqldeveloper
- Framework : BootStrap
- Library : jstl, jdbc, lombok, standard, cos, jQuery, tui-chart
- 포트번호 : 8089
