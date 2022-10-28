# STUDY_BOARD

## 게시판 만들기(새로 만들어보기)

### 무엇을 했는지
- 개발 기간 : 2022.09.15 ~ 2022.09.30

- 목적 : 개인 공부.
  - 더 깔끔하고 보기 좋은 코드 구현.
  - post/get mapping 말고 request mapping 사용
  - jsp>controller>service>DAO>mapper 구성
  - map 사용해보기.
  - CRUD 복습.
  - JQUERY 활용.
  - ajax 비동기 페이지 만들어보기.

- 개발 환경 및 사용 기술
  - JDK 1.8
  - Eclipse, Spring Framework, Apache Tomcat 9.0
  - MyBatis,JQuery
  - ORACLE 11XE, SQL DEVELOPER
  - Lombok, LOG4J, Maven, ajax

- 구현 내용
  - 게시판 리스트 페이지. map에 데이터 담아서 가져오기.
  - 글 등록/수정(상세보기) 모두 같은 jsp로 연결. 데이터 유무에 따라 화면이 달라지게 구현.
  - 검색 기능 추가. 서브쿼리와 동적sql, sql 조각 등 적용.
  - 페이징 기능(VO를 따로 만들어서 적용함.) 페이지 전환은 비동기로. 검색 값 사라지지 않도록 적용!
  - 파일 업로드+다운로드 구현. 여러 파일이 있을 시 하나씩 업로드 되도록 구현.
