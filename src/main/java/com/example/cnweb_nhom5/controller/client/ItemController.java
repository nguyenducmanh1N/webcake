package com.example.cnweb_nhom5.controller.client;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.cnweb_nhom5.domain.Cart;
import com.example.cnweb_nhom5.domain.CartDetail;
import com.example.cnweb_nhom5.domain.Category;
import com.example.cnweb_nhom5.domain.Factory;
import com.example.cnweb_nhom5.domain.Payments;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.Product_;
import com.example.cnweb_nhom5.domain.Review;
import com.example.cnweb_nhom5.domain.Target;
import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.domain.Voucher;

import com.example.cnweb_nhom5.domain.dto.ProductCriteriaDTO;
import com.example.cnweb_nhom5.repository.VoucherRepository;

import com.example.cnweb_nhom5.service.CategoryService;
import com.example.cnweb_nhom5.service.FactoryService;
import com.example.cnweb_nhom5.service.PaymentService;
import com.example.cnweb_nhom5.service.ProductService;
import com.example.cnweb_nhom5.service.ReviewService;
import com.example.cnweb_nhom5.service.TargetService;
import com.example.cnweb_nhom5.service.VoucherService;
import com.example.cnweb_nhom5.service.PaypalService;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

import com.paypal.api.payments.Payment;

@Controller
public class ItemController {

    private final ProductService productService;
    private final ReviewService reviewService;
    private final PaymentService paymentService;
    private final FactoryService factoryService;
    private final TargetService targetService;
    private final CategoryService categoryService;
    private final VoucherService voucherService;
    private final PaypalService paypalService;

    public ItemController(ProductService productService, ReviewService reviewService, PaymentService paymentService,
            FactoryService factoryService,
            TargetService targetService,
            CategoryService categoryService,
            VoucherService voucherService,
            PaypalService paypalService

    ) {
        this.productService = productService;
        this.reviewService = reviewService;
        this.paymentService = paymentService;
        this.factoryService = factoryService;
        this.targetService = targetService;
        this.categoryService = categoryService;
        this.voucherService = voucherService;
        this.paypalService = paypalService;

    }

    // no 1
    // @GetMapping("/product/{id}")
    // public String getProductPage(Model model, @PathVariable long id) {

    // Product pr = this.productService.fetchProductById(id).get();

    // List<Review> reviews = reviewService.getReviewsByProductId(id); // Thay đổi
    // tùy theo cách bạn truy xuất đánh giá
    // List<Category> categories = categoryService.fetchAllCategories();

    // model.addAttribute("categories", categories);
    // model.addAttribute("product", pr);
    // model.addAttribute("id", id);
    // model.addAttribute("reviews", reviews); // Thêm reviews vào model

    // return "client/product/detail"; // Đảm bảo rằng đây là tên JSP của bạn
    // }

    // no 2
    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id) {
        int page = 1;

        // Lấy sản phẩm chi tiết
        Optional<Product> productOptional = this.productService.fetchProductById(id);
        if (productOptional.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Product not found");
        }
        Product pr = productOptional.get();

        // Lấy danh sách đánh giá
        List<Review> reviews = reviewService.getReviewsByProductId(id);
        // Tính trung bình rating
        Double averageRating = reviewService.getAverageRatingByProductId(id);

        // Lấy danh sách danh mục
        List<Category> categories = categoryService.fetchAllCategories();

        // Lấy danh sách sản phẩm thuộc category id = 9
        Pageable pageable = PageRequest.of(page - 1, 5, Sort.by("id").descending()); // Lấy 5 sản phẩm, sắp xếp giảm dần
                                                                                     // theo id
        Page<Product> productsByCategory = this.productService.fetchProductsByCategory(9L, pageable);
        List<Product> productsCategory9 = productsByCategory.getContent();
        List<Product> similarProducts = productService.findSimilarProducts(id);
        model.addAttribute("similarProducts", similarProducts);

        // Đưa dữ liệu vào model
        model.addAttribute("categories", categories);
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
        model.addAttribute("reviews", reviews);
        model.addAttribute("averageRating", averageRating); // Thêm trung bình rating
        model.addAttribute("productsCategory9", productsCategory9); // Danh sách sản phẩm category = 9

        return "client/product/detail"; // Đảm bảo rằng đây là tên JSP của bạn
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        long productId = id;
        String email = (String) session.getAttribute("email");

        this.productService.handleAddProductToCart(email, productId, session, 1);

        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        int page = 1;
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.fetchByUser(currentUser);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        Pageable pageable = PageRequest.of(page - 1, 5, Sort.by("id").descending());
        Page<Product> productsByCategory = this.productService.fetchProductsByCategory(9L, pageable);
        List<Product> productsCategory9 = productsByCategory.getContent();

        // Đưa dữ liệu vào model

        model.addAttribute("productsCategory9", productsCategory9); // Danh sách sản phẩm category = 9

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        model.addAttribute("cart", cart);

        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long cartDetailId = id;
        this.productService.handleRemoveCartDetail(cartDetailId, session);
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        List<Payments> payment = paymentService.fetchAllPayments();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }
        String voucherCode = (String) model.asMap().get("voucherCode");
        if (voucherCode != null) {
            System.out.println("Mã voucher nhận được tại checkout: " + voucherCode);
            model.addAttribute("appliedVoucherCode", voucherCode);

            // session.setAttribute("voucherCode", voucherCode);
        }
        if (voucherCode != null) {
            Optional<Voucher> optionalVoucher = this.voucherService.findByCode(voucherCode);
            Voucher voucher = optionalVoucher.get();
            double discount = (voucher.getDiscountValue() / 100) * totalPrice;
            totalPrice -= discount; // Áp dụng giảm giá
            model.addAttribute("appliedVoucher", voucher);
            model.addAttribute("discountValue", voucher.getDiscountValue());
            model.addAttribute("discount", discount);
        }
        // add model payments
        model.addAttribute("payment", payment);
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart, Model model,
            @RequestParam(value = "voucherCode", required = false) String voucherCode,
            RedirectAttributes redirectAttributes) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);

        if (voucherCode != null && !voucherCode.isEmpty()) {
            redirectAttributes.addFlashAttribute("voucherCode", voucherCode);
        }
        System.out.println("Mã voucher áp dụng: " + voucherCode);
        return "redirect:/checkout"; // Trả về tên view để không mất dữ liệu trong

    }

    // @PostMapping("/place-order")
    // public String handlePlaceOrder(
    // HttpServletRequest request,
    // @RequestParam("receiverName") String receiverName,
    // @RequestParam("receiverAddress") String receiverAddress,
    // @RequestParam("receiverPhone") String receiverPhone,
    // @RequestParam("receiverNote") String receiverNote,
    // @RequestParam double totalPrice,
    // @RequestParam(value = "voucherCode", required = false) String voucherCode, //
    // Nhận từ form
    // @RequestParam("paymentId") long paymentId, Model model) { // Thêm tham số
    // paymentMethod

    // User currentUser = new User();
    // HttpSession session = request.getSession(false);

    // // Kiểm tra session và lấy id người dùng
    // if (session != null && session.getAttribute("id") != null) {
    // long id = (long) session.getAttribute("id");
    // currentUser.setId(id);
    // } else {
    // return "redirect:/login"; // Nếu không có session, chuyển hướng đến trang
    // đăng nhập
    // }

    // // Nếu phương thức thanh toán là VNPay, chuyển đến create_payment
    // if (paymentId == 2L) {
    // System.err.println(paymentId);

    // return "redirect:/api/payment/create_payment?totalPrice=" + totalPrice +
    // "&receiverName=" + URLEncoder.encode(receiverName, StandardCharsets.UTF_8) +
    // "&receiverAddress=" + URLEncoder.encode(receiverAddress,
    // StandardCharsets.UTF_8) +
    // "&receiverPhone=" + receiverPhone +
    // "&receiverNote=" + receiverNote +
    // "&paymentId=" + paymentId +
    // "&voucherCode=" + voucherCode;
    // }

    // if (paymentId == 3L) {
    // System.err.println(paymentId);

    // return "hello";
    // }

    // // Xử lý việc đặt hàng cho phương thức thanh toán COD
    // Cart cart = this.productService.fetchByUser(currentUser);
    // List<CartDetail> cartDetails = cart.getCartDetails();

    // // Duyệt qua từng sản phẩm trong giỏ hàng
    // for (CartDetail cartDetail : cartDetails) {
    // Product product = cartDetail.getProduct();
    // // kiem tra so luong co vuot muc trong kho k

    // if (product.getQuantity() < cartDetail.getQuantity()) {
    // long id = (long) session.getAttribute("id");
    // currentUser.setId(id);

    // for (CartDetail cd : cartDetails) {
    // totalPrice += cd.getPrice() * cd.getQuantity();
    // }

    // if (voucherCode != null) {
    // Optional<Voucher> optionalVoucher =
    // this.voucherService.findByCode(voucherCode);
    // if (optionalVoucher.isPresent()) {
    // Voucher voucher = optionalVoucher.get();
    // double discount = (voucher.getDiscountValue() / 100) * totalPrice;
    // totalPrice -= discount; // Áp dụng giảm giá
    // model.addAttribute("appliedVoucher", voucher);
    // }
    // }

    // model.addAttribute("cartDetails", cartDetails);
    // model.addAttribute("totalPrice", totalPrice);

    // model.addAttribute("cart", cart);
    // // Thêm thông báo lỗi nếu không đủ số lượng
    // model.addAttribute("errorMessage", "Sản phẩm " + product.getName() +
    // " không đủ số lượng. Chỉ còn " + product.getQuantity() + " sản phẩm.");
    // return "client/cart/show"; // Trả về trang giỏ hàng
    // }

    // // Cập nhật số lượng sold và quantity của sản phẩm
    // long quantityBought = cartDetail.getQuantity();
    // product.setSold(product.getSold() + quantityBought);
    // product.setQuantity(product.getQuantity() - quantityBought);

    // // Lưu thay đổi vào database
    // productService.createProduct(product);
    // }

    // this.productService.handlePlaceOrder(currentUser, session, receiverName,
    // receiverAddress, receiverPhone,
    // receiverNote,
    // paymentId, voucherCode);

    // return "redirect:/thanks";
    // }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            // @Valid @ModelAttribute("cart") OrderDTO orderDTO, BindingResult result,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam("receiverNote") String receiverNote,
            @RequestParam double totalPrice,
            @RequestParam(value = "voucherCode", required = false) String voucherCode,
            @RequestParam("paymentId") long paymentId,
            Model model) {

        User currentUser = new User();
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("id") != null) {
            long id = (long) session.getAttribute("id");
            currentUser.setId(id);
        } else {
            return "redirect:/login";
        }
        double exchangeRate = 24000.0; // Giả sử tỷ giá
        double usdAmount = totalPrice / exchangeRate;

        // Xử lý PayPal
        if (paymentId == 3L) { // PayPal
            try {
                Payment payment = paypalService.createPayment(
                        usdAmount, "USD", "paypal",
                        "sale", "Thanh toán đơn hàng",
                        "http://localhost:8080/payment/cancel",
                        "http://localhost:8080/payment/success",
                        receiverName, receiverAddress, receiverPhone, receiverNote, voucherCode);

                for (Links link : payment.getLinks()) {
                    if (link.getRel().equals("approval_url")) {
                        return "redirect:" + link.getHref();
                    }
                }
            } catch (PayPalRESTException e) {
                e.printStackTrace();
            }
        }

        if (paymentId == 4L) {
            return "redirect:/api/momo/create?amount=" + (long) totalPrice +
                    "&receiverName=" + URLEncoder.encode(receiverName, StandardCharsets.UTF_8) +
                    "&receiverAddress=" + URLEncoder.encode(receiverAddress, StandardCharsets.UTF_8) +
                    "&receiverPhone=" + receiverPhone +
                    "&receiverNote=" + receiverNote +
                    "&paymentId=" + paymentId +
                    "&voucherCode=" + voucherCode;
        }

        // Xử lý các phương thức thanh toán khác (VNPay, COD)
        if (paymentId == 2L) {
            return "redirect:/api/payment/create_payment?totalPrice=" + totalPrice +
                    "&receiverName=" + URLEncoder.encode(receiverName, StandardCharsets.UTF_8) +
                    "&receiverAddress=" + URLEncoder.encode(receiverAddress, StandardCharsets.UTF_8) +
                    "&receiverPhone=" + receiverPhone +
                    "&receiverNote=" + receiverNote +
                    "&paymentId=" + paymentId +
                    "&voucherCode=" + voucherCode;
        }

        // Xử lý đơn hàng bình thường cho COD
        Cart cart = this.productService.fetchByUser(currentUser);
        List<CartDetail> cartDetails = cart.getCartDetails();

        for (CartDetail cartDetail : cartDetails) {
            Product product = cartDetail.getProduct();
            if (product.getQuantity() < cartDetail.getQuantity()) {
                model.addAttribute("errorMessage", "Sản phẩm " + product.getName() +
                        " không đủ số lượng. Chỉ còn " + product.getQuantity() + " sản phẩm.");
                return "client/cart/show";
            }
            // product.setSold(product.getSold() + cartDetail.getQuantity());
            // product.setQuantity(product.getQuantity() - cartDetail.getQuantity());
            // productService.createProduct(product);
            long newQuantity = product.getQuantity() - cartDetail.getQuantity();
            long newSold = product.getSold() + cartDetail.getQuantity();
            productService.updateProductStock(product.getId(), newQuantity, newSold);
        }

        this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone,
                receiverNote, paymentId, voucherCode);

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThankYouPage(Model model) {

        return "client/cart/thanks";
    }

    @GetMapping("/failure")
    public String getFaileYouPage(Model model) {

        return "client/cart/faile";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity);
        return "redirect:/product/" + id;
    }

    @GetMapping("/products")
    public String getProductPage(Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request) {
        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                // convert from String to int
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }

        // check sort price
        Pageable pageable = PageRequest.of(page - 1, 12);

        if (productCriteriaDTO.getSort() != null && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if (sort.equals("gia-tang-dan")) {
                pageable = PageRequest.of(page - 1, 12, Sort.by(Product_.PRICE).ascending());
            } else if (sort.equals("gia-giam-dan")) {
                pageable = PageRequest.of(page - 1, 12, Sort.by(Product_.PRICE).descending());
            }
        }

        Page<Product> prs = this.productService.fetchProductsWithSpec(pageable, productCriteriaDTO);

        List<Product> products = prs.getContent().size() > 0 ? prs.getContent()
                : new ArrayList<Product>();

        List<Factory> factories = this.factoryService.fetchAllFactories();

        // Thêm danh sách vào model để hiển thị trên giao diện
        model.addAttribute("factories", factories);

        List<Target> targets = this.targetService.fetchAllTargets();

        List<Category> categories = this.categoryService.fetchAllCategories();
        model.addAttribute("categories", categories);
        // Thêm danh sách vào model để hiển thị trên giao diện
        model.addAttribute("targets", targets);

        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            // remove page
            qs = qs.replace("page=" + page, "");
        }
        List<Product> topSellingProducts = this.productService.fetchTopSellingProducts(PageRequest.of(0, 5));
        model.addAttribute("topSellingProducts", topSellingProducts); // Add top-selling products
        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("queryString", qs);
        return "client/product/show";
    }

    @GetMapping("/search")
    public String searchProducts(
            @RequestParam("name") String name,
            Model model) {
        List<Product> products = productService.searchProductsByName(name);
        List<Factory> factories = this.factoryService.fetchAllFactories();

        List<Category> categories = this.categoryService.fetchAllCategories();
        model.addAttribute("categories", categories);
        // Thêm danh sách vào model để hiển thị trên giao diện
        model.addAttribute("factories", factories);

        List<Target> targets = this.targetService.fetchAllTargets();

        // Thêm danh sách vào model để hiển thị trên giao diện
        model.addAttribute("targets", targets);

        // Thêm danh sách vào model để hiển thị trên giao diện
        model.addAttribute("targets", targets);
        model.addAttribute("products", products);
        return "client/product/show"; // Chuyển về trang hiển thị sản phẩm
    }

    @GetMapping("/cancel")
    public String cancelPage() {
        return "client/cart/cancel";
    }

}