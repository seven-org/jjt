package com.jjt.template.base.dao.config;

import javax.sql.DataSource;

import org.springframework.boot.autoconfigure.AutoConfigureBefore;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.context.annotation.PropertySource;

@Configuration
@PropertySource({"classpath:applications-infrastructure-dao.properties", "classpath:base-dao-datasource.properties"})
@AutoConfigureBefore(MybatisConfig.class)
public class MallBaseDaoMapperConfig {
	
	@Bean(name="primaryDataSourceProperties")
	@Primary
	@ConfigurationProperties("jjt.template.datasource.primary")
	public DataSourceProperties primaryDataSourceProperties() {
	    return new DataSourceProperties();
	}

	@Bean(name="mysqlDataSource")
	@Primary
	@ConfigurationProperties("jjt.template.datasource.primary")
	public DataSource primaryDataSource() {
	    return primaryDataSourceProperties().initializeDataSourceBuilder().build();
	}
	
}
