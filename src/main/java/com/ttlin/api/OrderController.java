package com.ttlin.api;

import com.ttlin.common.base.LocalUser;
import com.ttlin.common.interceptor.ScopeLevel;
import com.ttlin.logic.OrderChecker;
import com.ttlin.pojo.dto.OrderDTO;
import com.ttlin.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("order")
public class OrderController {
    @Autowired
    private OrderService orderService;

    @PostMapping("")
    @ScopeLevel()
    public void placeOrder(@RequestBody OrderDTO orderDTO) {
        Long uid = LocalUser.getUser().getId();
        OrderChecker orderChecker = this.orderService.isOk(uid, orderDTO);

    }
}
