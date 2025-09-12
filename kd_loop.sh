#!/bin/bash

echo "KD 词典交互式 Bash 脚本"
echo "输入 'exit' 退出脚本"
echo "-----------------------------"

# 设置 kd 程序路径
# 注意：Mac 系统下通常不使用 .exe 扩展名
KD_PATH="./build/kd"

# 如果 kd 程序不存在，尝试在当前目录查找
if [ ! -f "$KD_PATH" ]; then
    KD_PATH="./kd"
fi

# 检查 kd 程序是否存在
if [ ! -f "$KD_PATH" ]; then
    echo "错误：找不到 kd 程序。请确保它已编译并位于 build 目录或当前目录中。"
    exit 1
fi

# 确保 kd 程序有执行权限
chmod +x "$KD_PATH"

while true; do
    # 提示用户输入
    read -p "请输入查询内容: " query
    
    # 检查是否退出
    if [ "$query" = "exit" ]; then
        echo "感谢使用，再见！"
        break
    fi
    
    echo ""
    echo "正在查询: $query"
    echo "-----------------------------"
    
    # 调用 kd 程序并传递查询参数
    "$KD_PATH" "$query"
    
    echo "-----------------------------"
    echo ""
done