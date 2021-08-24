package sample.ServiceHandler;


import Core.annotation.Inject;
import Core.annotation.ServiceHandlerMapping;
import Core.handlers.HttpRequestHandler;
import Core.handlers.HttpResponseHandler;
import Core.template.ServiceHandler;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import sample.Beans.plan;
import sample.Beans.user;
import sample.Service.EmailService;
import sample.Service.UserService;
import sample.Service.planService;


@ServiceHandlerMapping("")
public class ServiceTest extends ServiceHandler {

    @Inject
    UserService userService;

    @Inject
    planService planService;

    @Inject
    EmailService emailService;


    @ServiceHandlerMapping("/register")
    public void register(HttpResponseHandler res,HttpRequestHandler req,user u){
        if(userService.addUser(u)){
            res.write("success");
        }else{
            res.write("fail");
        }
    }


    @ServiceHandlerMapping("/login")
    public void login(HttpResponseHandler res, user u){
        int user_id= userService.checkUser(u);
        if(user_id!=0){
            res.write(Integer.toString(user_id));
        }else{
            res.write("fail");
        }
    }

    @ServiceHandlerMapping("/changeUserInfo")
    public void changeUserInfo(HttpResponseHandler res, user u){
        if(userService.updateUser(u)){
            res.write("success");
        }else{
            res.write("fail");
        }
    }

    @ServiceHandlerMapping("/deletePlan")
    public void deletePlan(HttpRequestHandler req,HttpResponseHandler res){
        int user_id=Integer.parseInt((String) req.getParameter("user_id"));
        String plan_name=(String) req.getParameter("plan_name");

        if(planService.deletePlan(user_id,plan_name)){
            res.write("success");
        }else{
            res.write("fail");
        }
    }

    @ServiceHandlerMapping("/uploadPlan")
    public void upload(HttpRequestHandler req,HttpResponseHandler res){
        String plan=(String)req.getParameter("plan");
        String planLog=(String)req.getParameter("planLog");
        int user_id=Integer.parseInt((String)req.getParameter("user_id"));

        JSONArray planArray=JSON.parseArray(plan);
        JSONArray planLogArray=JSON.parseArray(planLog);

        if(planArray.size()!=planLogArray.size()||user_id==-1){
            res.write("fail");
        }

        int l=planArray.size();

        for(int i=0;i<l;i++){
            plan bean=new plan();
            bean.setUser_id(user_id);

            JSONObject planData= (JSONObject) planArray.get(i);

            String plan_text=planData.toString();
            String planLog_text=planLogArray.get(i).toString();
            bean.setPlan_text(plan_text);
            bean.setPlanLog_text(planLog_text);

            JSONObject planInfo= (JSONObject)planData.get("plan");
            bean.setPlan_name((String)planInfo.get("name"));

            if(planService.insert(bean)){
                res.write("success");
            }else{
                res.write("fail");
            }
        }
    }

    @ServiceHandlerMapping("/downloadPlan")
    public void downloadPlan(HttpRequestHandler req,HttpResponseHandler res){
        int user_id=Integer.parseInt((String)req.getParameter("user_id"));
        String jsonStr=planService.getPlan(user_id);
        res.write(jsonStr);
    }

    @ServiceHandlerMapping("/emailSync")
    public void doEmailSync(HttpRequestHandler req,HttpResponseHandler res){
        int user_id=Integer.parseInt((String)req.getParameter("user_id"));
        user user= userService.getUserEmail(user_id);
        if(user==null){
            res.write("fail");
        }
        assert user != null;
        String email=user.getEmail();

        String schedule=(String) req.getParameter("schedule");
        JSONArray arr=JSON.parseArray(schedule);
        for (Object o : arr) {
            JSONObject j = (JSONObject) o;

            String start=(String)j.get("start");
            String startContent=(String)j.get("startContent");
            String end=(String) j.get("end");
            String endContent=(String) j.get("endContent");

            if(start!=null&&startContent!=null){
                emailService.addJob(start,startContent,email);
            }
            if(end!=null&&endContent!=null){
                emailService.addJob(end,endContent,email);
            }
        }
        res.write("success");
    }
}
