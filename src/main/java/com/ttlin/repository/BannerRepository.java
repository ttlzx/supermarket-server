package com.ttlin.repository;

import com.ttlin.pojo.entity.Banner;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BannerRepository extends JpaRepository<Banner, Long> {

    Banner findOneByName(String name);
}
