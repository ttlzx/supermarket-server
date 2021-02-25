package com.ttlin.repository;

import com.ttlin.pojo.entity.Spu;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SpuRepository extends JpaRepository<Spu, Long> {
    Spu findOneById(Long id);

    Page<Spu> findByRootCategoryIdOrderByCreateTime(Long cid, Pageable pageable);

    Page<Spu> findByCategoryIdOrderByCreateTimeDesc(Long cid, Pageable pageable);
}

