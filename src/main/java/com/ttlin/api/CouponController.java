package com.ttlin.api;

import com.ttlin.common.base.LocalUser;
import com.ttlin.common.base.UnifyResponse;
import com.ttlin.common.interceptor.ScopeLevel;
import com.ttlin.pojo.entity.Coupon;
import com.ttlin.pojo.entity.User;
import com.ttlin.pojo.vo.CouponPureVO;
import com.ttlin.service.CouponService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Collections;
import java.util.List;
import java.util.Locale;

@RestController
@RequestMapping("coupon")
public class CouponController {

    @Autowired
    private CouponService couponService;

    @GetMapping("/by/category/{cid}")
    public List<CouponPureVO> getCouponListByCategory(@PathVariable Long cid) {
        List<Coupon> coupons = couponService.getByCategory(cid);
        if (coupons.isEmpty()) {
            return Collections.emptyList();
        }
        List<CouponPureVO> vos = CouponPureVO.getList(coupons);
        return vos;
    }

    @GetMapping("/whole_store")
    public List<CouponPureVO> getWholeStoreCouponList(@Autowired CouponService couponService) {
        List<Coupon> coupons = this.couponService.getWholeStoreCoupons();
        if (coupons.isEmpty()) {
            return Collections.emptyList();
        }
        return CouponPureVO.getList(coupons);
    }

    @ScopeLevel()
    @PostMapping("/collect/{id}")
    public void collectCoupon(@PathVariable Long id) {
        Long uid = LocalUser.getUser().getId();
        couponService.collectOneCoupon(uid, id);
        UnifyResponse.createSuccess(0);
    }


}
