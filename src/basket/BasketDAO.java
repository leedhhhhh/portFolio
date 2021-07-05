package basket;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import detail.Detail;

public class BasketDAO {
	private Connection conn;
	private ResultSet rs;
	
	public BasketDAO() {
		
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
	
	public ArrayList<Basket> getList(int boardID){
		String SQL = "SELECT * FROM Basket WHERE boardID = ? ORDER BY BasketproductCode DESC LIMIT 10"; 
		ArrayList<Basket> list = new ArrayList<Basket>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Basket basket = new Basket();
				basket.setBoardID(rs.getInt(1));
				basket.setBasketproductCode(rs.getInt(2));
				basket.setBasketproductName(rs.getString(3));
				basket.setBasketproductInformation(rs.getString(4));
				basket.setBasketsalePrice(rs.getString(5));
				list.add(basket);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list; //데이터베이스 오류
	}

	/*public int write(int boardID, String BasketproductName, String BasketproductInformation, String BasketsalePrice) {
		String SQL = "INSERT INTO Basket VALUES(?,?,?) select productName, productInformation, salePrice from detail where pro ";
		return -1;
	}*/
}
