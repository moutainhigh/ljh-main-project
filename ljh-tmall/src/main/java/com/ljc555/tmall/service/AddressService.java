package com.ljc555.tmall.service;

import com.ljc555.tmall.entity.Address;

import java.util.List;

public interface AddressService {
    boolean add(Address address);
    boolean update(Address address);

    List<Address> getList(String address_name, String address_regionId);
    Address get(String address_areaId);
    List<Address> getRoot();
}
