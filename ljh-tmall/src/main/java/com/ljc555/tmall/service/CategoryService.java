package com.ljc555.tmall.service;

import com.ljc555.tmall.entity.Category;
import com.ljc555.tmall.util.PageUtil;

import java.util.List;

public interface CategoryService {
    boolean add(Category category);
    boolean update(Category category);

    List<Category> getList(String category_name, PageUtil pageUtil);
    Category get(Integer category_id);
    Integer getTotal(String category_name);
}
