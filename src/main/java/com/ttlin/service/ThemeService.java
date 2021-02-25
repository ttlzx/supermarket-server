package com.ttlin.service;

import com.ttlin.pojo.entity.Theme;
import com.ttlin.pojo.vo.ThemePureVO;
import com.ttlin.repository.ThemeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ThemeService {

    @Autowired
    private ThemeRepository themeRepository;

    public List<Theme> getThemesByNames(List<String> names) {
        return themeRepository.findByNames(names);
    }

    public Theme getThemeByName(String name) {
        return themeRepository.findByName(name);
    }

}
