package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBConnect {
	//데이터베이스와 자바를 연결하는 객체 클래스
	// 1단계 : 드라이버 
	// 2단계 : url, id, pw
	// 3단계 : 쿼리생성  -> dao
	// 4단계 : 쿼리실행 결과 출력 ->dao
	// 5단계 : close();
	
	//필드
	public Connection connection; // 연결자
	public Statement statement; // 정적쿼리문(모든리스트 출력)
	public PreparedStatement preparedStatement; // 동적쿼리문 (?로 인파라미터 처리)
	public ResultSet resultSet; // select의 결과를 표로 출력
	
	//생성자
	public JDBConnect() {
		try {
			Class.forName("oracle.jdbc.OracleDriver"); // 1단계
			System.out.println("JDBConnect 생성자 1단계 성공");
			String url = "jdbc:oracle:thin:@192.168.111.101:1521:xe";
			String id = "boardjsp";
			String pw = "1234";
			connection = DriverManager.getConnection(url, id, pw);
			System.out.println("JDBConnect 생성자 2단계 성공");
		} catch (Exception e) {
			System.out.println("1단계, 2단계, 3단계를 확인하세요");
			e.printStackTrace();
		}
	}
	
	//메서드
	public void close() {
		try {
			if(resultSet != null) resultSet.close();
			if(preparedStatement != null) preparedStatement.close();
			if(statement != null) statement.close();
			if(connection != null) connection.close();
			System.out.println("JDBConnect 생성자 5단계 성공");
		} catch (SQLException e) {
			System.out.println("정상으로 close() 되지 않았습니다.");
			System.exit(0); // 강제종료
			e.printStackTrace();
		}
	}
	
	
	
}
