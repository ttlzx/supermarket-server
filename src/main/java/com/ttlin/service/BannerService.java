package com.ttlin.service;

import com.ttlin.pojo.entity.Banner;
import com.ttlin.repository.BannerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BannerService {

    @Autowired
    private BannerRepository bannerRepository;

    public Banner getByName(String name) {
        return bannerRepository.findOneByName(name);
    }
}
