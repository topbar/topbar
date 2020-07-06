//
//  WebSocketManager.m
//  topbar
//
//  Created by topbar on 2019/11/28.
//  Copyright © 2019 guo feng zou. All rights reserved.
//

#import "WebSocketManager.h"


//心跳包使用
#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}



@interface WebSocketManager()
{

    NSTimeInterval reConnectTime;
    
    NSTimer * heartBeat;

    
}

@end



@implementation WebSocketManager

- (void)WithIP:(NSString *)URLIP{
    _webSocket.delegate = nil;
    [_webSocket close];
    
    NSString *urlStr = [NSString stringWithFormat:@"%@", URLIP];

    _ip =urlStr;
    
    NSURL *url = [NSURL URLWithString:urlStr];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //如需更改链接的头部则需此步
   // [request setValue:@"http://192.168.3.63" forHTTPHeaderField:@"6969"];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:request];
    _webSocket.delegate = self;
}
//+ (instancetype)share
//{
//    static dispatch_once_t onceToken;
//    static webSocketManager *instance = nil;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc]init];
//        [instance openSocket];
//    });
//    return instance;
//}
+(WebSocketManager *)instance{
    static WebSocketManager *Instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        Instance = [[WebSocketManager alloc] init];
    });
    return Instance;
}

- (void)openSocket {
//    _webSocket.delegate = nil;
//    [_webSocket close];
//
 
   // _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://192.168.14.109:6969"]]];
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_ip]]];

    _webSocket.delegate = self;////SRWebSocketDelegate 协议
    [_webSocket open];
}
//开启连接
//-(void)openSocket{
//
//    if (self.webSocket) {
//        return;
//    }
//    //SRWebSocketUrlString 就是websocket的地址
//    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:
//                   [NSURLRequest requestWithURL:[NSURL URLWithString:_ip]]];
//
//    self.webSocket.delegate = self;   //SRWebSocketDelegate 协议
//
//    [self.webSocket open];     //open 就是直接连接了
//}



- (void)closeSocket {
    self.webSocket.delegate = nil;
    [self.webSocket close];
    self.webSocket = nil;
    
    
  
}
//关闭连接
-(void)SRWebSocketClose{
    if (self.webSocket){
        [self.webSocket close];
        self.webSocket = nil;
        //断开连接时销毁心跳
        [self destoryHeartBeat];
    }
}


//断开连接
- (void)disConnect
{
    
    if (_webSocket) {
        [_webSocket closeWithCode:disConnectByUser reason:@"用户主动断开"];
        _webSocket = nil;
    }
}

//重连机制
- (void)reConnect
{
   // [self disConnect];
    [self SRWebSocketClose];
    
    //超过一分钟就不再重连 所以只会重连5次 2^5 = 64
    if (reConnectTime > 64) {
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self->_webSocket = nil;
        [self openSocket];
        NSLog(@"重连");
    });
    
    
    //重连时间2的指数级增长
    if (reConnectTime == 0) {
        reConnectTime = 2;
    }else{
        reConnectTime *= 2;
    }
    
}
//初始化心跳
- (void)initHeartBeat
{
    dispatch_main_async_safe(^{
        
        [self destoryHeartBeat];
        __weak typeof(self) weakSelf = self;
        //心跳设置为3分钟，NAT超时一般为5分钟
        self->heartBeat = [NSTimer scheduledTimerWithTimeInterval:3*60 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"heart");
            //和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
            [weakSelf sendTalkMessage:@"heart"];
        }];
        [[NSRunLoop currentRunLoop]addTimer:self->heartBeat forMode:NSRunLoopCommonModes];
    })
    
}

//取消心跳
- (void)destoryHeartBeat
{
    dispatch_main_async_safe(^{
        if (self->heartBeat) {
            [self->heartBeat invalidate];
            self->heartBeat = nil;
        }
    })
}
//外部聊天发送消息
#define WeakSelf(ws) __weak __typeof(&*self)weakSelf = self
- (void)sendTalkMessage:(NSString *)message{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//
//
//    ///获取当前时间
//    NSDate *date = [NSDate date];
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//
//
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//
//    // [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
//    [formatter setDateFormat:@"hh:mm:ss"];
//    NSString *DateTime = [formatter stringFromDate:date];
//    // NSLog(@"%@============年-月-日  时：分：秒=====================",DateTime);
//
//
//    //随机生成数字
//    // int x = arc4random() % 100;
//    int uid = (arc4random() % 50001) + 59000;//随机生成UID
//    NSString *stringInt = [NSString stringWithFormat:@"%d",uid];
    
    
   //USDT区
       dic = [@{@"event":@"addChannel", @"channel":@"btcusdt_ticker"} mutableCopy];
       [self sendMessage:dic];
       
       NSMutableDictionary *ethusdt_ticker = [NSMutableDictionary dictionary];
       ethusdt_ticker = [@{@"event":@"addChannel", @"channel":@"ethusdt_ticker"} mutableCopy];
       [self sendMessage:ethusdt_ticker];

       NSMutableDictionary *xrpusdt_ticker = [NSMutableDictionary dictionary];
       xrpusdt_ticker = [@{@"event":@"addChannel", @"channel":@"xrpusdt_ticker"} mutableCopy];
       [self sendMessage:xrpusdt_ticker];
       
       
       NSMutableDictionary *zbusdt_ticker = [NSMutableDictionary dictionary];
       zbusdt_ticker = [@{@"event":@"addChannel", @"channel":@"zbusdt_ticker"} mutableCopy];
       [self sendMessage:zbusdt_ticker];
       
       NSMutableDictionary *eosusdt_ticker = [NSMutableDictionary dictionary];
       eosusdt_ticker = [@{@"event":@"addChannel", @"channel":@"eosusdt_ticker"} mutableCopy];
       [self sendMessage:eosusdt_ticker];
       
       NSMutableDictionary *xlmusdt_ticker = [NSMutableDictionary dictionary];
       xlmusdt_ticker = [@{@"event":@"addChannel", @"channel":@"xlmusdt_ticker"} mutableCopy];
       [self sendMessage:xlmusdt_ticker];
       
       NSMutableDictionary *ltcusdt_ticker = [NSMutableDictionary dictionary];
       ltcusdt_ticker = [@{@"event":@"addChannel", @"channel":@"ltcusdt_ticker"} mutableCopy];
       [self sendMessage:ltcusdt_ticker];
       
       NSMutableDictionary *adausdt_ticker = [NSMutableDictionary dictionary];
       adausdt_ticker = [@{@"event":@"addChannel", @"channel":@"adausdt_ticker"} mutableCopy];
       [self sendMessage:adausdt_ticker];
       
       NSMutableDictionary *etcusdt_ticker = [NSMutableDictionary dictionary];
       etcusdt_ticker = [@{@"event":@"addChannel", @"channel":@"etcusdt_ticker"} mutableCopy];
       [self sendMessage:etcusdt_ticker];
       
       NSMutableDictionary *xemusdt_ticker = [NSMutableDictionary dictionary];
       xemusdt_ticker = [@{@"event":@"addChannel", @"channel":@"xemusdt_ticker"} mutableCopy];
       [self sendMessage:xemusdt_ticker];
       
       NSMutableDictionary *omgusdt_ticker = [NSMutableDictionary dictionary];
       omgusdt_ticker = [@{@"event":@"addChannel", @"channel":@"omgusdt_ticker"} mutableCopy];
       [self sendMessage:omgusdt_ticker];

       NSMutableDictionary *zrxusdt_ticker = [NSMutableDictionary dictionary];
       zrxusdt_ticker = [@{@"event":@"addChannel", @"channel":@"zrxusdt_ticker"} mutableCopy];
       [self sendMessage:zrxusdt_ticker];
       
       NSMutableDictionary *btsusdt_ticker = [NSMutableDictionary dictionary];
       btsusdt_ticker = [@{@"event":@"addChannel", @"channel":@"btsusdt_ticker"} mutableCopy];
       [self sendMessage:btsusdt_ticker];
       
       NSMutableDictionary *icxusdt_ticker = [NSMutableDictionary dictionary];
       icxusdt_ticker = [@{@"event":@"addChannel", @"channel":@"icxusdt_ticker"} mutableCopy];
       [self sendMessage:icxusdt_ticker];


       
       
       //QC区---
       NSMutableDictionary *btcqc_ticker = [NSMutableDictionary dictionary];
       btcqc_ticker = [@{@"event":@"addChannel", @"channel":@"btcqc_ticker"} mutableCopy];
       [self sendMessage:btcqc_ticker];
       
       NSMutableDictionary *ethqc_ticker = [NSMutableDictionary dictionary];
       ethqc_ticker = [@{@"event":@"addChannel", @"channel":@"ethqc_ticker"} mutableCopy];
       [self sendMessage:ethqc_ticker];
       
       NSMutableDictionary *xrpqc_ticker = [NSMutableDictionary dictionary];
       xrpqc_ticker = [@{@"event":@"addChannel", @"channel":@"xrpqc_ticker"} mutableCopy];
       [self sendMessage:xrpqc_ticker];
       
       
       NSMutableDictionary *zbqc_ticker = [NSMutableDictionary dictionary];
       zbqc_ticker = [@{@"event":@"addChannel", @"channel":@"zbqc_ticker"} mutableCopy];
       [self sendMessage:zbqc_ticker];
       
       NSMutableDictionary *eosqc_ticker = [NSMutableDictionary dictionary];
       eosqc_ticker = [@{@"event":@"addChannel", @"channel":@"eosqc_ticker"} mutableCopy];
       [self sendMessage:eosqc_ticker];
       
       NSMutableDictionary *xlmqc_ticker = [NSMutableDictionary dictionary];
       xlmqc_ticker = [@{@"event":@"addChannel", @"channel":@"xlmqc_ticker"} mutableCopy];
       [self sendMessage:xlmqc_ticker];
       
       NSMutableDictionary *ltcqc_ticker = [NSMutableDictionary dictionary];
       ltcqc_ticker = [@{@"event":@"addChannel", @"channel":@"ltcqc_ticker"} mutableCopy];
       [self sendMessage:ltcqc_ticker];
       
       NSMutableDictionary *adaqc_ticker = [NSMutableDictionary dictionary];
       adaqc_ticker = [@{@"event":@"addChannel", @"channel":@"adaqc_ticker"} mutableCopy];
       [self sendMessage:adaqc_ticker];
       
       NSMutableDictionary *etcqc_ticker = [NSMutableDictionary dictionary];
       etcqc_ticker = [@{@"event":@"addChannel", @"channel":@"etcqc_ticker"} mutableCopy];
       [self sendMessage:etcqc_ticker];
       
       NSMutableDictionary *xemqc_ticker = [NSMutableDictionary dictionary];
       xemqc_ticker = [@{@"event":@"addChannel", @"channel":@"xemqc_ticker"} mutableCopy];
       [self sendMessage:xemqc_ticker];
       
       NSMutableDictionary *omgqc_ticker = [NSMutableDictionary dictionary];
       omgqc_ticker = [@{@"event":@"addChannel", @"channel":@"omgqc_ticker"} mutableCopy];
       [self sendMessage:omgqc_ticker];

       NSMutableDictionary *zrxqc_ticker = [NSMutableDictionary dictionary];
       zrxqc_ticker = [@{@"event":@"addChannel", @"channel":@"zrxqc_ticker"} mutableCopy];
       [self sendMessage:zrxqc_ticker];
       
       NSMutableDictionary *btsqc_ticker = [NSMutableDictionary dictionary];
       btsqc_ticker = [@{@"event":@"addChannel", @"channel":@"btsqc_ticker"} mutableCopy];
       [self sendMessage:btsqc_ticker];
       
       NSMutableDictionary *icxqc_ticker = [NSMutableDictionary dictionary];
       icxqc_ticker = [@{@"event":@"addChannel", @"channel":@"icxqc_ticker"} mutableCopy];
       [self sendMessage:icxqc_ticker];

       
       
       //BTC区---
       NSMutableDictionary *eosbtc_ticker = [NSMutableDictionary dictionary];
       eosbtc_ticker = [@{@"event":@"addChannel", @"channel":@"eosbtc_ticker"} mutableCopy];
       [self sendMessage:eosbtc_ticker];
       
       NSMutableDictionary *ethbtc_ticker = [NSMutableDictionary dictionary];
       ethbtc_ticker = [@{@"event":@"addChannel", @"channel":@"ethbtc_ticker"} mutableCopy];
       [self sendMessage:ethbtc_ticker];
       
       NSMutableDictionary *xrpbtc_ticker = [NSMutableDictionary dictionary];
       xrpbtc_ticker = [@{@"event":@"addChannel", @"channel":@"xrpbtc_ticker"} mutableCopy];
       [self sendMessage:xrpbtc_ticker];
       
       
       NSMutableDictionary *zbbtc_ticker = [NSMutableDictionary dictionary];
       zbbtc_ticker = [@{@"event":@"addChannel", @"channel":@"zbbtc_ticker"} mutableCopy];
       [self sendMessage:zbbtc_ticker];
       
       NSMutableDictionary *neobtc_ticker = [NSMutableDictionary dictionary];
       neobtc_ticker = [@{@"event":@"addChannel", @"channel":@"neobtc_ticker"} mutableCopy];
       [self sendMessage:neobtc_ticker];
       
       NSMutableDictionary *xlmbtc_ticker = [NSMutableDictionary dictionary];
       xlmbtc_ticker = [@{@"event":@"addChannel", @"channel":@"xlmbtc_ticker"} mutableCopy];
       [self sendMessage:xlmbtc_ticker];
       
       NSMutableDictionary *ltcbtc_ticker = [NSMutableDictionary dictionary];
       ltcbtc_ticker = [@{@"event":@"addChannel", @"channel":@"ltcbtc_ticker"} mutableCopy];
       [self sendMessage:ltcbtc_ticker];
       
       NSMutableDictionary *adabtc_ticker = [NSMutableDictionary dictionary];
       adabtc_ticker = [@{@"event":@"addChannel", @"channel":@"adabtc_ticker"} mutableCopy];
       [self sendMessage:adabtc_ticker];
       
       NSMutableDictionary *etcbtc_ticker = [NSMutableDictionary dictionary];
       etcbtc_ticker = [@{@"event":@"addChannel", @"channel":@"etcbtc_ticker"} mutableCopy];
       [self sendMessage:etcbtc_ticker];
       
       NSMutableDictionary *batbtc_ticker = [NSMutableDictionary dictionary];
       batbtc_ticker = [@{@"event":@"addChannel", @"channel":@"batbtc_ticker"} mutableCopy];
       [self sendMessage:batbtc_ticker];
       
       NSMutableDictionary *omgbtc_ticker = [NSMutableDictionary dictionary];
       omgbtc_ticker = [@{@"event":@"addChannel", @"channel":@"omgbtc_ticker"} mutableCopy];
       [self sendMessage:omgbtc_ticker];

       NSMutableDictionary *zrxbtc_ticker = [NSMutableDictionary dictionary];
       zrxbtc_ticker = [@{@"event":@"addChannel", @"channel":@"zrxbtc_ticker"} mutableCopy];
       [self sendMessage:zrxbtc_ticker];
       
       NSMutableDictionary *btsbtc_ticker = [NSMutableDictionary dictionary];
       btsbtc_ticker = [@{@"event":@"addChannel", @"channel":@"btsbtc_ticker"} mutableCopy];
       [self sendMessage:btsbtc_ticker];
       
       NSMutableDictionary *icxbtc_ticker = [NSMutableDictionary dictionary];
       icxbtc_ticker = [@{@"event":@"addChannel", @"channel":@"icxbtc_ticker"} mutableCopy];
       [self sendMessage:icxbtc_ticker];
       
       
       
       //ZB区----
   //
   //    NSMutableDictionary *vsyszb_ticker = [NSMutableDictionary dictionary];
   //    vsyszb_ticker = [@{@"event":@"addChannel", @"channel":@"vsyszb_ticker"} mutableCopy];
   //    [self sendMessage:vsyszb_ticker];

    
   
}
//ping pong 心跳链接
- (void)SendPangMessage{
    
    
}
#pragma mark   /*******  socket必须实现的代理方法 *********/
//打开socket后根据后端要求传入字典字符串
-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"type":@"login"
//                                                                 } options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"WebSocket DidOpen");
//    [webSocket send:jsonString];
    
    
    NSLog(@"连接成功，可以与服务器交流了,同时需要开启心跳");
    //每次正常连接的时候清零重连时间
    reConnectTime = 0;
    //开启心跳
   // [self initHeartBeat];
   // [[NSNotificationCenter defaultCenter] postNotificationName:kWebSocketDidOpenNote object:nil];

}


//socket接收到信息后通过代理传给外部使用
-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];


    [self.delegate getMessageFromSocket:dic];
  //  NSLog(@"%@",dic);
  
    

    
}


//-(void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean{
//    NSLog(@"WebSocket closed");
//    _webSocket = nil;
//
//
//}
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
    NSLog(@"被关闭连接，code:%ld,reason:%@,wasClean:%d",code,reason,wasClean);
    //断开连接 同时销毁心跳
    [self SRWebSocketClose];
}


//-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
//}

/*该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 我的理解就是建立一个定时器，每隔十秒或者十五秒向服务端发送一个ping消息，这个消息可是是空的
 */
-(void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    
    NSString *reply = [[NSString alloc] initWithData:pongPayload encoding:NSUTF8StringEncoding];
    NSLog(@"reply===%@",reply);
}


//-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
////    NSLog(@":( Websocket Failed With Error %@", error);
////    _webSocket = nil;
//
//    //失败了就去重连
//    [self reConnect];
//}
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    NSLog(@"连接失败，这里可以实现掉线自动重连，要注意以下几点");
    NSLog(@"1.判断当前网络环境，如果断网了就不要连了，等待网络到来，在发起重连");
    NSLog(@"2.判断调用层是否需要连接，例如用户都没在聊天界面，连接上去浪费流量");
    NSLog(@"3.连接次数限制，如果连接失败了，重试10次左右就可以了，不然就死循环了。");
          _webSocket = nil;
          //连接失败就重连
          [self reConnect];
          }

//send数据转化成json字符串
//- (void)sendMessage:(NSDictionary *)messageDic {
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];
//
//    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    [_webSocket send:jsonString];
//
//
//
//
//}
- (void)sendMessage:(NSDictionary *)messageDic {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:messageDic options:NSJSONWritingPrettyPrinted error:&error];

    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

  //  [_webSocket send:jsonString];
    
    
    
    
    WeakSelf(ws);
    dispatch_queue_t queue =  dispatch_queue_create("zy", NULL);
    
    dispatch_async(queue, ^{
        if (weakSelf.webSocket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (weakSelf.webSocket.readyState == SR_OPEN) {
                [weakSelf.webSocket send:jsonString];    // 发送数据
                
            } else if (weakSelf.webSocket.readyState == SR_CONNECTING) {
                NSLog(@"正在连接中，重连后其他方法会去自动同步数据");
                // 每隔2秒检测一次 socket.readyState 状态，检测 10 次左右
                // 只要有一次状态是 SR_OPEN 的就调用 [ws.socket send:data] 发送数据
                // 如果 10 次都还是没连上的，那这个发送请求就丢失了，这种情况是服务器的问题了，小概率的
                [self reConnect];
                
            } else if (weakSelf.webSocket.readyState == SR_CLOSING || weakSelf.webSocket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                [self reConnect];
            }
        } else {
            NSLog(@"没网络，发送失败，一旦断网 socket 会被我设置 nil 的");
        }
    });




}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
