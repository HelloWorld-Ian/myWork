package Core.handlers;

import io.netty.buffer.Unpooled;
import io.netty.channel.*;
import io.netty.handler.codec.http.*;
import io.netty.util.CharsetUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.RandomAccessFile;
import java.util.Map;
import java.util.Objects;

public class StaticHandler extends SimpleChannelHandler<FullHttpRequest> {
    private final String resourcesPath;
    private static final Logger log= LoggerFactory.getLogger(StaticHandler.class);

    /**
     * the map that mapping the file type and the header
     */
    private static final Map<String,String>typeToHeaders=
            Map.of( ".html","text/html;charset=utf-8",
                    ".css","text/css;charset=utf-8",
                    ".ico","image/vnd.microsoft.icon;charset=utf-8",
                    ".js","application/javascript;charset=utf-8",
                    ".jpg","image/jpeg;charset=utf-8",
                    ".png","image/png;charset=utf-8");

    public StaticHandler(String resourcesPath) {
        this.resourcesPath = resourcesPath;
    }

    @Override
    protected void messageReceived(ChannelHandlerContext ctx, FullHttpRequest req) {
        String path = req.uri();
        if(!path.startsWith(resourcesPath)){
            return;
        }
        handleResource(ctx,req,path.substring(1));
    }

    private void handleResource(ChannelHandlerContext ctx, FullHttpRequest req, String path){
        InputStream in=this.getClass().getResourceAsStream("/"+path);
        if(in==null){
            return;
        }
        handleFile(ctx, req, path.substring(path.indexOf(".")),in);
    }

    /**
     * find the static file
     */
    public void handleFile(ChannelHandlerContext ctx, FullHttpRequest req, String suffix,InputStream in){
        RandomAccessFile f;
        try {

            HttpHeaders headers=handleHeader(suffix);
            byte[]bts=in.readAllBytes();

            //netty 以 byteBuf 的形式返回响应体
            FullHttpResponse response = new DefaultFullHttpResponse
                    (HttpVersion.HTTP_1_1, HttpResponseStatus.OK, Unpooled.wrappedBuffer(bts));
            response.headers().set(headers);

            ctx.writeAndFlush(response);

            //ChanelFuture: 用于保存I/O异步操作的结果
            ChannelFuture future = ctx.writeAndFlush(LastHttpContent.EMPTY_LAST_CONTENT);
            future.addListener(ChannelFutureListener.CLOSE);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void handleFileNotFound(ChannelHandlerContext ctx){
        HttpResponseHandler.write("Resources not found",ctx);
    }

    /**
     * <p>
     *     find the type of the file and define the response header
     *     that matches the type of the file
     * </p>
     *
     * @return the header that matches the type of the file
     */
    public HttpHeaders handleHeader(String suffix){
        HttpHeaders header=new DefaultHttpHeaders();
        header.set(HttpHeaderNames.CONTENT_TYPE,typeToHeaders.get(suffix));
        return header;
    }
}
