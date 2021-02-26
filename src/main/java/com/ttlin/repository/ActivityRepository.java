package com.ttlin.repository;

import com.ttlin.pojo.entity.Activity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ActivityRepository extends JpaRepository<Activity, Long> {
    Activity findByName(String name);
}
