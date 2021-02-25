package com.ttlin.api;

import com.ttlin.common.exception.http.NotFoundException;
import com.ttlin.common.utils.CommonUtil;
import com.ttlin.pojo.bo.PageCounter;
import com.ttlin.pojo.entity.Spu;
import com.ttlin.pojo.vo.PagingDozer;
import com.ttlin.pojo.vo.SpuPureVO;
import com.ttlin.service.SpuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Positive;

@RestController
@RequestMapping("/spu")
public class SpuController {

    @Autowired
    private SpuService spuService;

    //获取最近的商品
    @GetMapping("/latest")
    public PagingDozer<Spu, SpuPureVO> getLatestSpuList(@RequestParam(defaultValue = "0") Integer start,
                                                        @RequestParam(defaultValue = "10") Integer count) {
        PageCounter pageCounter = CommonUtil.convertToPageParameter(start, count);
        Page<Spu> page = this.spuService.getLatestPagingSpu(pageCounter.getPage(), pageCounter.getCount());
        return new PagingDozer<>(page, SpuPureVO.class);
    }

    //获取商品的详细信息
    @GetMapping("/id/{id}")
    public Spu getDetail(@PathVariable @Positive Long id) {
        Spu spu = this.spuService.getSpu(id);
        if (spu == null) {
            throw new NotFoundException(30003);
        }
        return spu;
    }



}
