package com.example.cnweb_nhom5.domain.dto;

import jakarta.validation.constraints.*;

public class ProductDTO {

    @NotNull
    @Pattern(regexp = "^[a-zA-ZÀ-ỹ\\s]+$", message = "Tên chỉ được chứa chữ cái và khoảng trắng")
    @Size(min = 3, message = "Tên sản phẩm không được trống và phải có tối thiểu 3 ký tự")
    private String name;

    @NotNull(message = "Giá sản phẩm không được để trống")
    @DecimalMin(value = "0.01", message = "Giá phải lớn hơn 0")
    private Double price;

    @NotNull(message = "Ảnh sản phẩm không được để trống")
    private String images;

    @NotNull
    @NotEmpty(message = "Chi tiết không được để trống")
    private String detailDesc;

    @NotNull
    @NotEmpty(message = "Chi tiết ngắn không được để trống")
    private String shortDesc;

    @NotNull
    @Min(value = 1, message = "Số lượng phải lớn hơn 0")
    private Long quantity;

    @NotNull(message = "Vui lòng chọn nhà cung cấp")
    private Long factoryId;

    @NotNull(message = "Vui lòng chọn mục đích")
    private Long targetId;

    @NotNull(message = "Vui lòng chọn danh mục")
    private Long categoryId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public String getDetailDesc() {
        return detailDesc;
    }

    public void setDetailDesc(String detailDesc) {
        this.detailDesc = detailDesc;
    }

    public String getShortDesc() {
        return shortDesc;
    }

    public void setShortDesc(String shortDesc) {
        this.shortDesc = shortDesc;
    }

    public Long getQuantity() {
        return quantity;
    }

    public void setQuantity(Long quantity) {
        this.quantity = quantity;
    }

    public Long getFactoryId() {
        return factoryId;
    }

    public void setFactoryId(Long factoryId) {
        this.factoryId = factoryId;
    }

    public Long getTargetId() {
        return targetId;
    }

    public void setTargetId(Long targetId) {
        this.targetId = targetId;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

}
