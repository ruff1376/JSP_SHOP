package shop.dao;


import shop.dto.Product;

public class ProductIORepository extends JDBConnection {

	/**
	 * 상품 입출고 등록
	 * @param product
	 * @param type
	 * @return
	 */
	public int insert(Product product) {
		int result = 0;

        String sql = "INSERT INTO product_io (product_id, order_no, amount, type, user_id) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, product.getProductId());
            psmt.setInt(2, product.getOrderNo());           // 주문번호
            psmt.setInt(3, product.getQuantity());          // 입출고 수량
            psmt.setString(4, product.getType());           // 'IN' 또는 'OUT'
            psmt.setString(5, product.getUserId());         // 회원 ID (nullable)

            result = psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
	}
	

}