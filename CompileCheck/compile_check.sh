#!/bin/bash

# 删除缓存目录
rm -rf .cache

# 执行编译
xcodebuild -workspace CompileCheck.xcworkspace -scheme CompileCheck -derivedDataPath "./.cache" -sdk iphonesimulator -configuration Debug clean build | sed -nE '/error:/,/^[[:digit:]] errors? generated/ p'