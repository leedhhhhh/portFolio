package basket;

public class Basket {
	private int boardID;
	private int BasketproductCode;
	private String BasketproductName;
	private String BasketproductInformation;
	private String BasketsalePrice;
	
	public int getBoardID() {
		return boardID;
	}
	public void setBoardID(int boardID) {
		this.boardID = boardID;
	}
	public int getBasketproductCode() {
		return BasketproductCode;
	}
	public void setBasketproductCode(int basketproductCode) {
		BasketproductCode = basketproductCode;
	}
	public String getBasketproductName() {
		return BasketproductName;
	}
	public void setBasketproductName(String basketproductName) {
		BasketproductName = basketproductName;
	}
	public String getBasketproductInformation() {
		return BasketproductInformation;
	}
	public void setBasketproductInformation(String basketproductInformation) {
		BasketproductInformation = basketproductInformation;
	}
	public String getBasketsalePrice() {
		return BasketsalePrice;
	}
	public void setBasketsalePrice(String basketsalePrice) {
		BasketsalePrice = basketsalePrice;
	}
	

}
