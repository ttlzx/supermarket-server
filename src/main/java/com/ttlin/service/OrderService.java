package com.ttlin.service;

import com.ttlin.common.base.OrderStatus;
import com.ttlin.common.exception.http.NotFoundException;
import com.ttlin.common.exception.http.ParameterException;
import com.ttlin.common.utils.money.IMoneyDiscount;
import com.ttlin.logic.CouponChecker;
import com.ttlin.logic.OrderChecker;
import com.ttlin.pojo.dto.OrderDTO;
import com.ttlin.pojo.dto.SkuInfoDTO;
import com.ttlin.pojo.entity.Coupon;
import com.ttlin.pojo.entity.Sku;
import com.ttlin.repository.CouponRepository;
import com.ttlin.repository.UserCouponRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

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


}
