package com.ttlin.service;

import com.ttlin.common.base.OrderStatus;
import com.ttlin.common.exception.http.ForbiddenException;
import com.ttlin.common.exception.http.NotFoundException;
import com.ttlin.common.exception.http.ParameterException;
import com.ttlin.common.utils.OrderUtil;
import com.ttlin.common.utils.money.IMoneyDiscount;
import com.ttlin.logic.CouponChecker;
import com.ttlin.logic.OrderChecker;
import com.ttlin.pojo.dto.OrderDTO;
import com.ttlin.pojo.dto.SkuInfoDTO;
import com.ttlin.pojo.entity.Coupon;
import com.ttlin.pojo.entity.Order;
import com.ttlin.pojo.entity.OrderSku;
import com.ttlin.pojo.entity.Sku;
import com.ttlin.repository.CouponRepository;
import com.ttlin.repository.OrderRepository;
import com.ttlin.repository.SkuRepository;
import com.ttlin.repository.UserCouponRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class OrderService {
    @Autowired
    private SkuService skuService;

    @Autowired
    private CouponRepository couponRepository;

    @Autowired
    private UserCouponRepository userCouponRepository;

    @Autowired
    private IMoneyDiscount iMoneyDiscount;

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private SkuRepository skuRepository;

    @Value("${supermarket.order.max-sku-limit}")
    private int maxSkuLimit;

    public OrderChecker isOk(Long uid, OrderDTO orderDTO) {
        if (orderDTO.getFinalTotalPrice().compareTo(new BigDecimal("0")) <= 0) {
            throw new ParameterException(50011);
        }

        List<Long> skuIdList = orderDTO.getSkuInfoList()
                .stream()
                .map(SkuInfoDTO::getId)
                .collect(Collectors.toList());

        List<Sku> skuList = skuService.getSkuListByIds(skuIdList);

        Long couponId = orderDTO.getCouponId();
        CouponChecker couponChecker = null;
        if (couponId != null) {
            //优惠券是否存在
            Coupon coupon = this.couponRepository.findById(couponId)
                    .orElseThrow(() -> new NotFoundException(40004));

            //玩家是否拥有优惠券
            this.userCouponRepository.findFirstByUserIdAndCouponIdAndStatus(uid, couponId, OrderStatus.UNPAID.value())
                    .orElseThrow(() -> new NotFoundException(50006));
            couponChecker = new CouponChecker(coupon, iMoneyDiscount);
        }

        OrderChecker orderChecker = new OrderChecker(orderDTO, skuList, couponChecker, this.maxSkuLimit);
        //订单总校验
        orderChecker.isOK();
        return orderChecker;
    }

    @Transactional
    public Long placeOrder(Long uid, OrderDTO orderDTO, OrderChecker orderChecker) {
        String orderNo = OrderUtil.makeOrderNo();

        Order order = Order.builder()
                .orderNo(orderNo)
                .totalPrice(orderDTO.getTotalPrice())
                .finalTotalPrice(orderDTO.getFinalTotalPrice())
                .userId(uid)
                .totalCount(orderChecker.getTotalCount().longValue())
                .snapImg(orderChecker.getLeaderImg())
                .snapTitle(orderChecker.getLeaderTitle())
                .status(OrderStatus.UNPAID.value())
                .build();

        order.setSnapAddress(orderDTO.getAddress());
        order.setSnapItems(orderChecker.getOrderSkuList());

        //写入订单
        this.orderRepository.save(order);

        //预扣库存
        this.reduceStock(orderChecker);

        //核销优惠券
        Long couponId = -1L;
        if (orderDTO.getCouponId() != null) {
            this.writeOffCoupon(orderDTO.getCouponId(), order.getId(), uid);
            couponId = orderDTO.getCouponId();
        }
        return order.getId();
    }

    private void reduceStock(OrderChecker orderChecker) {
        List<OrderSku> orderSkuList = orderChecker.getOrderSkuList();
        for (OrderSku orderSku : orderSkuList) {
            int result = this.skuRepository.reduceStock(orderSku.getId(), orderSku.getCount().longValue());
            if (result != 1) {
                throw new ParameterException(50003);
            }
        }
    }

    private void writeOffCoupon(Long couponId, Long oid, Long uid) {
        int result = this.userCouponRepository.writeOff(couponId, oid, uid);
        if (result != 1) {
            throw new ForbiddenException(40012);
        }
    }

}
