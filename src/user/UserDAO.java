package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import detail.Detail;

public class UserDAO {

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/projectDB";
			String dbID = "root";
			String dbPassword = "mysql";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
			// 여기까지가 mysql에 접속 할 수 있게 해주는 부분
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 로그인을 시도하는 하나의 함수
	public int login(String userID, String userPassword) {
		
		String SQL = "SELECT userPassword FROM userDB WHERE userID =?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인성공
				}else {
					return 0; // 비밀번호 불일치
				}
			}
			return -1; // 아이디가 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터베이스 오류
	}
	
	public int join(String userID, String userPassword, String userName, String userGender, String userEmail, String userMap, String userPhNum) {
		String SQL = "INSERT INTO userDB VALUES (?,?,?,?,?,?,?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setString(4, userGender);
			pstmt.setString(5, userEmail);
			pstmt.setString(6, userMap);
			pstmt.setString(7, userPhNum);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류 이 경우는 id가 중복된 경우밖에 없다 왜냐하면 primarykey기 때문이지
	}
	
	public int update(String userPassword, String userEmail, String userMap, String userPhNum, String userID) {
		String SQL = "UPDATE userDB SET userPassword =?, userEmail=?, userMap=?, userPhNum=? WHERE userID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, userMap);
			pstmt.setString(4, userPhNum);
			pstmt.setString(5, userID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
	
	public ArrayList<User> getList(){
		String SQL = "SELECT * FROM userDB"; 
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserMap(rs.getString(6));
				user.setUserPhNum(rs.getString(7));
				list.add(user);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스 오류
	}
}
