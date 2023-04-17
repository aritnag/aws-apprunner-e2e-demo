package com.aritra.apprunner.demo.dao;

import com.aritra.apprunner.demo.entity.Product;

import java.util.Collection;

public interface ProductDao {
    Collection<Product> getProductsByCategoryId(int category_id);
    Product getProductById(int id);

    void addProduct(String name, double price, int category_id);
    void updateProduct(int id, String name, double price, int category_id);
    void deleteProductById(int id);
}
