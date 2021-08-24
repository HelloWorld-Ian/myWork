package sample.Dao;

import sample.Beans.user;

public interface userDao {
    user getUser(String email,String password);
    boolean insertUser(user u);
    user getUserEmail(int user_id);
    boolean updateUser(user u);
}
