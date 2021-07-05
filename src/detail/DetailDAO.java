package detail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.Bbs;
import jdk.nashorn.internal.ir.RuntimeNode.Request;

public class DetailDAO {
	private Connection conn;
	private ResultSet rs;
	
	public DetailDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/projectDB";
			String dbID = "root";
			String dbPassword = "mysql";
			Class.forName("com.mysql.jdbc.Driver");
			
			conn = DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNext() { 
		String SQL = "SELECT productCode FROM detail ORDER BY productCode DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; // 다음 게시글에 번호가 들어갈수 있도록 30번째 게시글이면 다음 게시글은 31번째
			}
			return 1; // 첫번째 게시글일 경우에 1을 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 게시글번호에 맞지않은 - 가 나오면서 프로그래머가 오류 발생했다는 것을 알 수가 있음
	}
	
	public int write(String productName, String productInformation, String originalPrice, String salePrice, int boardID) {
		String SQL = "INSERT INTO detail VALUES(?,?,?,?,?,?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, productName);
			pstmt.setString(3, productInformation);
			pstmt.setString(4, originalPrice);
			pstmt.setString(5, salePrice);
			pstmt.setInt(6, boardID);
			pstmt.executeUpdate();
			return getNext();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 게시글번호에 맞지않은 - 가 나오면서 프로그래머가 오류 발생했다는 것을 알 수가 있음
	
	}
	
	// 글 내용을 불러오는 함수
	public Detail getDetail(int productCode) {
		String SQL = "SELECT * FROM detail WHERE productCode = ?";
		/*ArrayList<Bbs> list = new ArrayList<Bbs>();*/
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, productCode);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Detail detail = new Detail();
				detail.setProductCode(rs.getInt(1));
				detail.setProductName(rs.getString(2));
				detail.setProductInformation(rs.getString(3));
				detail.setOriginalPrice(rs.getString(4));
				detail.setSalePrice(rs.getString(5));
				detail.setBoardID(rs.getInt(6));
				return detail;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		}
	
	public ArrayList<Detail> getList(int boardID){
		String SQL = "SELECT * FROM detail WHERE boardID = ? ORDER BY productCode DESC LIMIT 10"; 
		ArrayList<Detail> list = new ArrayList<Detail>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Detail detail = new Detail();
				detail.setProductCode(rs.getInt(1));
				detail.setProductName(rs.getString(2));
				detail.setProductInformation(rs.getString(3));
				detail.setOriginalPrice(rs.getString(4));
				detail.setSalePrice(rs.getString(5));
				detail.setBoardID(rs.getInt(6));
				list.add(detail);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스 오류
	}
	
	public ArrayList<Detail> getList2(int productCode){
		String SQL = "SELECT * FROM detail WHERE productCode = ? "; 
		ArrayList<Detail> list = new ArrayList<Detail>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, productCode);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Detail detail = new Detail();
				detail.setBasketCode(rs.getInt(1));
				detail.setBasketNum(rs.getInt(2));
				detail.setProductName(rs.getString(3));
				list.add(detail);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스 오류
	}
	
	public int getNext1() { 
		String SQL = "SELECT basketCode FROM basket ORDER BY basketCode DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; // 다음 게시글에 번호가 들어갈수 있도록 30번째 게시글이면 다음 게시글은 31번째
			}
			return 1; // 첫번째 게시글일 경우에 1을 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 게시글번호에 맞지않은 - 가 나오면서 프로그래머가 오류 발생했다는 것을 알 수가 있음
	}
	
	public int getNext2() { 
		String SQL = "SELECT basketCode FROM basket ORDER BY basketNum DESC";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1)+1; // 다음 게시글에 번호가 들어갈수 있도록 30번째 게시글이면 다음 게시글은 31번째
			}
			return 0; // 첫번째 게시글일 경우에 1을 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 게시글번호에 맞지않은 - 가 나오면서 프로그래머가 오류 발생했다는 것을 알 수가 있음
	}
	
	public int insert(String userID, int basketNum, String productName, String productInformation, 
			String salePrice, String color, String quantity, String size, int productCode) {
		String SQL = "INSERT INTO basket VALUES(?,?,?,?,?,?,?,?,?,?,?,?)";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, getNext1());
			pstmt.setInt(3, basketNum);
			pstmt.setString(4, productName);
			pstmt.setString(5, productInformation);
			pstmt.setString(6, salePrice);
			pstmt.setString(7, color);
			pstmt.setString(8, quantity);
			pstmt.setString(9, size);
			pstmt.setInt(10, productCode);
			pstmt.setString(11, getDate());
			pstmt.setInt(12, getNext1());
			pstmt.executeUpdate();
			return getNext1();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 게시글번호에 맞지않은 - 가 나오면서 프로그래머가 오류 발생했다는 것을 알 수가 있음
	
	}
	
	public ArrayList<Detail> getList1(int basketNum){
		String SQL = "SELECT * FROM basket WHERE basketNum = ?"; 
		ArrayList<Detail> list1 = new ArrayList<Detail>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, basketNum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Detail detail1 = new Detail();
				detail1.setUserID(rs.getString(1));
				detail1.setBasketCode(rs.getInt(2));
				detail1.setBasketNum(rs.getInt(3));
				detail1.setProductName(rs.getString(4));
				detail1.setProductInformation(rs.getString(5));
				detail1.setSalePrice(rs.getString(6));
				detail1.setColor(rs.getString(7));
				detail1.setQuantity(rs.getString(8));
				detail1.setSize(rs.getString(9));
				detail1.setProductCode(rs.getInt(10));
				detail1.setDate(rs.getString(11));
				detail1.setCount(rs.getInt(12));
				list1.add(detail1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list1; //데이터베이스 오류
	}
	
	
	
	public Detail getDetail1(int productCode) {
		String SQL = "SELECT * FROM detail WHERE productCode = ?";
		/*ArrayList<Bbs> list = new ArrayList<Bbs>();*/
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, productCode);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Detail detail1 = new Detail();
				detail1.setBasketCode(rs.getInt(1));
				detail1.setBasketNum(rs.getInt(2));
				detail1.setProductName(rs.getString(3));
				detail1.setProductInformation(rs.getString(4));
				detail1.setSalePrice(rs.getString(5));
				return detail1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		}
	
	public int delete(int basketCode) {
		String SQL = "DELETE FROM basket WHERE basketCode = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, basketCode);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}

	public int update(int basketCode, String quantity, String color, String size) {
		String SQL = "UPDATE basket SET quantity = ?, color = ?, size =? WHERE basketCode = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, quantity);
			pstmt.setString(2, color);
			pstmt.setString(3, size);
			pstmt.setInt(4, basketCode);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류 
	}
	
	public String getDate() { // 현재의 시간을 가져온 함수 - 게시글을 작성할때 그 시간을 넣어주는 역할
		String SQL = "SELECT NOW()";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	public Detail getDetail2(int basketCode) {
		String SQL = "SELECT * FROM basket WHERE basketCode = ?";
		/*ArrayList<Bbs> list = new ArrayList<Bbs>();*/
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, basketCode);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Detail detail2 = new Detail();
				detail2.setUserID(rs.getString(1));
				detail2.setBasketCode(rs.getInt(2));
				detail2.setBasketNum(rs.getInt(3));
				detail2.setProductName(rs.getString(4));
				detail2.setProductInformation(rs.getString(5));
				detail2.setSalePrice(rs.getString(6));
				detail2.setColor(rs.getString(7));
				detail2.setQuantity(rs.getString(8));
				detail2.setSize(rs.getString(9));
				detail2.setProductCode(rs.getInt(10));
				detail2.setDate(rs.getString(11));
				return detail2;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		}
	public Detail getDetail3(String productSearch) {
		String SQL = "SELECT * FROM detail WHERE productName = ?";
		/*ArrayList<Bbs> list = new ArrayList<Bbs>();*/
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + productSearch + "%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Detail detail1 = new Detail();
				detail1.setBasketCode(rs.getInt(1));
				detail1.setBasketNum(rs.getInt(2));
				detail1.setProductName(rs.getString(3));
				detail1.setProductInformation(rs.getString(4));
				detail1.setSalePrice(rs.getString(5));
				return detail1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
		}
	
	public ArrayList<Detail> getList4(String productSearch){
		String SQL = "SELECT * FROM detail WHERE productName LIKE ?";
		ArrayList<Detail> search = new ArrayList<Detail>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + productSearch + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Detail detail5 = new Detail();
				detail5.setProductCode(rs.getInt(1));
				detail5.setProductName(rs.getString(2));
				detail5.setProductInformation(rs.getString(3));
				detail5.setOriginalPrice(rs.getString(4));
				detail5.setSalePrice(rs.getString(5));
				detail5.setBoardID(rs.getInt(6));
				search.add(detail5);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return search; //데이터베이스 오류
	}
	
}
