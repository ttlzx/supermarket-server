package com.ttlin.repository;

import com.ttlin.pojo.entity.Sku;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SkuRepository extends JpaRepository<Sku, Long> {
    List<Sku> findAllByIdIn(List<Long> ids);

}
