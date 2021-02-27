package com.ttlin.pojo.entity;

import com.fasterxml.jackson.core.type.TypeReference;
import com.ttlin.common.utils.GenericAndJson;
import com.ttlin.pojo.dto.OrderAddressDTO;
import lombok.*;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import static javax.persistence.GenerationType.IDENTITY;

@Entity
@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Where(clause = "delete_time is null")
@Table(name = "`Order`")
public class Order extends BaseEntity{
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;
    private String orderNo;
    private Long userId;
    private BigDecimal totalPrice;
    private Long totalCount;
    private String snapImg;
    private String snapTitle;
    private String snapItems;
    private String snapAddress;
    private String prepayId;
    private BigDecimal finalTotalPrice;
    private Integer status;


    public void setSnapItems(List<OrderSku> orderSkuList) {
        if (orderSkuList.isEmpty()) {
            return;
        }
        this.snapItems = GenericAndJson.objectToJson(orderSkuList);
    }

    public List<OrderSku> getSnapItems() {
        List<OrderSku> list = GenericAndJson.jsonToObject(this.snapItems,
                new TypeReference<List<OrderSku>>() {
                });
        return list;
    }


    public OrderAddressDTO getSnapAddress() {
        if (this.snapAddress == null) {
            return null;
        }
        OrderAddressDTO o = GenericAndJson.jsonToObject(this.snapAddress,
                new TypeReference<OrderAddressDTO>() {
                });
        return o;
    }

    public void setSnapAddress(OrderAddressDTO address) {
        this.snapAddress = GenericAndJson.objectToJson(address);
    }
}
