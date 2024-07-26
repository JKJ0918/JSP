package model1.board;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class BoardDAO extends JDBConnect{
	
	//생성자를 이용해서 1단계/2단계 처리
	public BoardDAO(ServletContext application) {
		super(application); // 3번째 개선한 jdbc 연결
	}
	
	//board 테이블에 게시물 갯수를 알아와야 함
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0; // 리턴값
		
		// 3단계 : 쿼리문 작성
		String query = "select count(*) from board ";
		if(map.get("searchWord") != null ) {
			// 검색어가 있으면
			query += "where " + map.get("searchField") + " like '%" + map.get("searchWord") + "%'";
			// searchField : 제목, 내용, 작성자
			// searchWord : input text로 넘어온 글자
			// select count(*) from board where 제목 like '%딸기%' ;
			// *참고 searchField : String / Object(최상위객체) :  제목, 내용, 작성자		
		}// 검색어가 있으면 조건이 추가된다.
		
		
		// 4단계 : 쿼리문 실행
		
		try {
			statement = connection.createStatement(); // 쿼리문 연결
			resultSet = statement.executeQuery(query); // 쿼리문 실행하여 결과를 표로 받음
			resultSet.next(); // 
			totalCount = resultSet.getInt(1); // 첫번째 컬럼 값을 가져옴
			System.out.println("totalCount :" + totalCount);
		} catch (SQLException e) {
			System.out.println("BoardDAO.selectCount() 메서드 오류");
			System.out.println("게시물 개수를 구하는 오류 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	// 게시물의 리스트를 출력
	public List<BoardDTO> selectList(Map<String, Object> map){
		List<BoardDTO> listBoardDTO = new Vector<BoardDTO>();
		
		// 3단계
		String query = "select * from board";
		// 조건 추가
		if(map.get("searchWord") != null ) {
			// 검색어가 있으면
			query += "where " + map.get("searchField") + " like '%" + map.get("searchWord") + "%'";
			// searchField : 제목, 내용, 작성자
			// searchWord : input text로 넘어온 글자
			// select count(*) from board where 제목 like '%딸기%' ;
			// *참고 searchField : String / Object(최상위객체) :  제목, 내용, 작성자		
		}// 검색어가 있으면 조건이 추가된다.
		
		query += " order by num desc"; // 정렬 기준 추가
		// 3단계 쿼리문 완성
		
		// 4단계 쿼리문 실행
		//*preparedstatement는 무겁다
		try {
			statement = connection.createStatement(); // 쿼리문 생성
			resultSet = statement.executeQuery(query); // 쿼리문 실행 후 결과 표 완성
			
			while (resultSet.next()) {
				BoardDTO boardDTO = new BoardDTO(); // 빈 객체 생성
				
				boardDTO.setNum(resultSet.getString("num"));
				boardDTO.setId(resultSet.getString("id"));
				boardDTO.setTitle(resultSet.getString("title"));
				boardDTO.setContent(resultSet.getString("content"));
				boardDTO.setPostdate(resultSet.getDate("postdate"));
				boardDTO.setVisitcount(resultSet.getString("visitcount")); // 객체의 값 삽입완료
				//name 필드 null
				
				listBoardDTO.add(boardDTO); // 위에서 만든 객체를 리스트에 넣음
				
			} // while문 종료
		} catch (SQLException e) {
			System.out.println("BoardDAO.selectList() 메서드 오류");
			System.out.println("board테이블 모든리스트 오류");
			e.printStackTrace();
		}
		
		return listBoardDTO;
	}
	
	//게시글 등록용 메서드
	public int insertWrite(BoardDTO dto) {
		int result = 0;
		
		// 3단계
		
		String query = "insert into board (num, title, content, id, visitcount) "
				+ "values( seq_board_num.nextval, ?, ?, ?, 0)";
		
		try {
			preparedStatement = connection.prepareStatement(query); // 쿼리문 연결
			preparedStatement.setString(1, dto.getTitle());
			preparedStatement.setString(2, dto.getContent());
			preparedStatement.setString(3, dto.getId()); // 쿼리문 완성 (인파라미터)
			
			result = preparedStatement.executeUpdate();
		} catch (SQLException e) {
			System.out.println("BoardDAO.insertWrite() 메서드 예외발생");
			System.out.println("쿼리문을 확인하세요.");
			e.printStackTrace();
		}
		
		return result;
	}
	
}
