package sample.SingletonHandler;

import Core.annotation.Singleton;
import Core.annotation.SingletonObjHandler;
import org.quartz.SchedulerException;
import org.quartz.impl.StdSchedulerFactory;
import sample.Service.EmailService;
import sample.Service.UserService;
import sample.Service.planService;

import java.text.SimpleDateFormat;

@SingletonObjHandler
public class ServiceSingletonHandler {

    @Singleton
    public UserService getLoginService(){
        return new UserService();
    }

    @Singleton
    public planService getPlanService(){
        return new planService();
    }

    @Singleton
    public EmailService getEmailService(){
       EmailService e=new EmailService();
        try {
            e.setScheduler(StdSchedulerFactory.getDefaultScheduler());
        } catch (SchedulerException schedulerException) {
            schedulerException.printStackTrace();
        }
        e.setDateFormat(new SimpleDateFormat("yyyy 年 MM 月 dd 日HH:mm:ss"));
        e.start();
        return e;
    }
}
