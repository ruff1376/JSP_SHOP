package shop.dao;

import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	/**
	 * 주문 등록
	 * @param user
	 * @return
	 */
	public int insert(Order order) {
		int result = 0;
		
		try {
			String sql = "INSERT INTO "
					+ "order(orderNo, cartId, shipName, zipCode, country, address, date, userId, totalPrice, phone, orderPw)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	/**
	 * 최근 등록한 orderNo 
	 * @return
	 */
	public int lastOrderNo() {
		
	}

	
	/**
	 * 주문 내역 조회 - 회원
	 * @param userId
	 * @return
	 */
	public List<Product> list(String userId) {
		
	}
	
	/**
	 * 주문 내역 조회 - 비회원
	 * @param phone
	 * @param orderPw
	 * @return
	 */
	public List<Product> list(String phone, String orderPw) {
		
		
	}
	
}






























