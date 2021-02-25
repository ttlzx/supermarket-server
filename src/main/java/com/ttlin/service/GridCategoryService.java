package com.ttlin.service;

import com.ttlin.pojo.entity.GridCategory;
import com.ttlin.repository.GridCategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GridCategoryService {

    @Autowired
    private GridCategoryRepository gridCategoryRepository;

    public List<GridCategory> getGridCategoryList() {
        return gridCategoryRepository.findAll();
    }
}
