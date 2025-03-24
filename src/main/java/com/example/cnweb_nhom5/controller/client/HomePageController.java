package com.example.cnweb_nhom5.controller.client;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.cnweb_nhom5.domain.Category;
import com.example.cnweb_nhom5.domain.Order;
import com.example.cnweb_nhom5.domain.Product;
import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.domain.Voucher;
import com.example.cnweb_nhom5.domain.dto.RegisterDTO;
import com.example.cnweb_nhom5.service.CategoryService;
import com.example.cnweb_nhom5.service.OrderService;
import com.example.cnweb_nhom5.service.ProductService;
import com.example.cnweb_nhom5.service.UploadService;
import com.example.cnweb_nhom5.service.UserService;
import com.example.cnweb_nhom5.service.VoucherService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final OrderService orderService;
    private final UploadService uploadService;
    private final CategoryService categoryService;
    private final VoucherService voucherService;

    public HomePageController(
            ProductService productService,
            UserService userService,
            PasswordEncoder passwordEncoder,
            OrderService orderService,
            UploadService uploadService,
            CategoryService categoryService,
            VoucherService voucherService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.orderService = orderService;
        this.uploadService = uploadService;
        this.categoryService = categoryService;
        this.voucherService = voucherService;
    }

    @GetMapping("/")
    public String getHomePage(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                // convert from String to int
                page = Integer.parseInt(pageOptional.get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }
        // List<Product> products = this.productService.fetchProducts();
        Pageable pageable = PageRequest.of(page - 1, 12);
        Page<Product> prs = this.productService.fetchProducts(pageable);
        List<Product> products = prs.getContent();
        List<Product> newestProducts = this.productService.fetchNewestProducts(PageRequest.of(0, 4));
        List<Category> categories = this.categoryService.fetchAllCategories();

        List<Product> topSellingProducts = this.productService.fetchTopSellingProducts(PageRequest.of(0, 6));

        model.addAttribute("currentPage", page);
        model.addAttribute("products", products);
        model.addAttribute("newestProducts", newestProducts);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("categories", categories);

        model.addAttribute("topSellingProducts", topSellingProducts); // Add top-selling products
        return "client/homepage/show";
    }

    @GetMapping("/category/{categoryId}")
    public String getProductsByCategory(@PathVariable("categoryId") Long categoryId, Model model,
            @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                // Convert from String to int
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // Handle exception if parsing fails, default to page = 1
            page = 1;
        }

        // Fetch products by category with pagination
        Pageable pageable = PageRequest.of(page - 1, 12);
        Page<Product> prs = this.productService.fetchProductsByCategory(categoryId, pageable);
        List<Product> products = prs.getContent();
        List<Product> newestProducts = this.productService.fetchNewestProducts(PageRequest.of(0, 4));
        List<Category> categories = this.categoryService.fetchAllCategories();
        List<Product> topSellingProducts = this.productService.fetchTopSellingProducts(PageRequest.of(0, 6));
        // Add data to the model
        model.addAttribute("currentPage", page);
        model.addAttribute("products", products);
        model.addAttribute("newestProducts", newestProducts);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("categories", categories);
        model.addAttribute("selectedCategory", categoryId); // To highlight selected category
        model.addAttribute("topSellingProducts", topSellingProducts);

        return "client/homepage/show";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "client/auth/register";
    }

    @GetMapping("/contact")
    public String getContactPage(Model model) {

        return "client/contact/contact";
    }

    @GetMapping("/howtobuy")
    public String getHelpPage(Model model) {

        return "client/help/help";
    }

    @GetMapping("/voucherpage")
    public String getVoucherPage(Model model) {
        List<Voucher> voucher = voucherService.getAllVouchers();
        model.addAttribute("voucher", voucher);
        return "client/voucher/voucher";
    }

    @PostMapping("/register")
    public String handleRegister(Model model,
            @ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult,
            @RequestParam("flowershopFile") MultipartFile file) {

        // validate
        if (bindingResult.hasErrors()) {
            model.addAttribute("errors", bindingResult.getAllErrors());
            return "client/auth/register";
        }

        User user = this.userService.registerDTOtoUser(registerDTO);
        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPassword = this.passwordEncoder.encode(user.getPassword());
        user.setPassword(hashPassword);
        user.setRole(this.userService.getRoleByName("USER"));
        user.setAvatar(avatar.toString());
        // save
        this.userService.handleSaveUser(user);
        return "redirect:/login";

    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {
        return "client/auth/login";
    }

    @GetMapping("/access-deny")
    public String getDenyPage(Model model) {
        return "client/auth/deny";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);
        List<Order> orders = this.orderService.fetchOrderByUser(currentUser);
        model.addAttribute("orders", orders);
        return "client/cart/order-history";
    }

    @GetMapping("/user-detail")
    public String getUserDetailPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "client/user/edit-information";
    }

}
