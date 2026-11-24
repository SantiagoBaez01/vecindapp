package com.vecindapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.autoconfigure.orm.jpa.HibernateJpaAutoConfiguration;

/**
 * Esqueleto del backend.
 * DataSource/JPA quedan excluidos hasta el siguiente paso, cuando existan entidades
 * y configuración real de MySQL.
 */
@SpringBootApplication(exclude = {
        DataSourceAutoConfiguration.class,
        HibernateJpaAutoConfiguration.class
})
public class VecindappApplication {

    public static void main(String[] args) {
        SpringApplication.run(VecindappApplication.class, args);
    }
}
