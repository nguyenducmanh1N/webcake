package com.example.cnweb_nhom5.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.cnweb_nhom5.domain.Cart;
import com.example.cnweb_nhom5.domain.CartDetail;
import com.example.cnweb_nhom5.domain.Order;
import com.example.cnweb_nhom5.domain.OrderDetail;
import com.example.cnweb_nhom5.domain.OrderStatus;
import com.example.cnweb_nhom5.domain.Payments;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.domain.Voucher;
import com.example.cnweb_nhom5.domain.dto.ProductCriteriaDTO;
import com.example.cnweb_nhom5.repository.CartDetailRepository;
import com.example.cnweb_nhom5.repository.CartRepository;
import com.example.cnweb_nhom5.repository.OrderDetailRepository;
import com.example.cnweb_nhom5.repository.OrderRepository;
import com.example.cnweb_nhom5.repository.OrderStatusRepository;
import com.example.cnweb_nhom5.repository.PaymentRepository;
import com.example.cnweb_nhom5.repository.ProductRepository;
import com.example.cnweb_nhom5.service.specification.ProductSpecs;

import jakarta.servlet.http.HttpSession;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final OrderStatusRepository orderStatusRepository;
    private final PaymentRepository paymentRepository;
    private final PaymentService paymentService;
    private final VoucherService voucherService;

    public ProductService(
            ProductRepository productRepository,
            CartRepository cartRepository,
            CartDetailRepository cartDetailRepository,
            UserService userService,
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository,
            OrderStatusRepository orderStatusRepository,
            PaymentRepository paymentRepository,
            final PaymentService paymentService, VoucherService voucherService) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
        this.orderStatusRepository = orderStatusRepository;
        this.paymentRepository = paymentRepository;
        this.paymentService = paymentService;
        this.voucherService = voucherService;
    }

    public List<Product> searchProductsByName(String name) {
        return productRepository.findByNameContaining(name);
    }

    public Page<Product> fetchProductsByCategory(Long categoryId, Pageable pageable) {
        return productRepository.findByCategoryId(categoryId, pageable);
    }

    public List<Product> fetchNewestProducts(Pageable pageable) {
        return productRepository.findAllByOrderByCreatedDateDesc(pageable).getContent();
    }

    public Product createProduct(Product pr) {
        return this.productRepository.save(pr);
    }

    @Transactional
    public void updateProductStock(Long productId, long quantity, long sold) {
        productRepository.updateStock(productId, quantity, sold);
    }

    public Page<Product> fetchProducts(Pageable page) {
        return this.productRepository.findAll(page);
    }

    public Page<Product> fetchProductsWithSpec(Pageable page, ProductCriteriaDTO productCriteriaDTO) {
        if (productCriteriaDTO.getTarget() == null
                && productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getPrice() == null
                && productCriteriaDTO.getCategory() == null) {
            return this.productRepository.findAll(page);
        }

        Specification<Product> combinedSpec = Specification.where(null);

        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListTarget(productCriteriaDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getCategory() != null && productCriteriaDTO.getCategory().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs
                    .matchListCategory(productCriteriaDTO.getCategory().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> currentSpecs = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        return this.productRepository.findAll(combinedSpec, page);
    }

    // case 6
    public Specification<Product> buildPriceSpecification(List<String> price) {
        Specification<Product> combinedSpec = Specification.where(null); // disconjunction
        for (String p : price) {
            double min = 0;
            double max = 0;

            // Set the appropriate min and max based on the price range string
            switch (p) {
                case "duoi-200":
                    min = 1;
                    max = 200000;
                    break;
                case "200-500":
                    min = 200000;
                    max = 500000;
                    break;
                case "duoi-1-trieu":
                    min = 500000;
                    max = 1000000;
                    break;
                case "1-1,5-trieu":
                    min = 1000000;
                    max = 1500000;
                    break;
                case "1,5-2-trieu":
                    min = 1500000;
                    max = 2000000;
                    break;
                case "tren-2-trieu":
                    min = 2000000;
                    max = 20000000;
                    break;
            }

            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }

        return combinedSpec;
    }

    public Optional<Product> fetchProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {

        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            // check user đã có Cart chưa ? nếu chưa -> tạo mới
            Cart cart = this.cartRepository.findByUser(user);

            if (cart == null) {
                // tạo mới cart
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setSum(0);

                cart = this.cartRepository.save(otherCart);
            }

            // save cart_detail
            // tìm product by id

            Optional<Product> productOptional = this.productRepository.findById(productId);
            if (productOptional.isPresent()) {
                Product realProduct = productOptional.get();

                // check sản phẩm đã từng được thêm vào giỏ hàng trước đây chưa ?
                CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);
                //
                if (oldDetail == null) {
                    CartDetail cd = new CartDetail();
                    cd.setCart(cart);
                    cd.setProduct(realProduct);
                    cd.setPrice(realProduct.getPrice());
                    cd.setQuantity(quantity);
                    this.cartDetailRepository.save(cd);

                    // update cart (sum);
                    int s = cart.getSum() + 1;
                    cart.setSum(s);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", s);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(oldDetail);
                }

            }

        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart currentCart = cartDetail.getCart();
            // delete cart-detail
            this.cartDetailRepository.deleteById(cartDetailId);

            // update cart
            if (currentCart.getSum() > 1) {
                // update current cart
                int s = currentCart.getSum() - 1;
                currentCart.setSum(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(currentCart);
            } else {
                // delete cart (sum = 1)
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone, String receiverNote, Long paymentId,
            String voucherCode) {

        // step 1: get cart by user
        Cart cart = this.cartRepository.findByUser(user);
        if (cart == null || cart.getCartDetails() == null || cart.getCartDetails().isEmpty()) {
            // Giỏ hàng trống, không thể đặt hàng
            return;
        }
        // Payment payment = this.paymentRepository.findById(payment);
        // step 2: create order
        Order order = createOrder(user, receiverName, receiverAddress, receiverPhone, receiverNote, cart, paymentId,
                voucherCode);
        order = this.orderRepository.save(order); // Lưu order vào database
        Voucher voucher = voucherService.findByCode(voucherCode).orElse(null);
        order.setVoucher(voucher);

        // step 3: create order details
        createOrderDetails(order, cart.getCartDetails());

        // step 4: clear cart
        clearCart(cart);

        // step 5: update session
        session.setAttribute("sum", 0);
    }

    private Order createOrder(User user,
            String receiverName, String receiverAddress,
            String receiverPhone, String receiverNote, Cart cart
            // ,Payment payment
            , Long paymentId, String voucherCode) {
        Order order = new Order();
        order.setUser(user);
        order.setReceiverName(receiverName);
        order.setReceiverAddress(receiverAddress);
        order.setReceiverPhone(receiverPhone);
        order.setReceiverNote(receiverNote);
        // order.setPayment(payment);
        // Tìm Payment theo paymentId
        Payments payment = this.paymentService.findById(paymentId); // Sử dụng Optional<Payment>
        if (payment != null) {

            order.setPayment(payment); // Gán payment cho đơn hàng
        } else {
            throw new RuntimeException("Invalid payment method."); // Ném ngoại lệ nếu payment không hợp lệ
        }

        // Lấy OrderStatus từ database, giả sử có phương thức tìm kiếm theo tên trạng
        // thái
        OrderStatus pendingStatus = this.orderStatusRepository.findByName("Chờ xác nhận");
        order.setStatus(pendingStatus); // Gán trạng thái đơn hàng
        double totalPrice = cart.getCartDetails().stream().mapToDouble(CartDetail::getPrice).sum();
        order.setTotalPayable(totalPrice);
        // Tính tổng tiền
        if (voucherCode != null) {
            Optional<Voucher> optionalVoucher = this.voucherService.findByCode(voucherCode);
            if (optionalVoucher.isPresent()) {
                Voucher voucher = optionalVoucher.get();
                double discount = (voucher.getDiscountValue() / 100) * totalPrice;
                totalPrice -= discount; // Áp dụng giảm giá

                voucher.setQuantity(voucher.getQuantity() - 1);

            }
        }

        order.setTotalPrice(totalPrice);

        return order;
    }

    private void createOrderDetails(Order order, List<CartDetail> cartDetails) {
        for (CartDetail cd : cartDetails) {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrder(order);
            orderDetail.setProduct(cd.getProduct());
            orderDetail.setPrice(cd.getPrice());
            orderDetail.setQuantity(cd.getQuantity());

            this.orderDetailRepository.save(orderDetail); // Lưu từng chi tiết đơn hàng vào database
        }
    }

    @Transactional
    private void clearCart(Cart cart) {
        // Xóa các chi tiết giỏ hàng
        // for (CartDetail cd : cart.getCartDetails()) {
        // this.cartDetailRepository.deleteById(cd.getId());
        // }
        // Xóa giỏ hàng
        this.cartRepository.deleteCartDetailByCartId(cart.getId());
        this.cartRepository.deleteByCartId(cart.getId());
    }

    public boolean isProductQuantityAvailable(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Product product = productRepository.findById(cartDetail.getProduct().getId()).orElse(null);
            if (product == null || cartDetail.getQuantity() > product.getQuantity()) {
                return false;
            }
        }
        return true;
    }

    public Product findProductById(long id) {
        return productRepository.findById(id).orElse(null); // Trả về null nếu không tìm thấy
    }

    public List<Product> fetchTopSellingProducts(Pageable pageable) {
        return productRepository.findTopSellingProducts(pageable);
    }

    public List<Product> findSimilarProducts(Long productId) {
        Optional<Product> optionalProduct = productRepository.findById(productId);
        if (optionalProduct.isEmpty()) {
            return new ArrayList<>();
        }
        Product product = optionalProduct.get();

        // Xác định khoảng giá ±10%
        double minPrice = product.getPrice() * 0.9;
        double maxPrice = product.getPrice() * 1.1;

        // Truy vấn sản phẩm có tất cả các điểm chung
        return productRepository.findSimilarProducts(
                product.getCategory(),
                product.getTarget(),
                product.getFactory(),
                minPrice,
                maxPrice,
                product.getId());
    }

}
