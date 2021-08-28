package com.ljc555.tmall.service;

import com.ljc555.tmall.entity.Property;
import com.ljc555.tmall.util.PageUtil;

import java.util.List;

public interface PropertyService {
    boolean add(Property property);

    boolean addList(List<Property> propertyList);
    boolean update(Property property);
    boolean deleteList(Integer[] property_id_list);

    List<Property> getList(Property property, PageUtil pageUtil);
    Property get(Integer property_id);
    Integer getTotal(Property property);
}
