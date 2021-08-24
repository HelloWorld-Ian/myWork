package sample.SingletonHandler;

import Core.annotation.Singleton;
import Core.annotation.SingletonObjHandler;
import sample.DaoImplement.planDaoImpl;
import sample.DaoImplement.userDaoImpl;


@SingletonObjHandler
public class ImplSingletonHandler {

    @Singleton
    public userDaoImpl getUserDapImpl(){
        return new userDaoImpl();
    }

    @Singleton
    public planDaoImpl getPlanDaoImpl(){return new planDaoImpl();}
}
