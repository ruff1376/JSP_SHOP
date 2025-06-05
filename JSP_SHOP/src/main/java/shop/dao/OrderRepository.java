package shop.dao;

import java.util.ArrayList;
import java.util.List;

import shop.dto.Order;
import shop.dto.Product;

public class OrderRepository extends JDBConnection {
	
	
	public int insert(Order order) {
		int result = 0;
		String sql = "INSERT INTO `order` (ship_name, zip_code, country, address, date, order_pw, user_id, total_price, phone) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, order.getShipName());
            psmt.setString(2, order.getZipCode());
            psmt.setString(3, order.getCountry());
            psmt.setString(4, order.getAddress());
            psmt.setString(5, order.getDate());
            psmt.setString(6, order.getOrderPw());
            psmt.setString(7, order.getUserId());
            psmt.setInt(8, order.getTotalPrice());
            psmt.setString(9, order.getPhone());

            result = psmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
		
		return result;
	}

	public int lastOrderNo() {
		int orderNo = 0;
        String sql = "SELECT MAX(order_no) AS last_order_no FROM `order`";

        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
            if (rs.next()) {
                orderNo = rs.getInt("last_order_no");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderNo;
	}

	public List<Product> list(String userId) {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT o.order_no, io.amount, p.* FROM product p "
		           + "JOIN product_io io ON p.product_id = io.product_id "
		           + "JOIN `order` o ON io.order_no = o.order_no "
		           + "WHERE o.user_id = ?";

        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, userId);
            rs = psmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setOrderNo(rs.getInt("order_no"));
    			product.setQuantity(rs.getInt("amount"));
                product.setProductId(rs.getString("product_id"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getInt("unit_price"));
                product.setDescription(rs.getString("description"));
                product.setManufacturer(rs.getString("manufacturer"));
                product.setCategory(rs.getString("category"));
                product.setUnitsInStock(rs.getInt("units_in_stock"));
                product.setCondition(rs.getString("condition"));
                product.setFile(rs.getString("file"));
                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
	}
	
	public List<Product> list(String phone, String orderPw) {
		List<Product> products = new ArrayList<>();
		String sql = "SELECT o.order_no, io.amount, p.* FROM product p "
		           + "JOIN product_io io ON p.product_id = io.product_id "
		           + "JOIN `order` o ON io.order_no = o.order_no "
		           + "WHERE o.phone = ? AND o.order_pw = ?";

        try {
            psmt = con.prepareStatement(sql);
            psmt.setString(1, phone);
            psmt.setString(2, orderPw);
            rs = psmt.executeQuery();

            while (rs.next()) {
                Product product = new Product();
                product.setOrderNo(rs.getInt("order_no"));
    			product.setQuantity(rs.getInt("amount"));
                product.setProductId(rs.getString("product_id"));
                product.setName(rs.getString("name"));
                product.setUnitPrice(rs.getInt("unit_price"));
                product.setDescription(rs.getString("description"));
                product.setManufacturer(rs.getString("manufacturer"));
                product.setCategory(rs.getString("category"));
                product.setUnitsInStock(rs.getInt("units_in_stock"));
                product.setCondition(rs.getString("condition"));
                product.setFile(rs.getString("file"));
                products.add(product);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return products;
	}
	
}






























