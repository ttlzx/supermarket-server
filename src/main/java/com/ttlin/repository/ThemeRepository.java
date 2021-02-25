package com.ttlin.repository;

import com.ttlin.pojo.entity.Theme;
import com.ttlin.pojo.vo.ThemePureVO;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ThemeRepository extends JpaRepository<Theme, Long> {

    @Query("select t from Theme t where t.name in (:names)")
    List<Theme> findByNames(List<String> names);

    Theme findByName(String name);
}
