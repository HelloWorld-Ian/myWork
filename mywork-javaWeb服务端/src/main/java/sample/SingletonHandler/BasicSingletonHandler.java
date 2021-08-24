package sample.SingletonHandler;

import Core.annotation.Singleton;
import Core.annotation.SingletonObjHandler;
import com.alibaba.druid.pool.DruidDataSource;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

@SingletonObjHandler
public class BasicSingletonHandler {

    @Singleton
    public DruidDataSource getString(){
        DruidDataSource d=new DruidDataSource();
        InputStream i=this.getClass().getClassLoader().getResourceAsStream("user.properties");
        Properties p=new Properties();
        try {
            p.load(i);
            d.setUrl((String)p.get("jdbcUrl"));
            d.setUsername((String)p.get("username"));
            d.setPassword((String)p.get("password"));
            d.setDriverClassName((String)p.get("driverClass"));
            d.setMaxActive(10);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return d;
    }

}
