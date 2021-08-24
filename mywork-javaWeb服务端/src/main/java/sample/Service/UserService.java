package sample.Service;

import Core.annotation.Inject;
import sample.Beans.user;
import sample.DaoImplement.userDaoImpl;

public class UserService {
    @Inject
    userDaoImpl userDao;

    public boolean addUser(user u){
        return userDao.insertUser(u);
    }

    public int checkUser(user u){
        user checkU=userDao.getUser(u.getEmail(),u.getPassword());
        if(checkU==null){
            return 0;
        }
        return checkU.getId();
    }

    public boolean updateUser(user u){
        return userDao.updateUser(u);
    }

    public user getUserEmail(int user_id){
        return userDao.getUserEmail(user_id);
    }
}
