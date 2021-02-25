package com.ttlin.repository;

import com.ttlin.pojo.entity.GridCategory;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface GridCategoryRepository extends JpaRepository<GridCategory, Long> {
    List<GridCategory> findAll();
}
