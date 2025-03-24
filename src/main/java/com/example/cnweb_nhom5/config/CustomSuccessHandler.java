package com.example.cnweb_nhom5.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.example.cnweb_nhom5.domain.User;
import com.example.cnweb_nhom5.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CustomSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private UserService userService;

    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin");

        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if (roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }

        throw new IllegalStateException();
    }

    protected void clearAuthenticationAttributes(HttpServletRequest request, Authentication authentication) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        // get email
        String email = authentication.getName();
        // query user
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            session.setAttribute("user", user);
            session.setAttribute("fullName", user.getFullName());
            session.setAttribute("avatar", user.getAvatar());
            session.setAttribute("id", user.getId());
            session.setAttribute("email", user.getEmail());
            int sum = user.getCart() == null ? 0 : user.getCart().getSum();
            session.setAttribute("sum", sum);

        }

    }

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    // @Override
    // public void onAuthenticationSuccess(HttpServletRequest request,
    // HttpServletResponse response,
    // Authentication authentication) throws IOException, ServletException {

    // String targetUrl = determineTargetUrl(authentication);

    // if (response.isCommitted()) {

    // return;
    // }

    // redirectStrategy.sendRedirect(request, response, targetUrl);
    // clearAuthenticationAttributes(request, authentication);

    // }
    // @Override
    // public void onAuthenticationSuccess(HttpServletRequest request,
    // HttpServletResponse response,
    // Authentication authentication) throws IOException, ServletException {

    // Map<String, Object> attributes =
    // ((org.springframework.security.oauth2.core.user.DefaultOAuth2User)
    // authentication
    // .getPrincipal()).getAttributes();

    // // In ra thông tin từ Google
    // System.out.println("Google User Info:");
    // attributes.forEach((key, value) -> System.out.println(key + ": " + value));
    // // Lấy thông tin từ OAuth2User
    // Object principal = authentication.getPrincipal();
    // if (principal instanceof DefaultOAuth2User) {
    // DefaultOAuth2User oAuth2User = (DefaultOAuth2User) principal;

    // String email = (String) oAuth2User.getAttribute("email");
    // String name = (String) oAuth2User.getAttribute("name");
    // String avatar = (String) oAuth2User.getAttribute("picture");

    // // Lưu hoặc cập nhật thông tin người dùng trong database
    // User user = userService.getUserByEmail(email);
    // if (user == null) {
    // user = new User();
    // user.setEmail(email);
    // user.setFullName(name);
    // user.setAvatar(avatar);
    // user.setRole(this.userService.getRoleByName("USER"));
    // userService.save(user);
    // }

    // // Thêm thông tin vào session
    // HttpSession session = request.getSession();
    // session.setAttribute("user", user);
    // session.setAttribute("fullName", user.getFullName());
    // session.setAttribute("avatar", user.getAvatar());
    // session.setAttribute("id", user.getId());
    // session.setAttribute("email", user.getEmail());
    // int sum = user.getCart() == null ? 0 : user.getCart().getSum();
    // session.setAttribute("sum", sum);
    // }

    // // Chuyển hướng đến trang home
    // redirectStrategy.sendRedirect(request, response, "/");
    // }
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {

        Object principal = authentication.getPrincipal();

        if (principal instanceof DefaultOAuth2User) {
            // Xử lý khi đăng nhập bằng OAuth2
            DefaultOAuth2User oAuth2User = (DefaultOAuth2User) principal;
            Map<String, Object> attributes = oAuth2User.getAttributes();

            System.out.println("Google User Info:");
            attributes.forEach((key, value) -> System.out.println(key + ": " + value));

            String email = (String) oAuth2User.getAttribute("email");
            String name = (String) oAuth2User.getAttribute("name");
            String avatar = (String) oAuth2User.getAttribute("picture");

            if (email != null) {

                User user = userService.getUserByEmail(email);
                if (user == null) {
                    user = new User();
                    user.setEmail(email);
                    user.setFullName(name != null ? name : "No Name");
                    user.setAvatar(avatar);
                    user.setRole(userService.getRoleByName("USER"));
                    userService.save(user);
                }

                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("fullName", user.getFullName());
                session.setAttribute("avatar", user.getAvatar());
                session.setAttribute("id", user.getId());
                session.setAttribute("email", user.getEmail());
                int sum = user.getCart() == null ? 0 : user.getCart().getSum();
                session.setAttribute("sum", sum);
            } else {
                System.err.println("OAuth2 user does not have an email. Authentication failed.");
                response.sendRedirect("/login?error");
                return;
            }

        } else if (principal instanceof org.springframework.security.core.userdetails.User) {

            org.springframework.security.core.userdetails.User userDetails = (org.springframework.security.core.userdetails.User) principal;

            HttpSession session = request.getSession();
            User user = userService.getUserByEmail(userDetails.getUsername());
            if (user != null) {
                session.setAttribute("user", user);
                session.setAttribute("fullName", user.getFullName());
                session.setAttribute("avatar", user.getAvatar());
                session.setAttribute("id", user.getId());
                session.setAttribute("email", user.getEmail());
                int sum = user.getCart() == null ? 0 : user.getCart().getSum();
                session.setAttribute("sum", sum);
            }
        } else {
            throw new IllegalStateException(
                    "Unsupported authentication principal type: " + principal.getClass().getName());
        }

        // // response.sendRedirect("/");

        // String targetUrl = determineTargetUrl(authentication);

        // // Nếu người dùng có ROLE_ADMIN, chuyển đến trang admin
        // if (authentication.getAuthorities().stream()
        // .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"))) {
        // targetUrl = "/admin";
        // }

        // // Thực hiện chuyển hướng
        // redirectStrategy.sendRedirect(request, response, targetUrl);

        // // Xóa các thuộc tính xác thực trong session
        // clearAuthenticationAttributes(request, authentication);
        // Chuyển hướng đến trang home
        response.sendRedirect("/");

    }

}
