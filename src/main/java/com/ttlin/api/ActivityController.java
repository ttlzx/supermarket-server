/**
 * @作者 7七月
 * @微信公号 林间有风
 * @开源项目 $ http://7yue.pro
 * @免费专栏 $ http://course.7yue.pro
 * @我的课程 $ http://imooc.com/t/4294850
 * @创建时间 2019-08-03 19:50
 */
package com.ttlin.api;

import com.ttlin.common.exception.http.NotFoundException;
import com.ttlin.pojo.entity.Activity;
import com.ttlin.pojo.vo.ActivityCouponVO;
import com.ttlin.pojo.vo.ActivityPureVO;
import com.ttlin.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("activity")
@RestController
public class ActivityController {
    @Autowired
    private ActivityService activityService;

    @GetMapping("/name/{name}")
    public ActivityPureVO getHomeActivity(@PathVariable String name) {
        Activity activity = activityService.getByName(name);
        if (activity == null) {
            throw new NotFoundException(40001);
        }
        ActivityPureVO vo = new ActivityPureVO(activity);
        return vo;
    }

    @GetMapping("/name/{name}/with_coupon")
    public ActivityCouponVO getActivityWithCoupons(@PathVariable String name) {
        Activity activity = activityService.getByName(name);
        if (activity == null) {
            throw new NotFoundException(40001);
        }
        return new ActivityCouponVO(activity);
    }

}
