package com.ttlin.repository;

import com.ttlin.pojo.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.Date;
import java.util.Optional;

public interface OrderRepository extends JpaRepository<Order, Long> {
    Page<Order> findByExpiredTimeGreaterThanAndStatusAndUserId(Date now, Integer status, Long uid, Pageable pageable);
    Page<Order> findByUserId(Long uid, Pageable pageable);
    Page<Order> findByUserIdAndStatus(Long uid, Integer status, Pageable pageable);
    Optional<Order> findFirstByUserIdAndId(Long uid, Long oid);

    @Modifying
    @Query("update Order o set o.status=5 where o.status = 1 and o.id=:oid")
    int cancelOrder(Long oid);
}
