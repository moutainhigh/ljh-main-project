package com.ljc555.tmall.service;

import com.ljc555.tmall.entity.Reward;
import com.ljc555.tmall.util.OrderUtil;
import com.ljc555.tmall.util.PageUtil;

import java.util.List;

public interface RewardService {
    boolean add(Reward reward);
    boolean update(Reward reward);
    boolean deleteList(Integer[] reward_id_list);

    List<Reward> getList(Reward reward, Byte[] reward_isEnabled_array, OrderUtil orderUtil, PageUtil pageUtil);
    List<Reward> getListByUserId(Integer user_id);

    Reward get(Integer reward_id);
    Integer getTotal(Reward reward, Byte[] reward_isEnabled_array);
}
