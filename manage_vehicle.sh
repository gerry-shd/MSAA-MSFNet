#!/bin/bash

# 读取第二个参数作为 Python 文件名
APP_NAME=$2

if [ -z "$APP_NAME" ]; then
    echo "❌ 请输入 Python 文件名，例如: $0 start vehicle_recog_feiyi_final_v3_local_test.py"
    exit 1
fi

# 动态生成日志文件名：把 .py 替换为 .log
LOG_FILE="${APP_NAME%.py}.log"
PID_FILE="${APP_NAME%.py}.pid"

start() {
    if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "⚠️ 进程已运行 (PID: $(cat $PID_FILE))"
    else
        echo "🚀 启动: $APP_NAME"
        nohup python3 -u "$APP_NAME" > "$LOG_FILE" 2>&1 &
        echo $! > "$PID_FILE"
        echo "✅ 已启动 (PID: $(cat $PID_FILE))，日志: $LOG_FILE"
    fi
}

stop() {
    if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "🛑 停止进程 (PID: $(cat $PID_FILE))..."
        kill $(cat "$PID_FILE")
        rm -f "$PID_FILE"
        echo "✅ 已停止"
    else
        echo "⚠️ 进程未运行"
    fi
}

restart() {
    stop
    sleep 1
    start
}

status() {
    if [ -f "$PID_FILE" ] && kill -0 $(cat "$PID_FILE") 2>/dev/null; then
        echo "✅ 正在运行 (PID: $(cat $PID_FILE))，日志: $LOG_FILE"
    else
        echo "⚠️ 未运行"
    fi
}

case "$1" in
    start) start ;;
    stop) stop ;;
    restart) restart ;;
    status) status ;;
    *) echo "用法: $0 {start|stop|restart|status} filename.py" ;;
esac
