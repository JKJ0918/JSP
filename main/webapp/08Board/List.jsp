<%@page import="utils.BoardPage"%>
<%@page import="model1.board.BoardDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="model1.board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	BoardDAO boardDAO = new BoardDAO(application); // 1단계, 2단계	
	// 검색조건에 대한 변수 선언 -> Map<String, Object>
	Map<String, Object> param = new HashMap<String, Object>();
	String searchField = request.getParameter("searchField");
	String searchWord = request.getParameter("searchWord");
	if(searchWord != null){ // 검색어가 있으면
		param.put("searchField", searchField);
		param.put("searchWord", searchWord);
	}
	//1 단계
	int totalCount = boardDAO.selectCount(param); // 검색 조건을 파라미터로 dao로 넘어가고 게시물 수를 int로 받음
	// 전체 페이지 수 계산
	int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
	// 현재 페이지에 보여줄 리스트 개수 10
	int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
	// 한 화면에 보여줄 블럭 수 5
	int totalPage = (int)Math.ceil((double)totalCount / pageSize );
	// 총 페이지수 = 11   <-올림 <-  10.5  <-  105    /    10    // 3단계
	
	// 현재 페이지용 코드
	int pageNum = 1 ; // 무조건 처음 페이지는 1
	String pageTemp = request.getParameter("pageNum"); // List.jsp?pageNum=1
	if(pageTemp != null && !pageTemp.equals("")){ // url 로 넘어온 값이 있으면 
		pageNum = Integer.parseInt(pageTemp); // 요청받은 페이지로 적용
	}
	
	// 목록에 출력할 게시물 범위 계산 2단계
	int start = (pageNum - 1) * pageSize + 1; // 첫 게시물 번호 (11)
	// 11 = (2 - 1) -> 1 * 10 + 1 -> 11
	int end = pageNum * pageSize ; // 마지막 게시물 번호 (20)
	// 20 = 2 * 10
	param.put("start", start); // map을 통해 검색 조건과 같은 타입으로 전달
	param.put("end", end); // map을 통해 검색 조건과 같은 타입으로 전달
	
	//param -> searchField, searchWord, start, end 가 전달된다.
	
	List<BoardDTO> boardLists = boardDAO.selectList(param); // 검색조건을 파라미터로 dao로 넘어가고 결과는 list로 받음
	boardDAO.close(); // 5단계 종료

%>
<!DOCTYPE html><html><head><meta charset="UTF-8">
<title>List.jsp : BoardDTO, BoardDAO활용한 리스트 출력 + 검색</title></head>
<body>
	<jsp:include page="../Common/Link.jsp" /> <!-- 상단메뉴용(반복) -->
	<!-- 검색폼 -->
	
	<h2 align="center">회원제 게시판 - 목록보기(list.jsp)</h2>
	
	<form method="get">
		<table border="1" width="90%">
			<tr> <!-- 1줄 -->
				<td align="center"> <!-- 1칸 : 가운데 정렬-->
					<select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="id">아이디</option>					
					</select> <!-- 검색필드 설정 -->
					
					<input type="text" name="searchWord" /> <!-- 검색단어 -->
					<input type="submit" value="검색하기" /> <!-- 버튼 -->
				</td>
			</tr>
		</table>
	</form>
	<!-- boardlist method 활용 -->
	<table border="1" width="90%">
		<tr> <!-- 제목 1줄 -->
			<th width="10%">번호</th>
			<th width="50%">제목</th>
			<th width="15%">작성자</th>
			<th width="10%">조회수</th>
			<th width="15%">작성일</th>
		</tr> <!-- 제목행 끝 -->
	<!-- 목록 -->
	<%
		if(boardLists.isEmpty()){ //dao에서 리스트로 나온 값이 비었을 때
	%>
		<tr>
			<td colspan="5" align="center"> 등록된 게시물이 없습니다.</td>
		</tr>
	<%
		} else { // 등록된 게시물이 있다.
			
			int virtualNum = 0 ; // 화면 출력용 번호
			
			int countNum = 0; //페이징 처리 처리용으로 개선
			
			for (BoardDTO dto : boardLists){ // boardList dao에서 받은 결과 리스트
				
				// virtualNum = totalCount-- ; // 게시물의 총개수 5- 4- 3- 2- 1-
				
				virtualNum = totalCount - (((pageNum - 1) * pageSize) + countNum++ );
				//105          105     - (  (  1   -  1  ) * 10 ) + 1-> 2-> 3-> 4  )
				//104
				//103
	%>
		<tr>
			<td><%= virtualNum %></td>
			<td align="left">
			<a href="View.jsp?num=<%=dto.getNum() %>"> <!-- ?num=2 request.getParameter("num") -->
			<%= dto.getTitle() %>
			</a>
			<td><%= dto.getId() %></td>
			<td><%= dto.getVisitcount() %></td>
			<td><%= dto.getPostdate() %></td>
		</tr>
		<%
			} // for 문 종료
		} // if문 종료
	%>
	
	</table> <!-- 리스트 종료 -->
	<!-- 글쓰기 테이블 -->
	<table border="1" width="90%">
		<tr align="center">
			<td>
				<%= BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, request.getRequestURI()) %>
				<!-- 						105			10		 5		    6	   List.jsp?pageNum=10 -->
				<!-- [첫 페이지] [이전 블록] 6  7  8  9  10 [다음 블록] [마지막 페이지] -->
			</td>
			<td>
				<button type="button" onclick="location.href='Write.jsp';">글쓰기</button>
			</td>
		</tr>
	</table>
	

</body>
</html>