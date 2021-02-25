package com.ttlin.api;

import com.github.dozermapper.core.DozerBeanMapperBuilder;
import com.github.dozermapper.core.Mapper;
import com.ttlin.common.exception.http.NotFoundException;
import com.ttlin.pojo.entity.Theme;
import com.ttlin.pojo.vo.ThemePureVO;
import com.ttlin.service.ThemeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@RestController
@RequestMapping("/theme")
public class ThemeController {

    @Autowired
    private ThemeService themeService;

    @GetMapping("/names/{names}")
    public List<ThemePureVO> getThemes(@PathVariable String names) {
        List<String> nameList = Arrays.asList(names.split(","));
        List<Theme> themeList = themeService.getThemesByNames(nameList);
        List<ThemePureVO> themePureVOList = new ArrayList<>();
        themeList.forEach(theme -> {
            Mapper mapper = DozerBeanMapperBuilder.buildDefault();
            ThemePureVO themeSpuPureVO = mapper.map(theme, ThemePureVO.class);
            themePureVOList.add(themeSpuPureVO);
        });
        return themePureVOList;
    }

    @GetMapping("/name/{name}" )
    public Theme getThem(@PathVariable String name) {
        Theme theme = themeService.getThemeByName(name);
        if (theme == null) {
            throw new NotFoundException(30003);
        }
        return theme;
    }
}
