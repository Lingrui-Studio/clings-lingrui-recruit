#!/bin/sh
# GitHub Classroom autograding 逐题判分脚本
# 用法: bash bin/grade.sh <exercise-name>
# 返回 0 = 通过，1 = 失败（与 `clings check` 一致）
# 说明: autograding 只跑公开测试做快速反馈;隐藏测试由工作室在截止后集中判分
set -eu
exercise="${1:?usage: bash bin/grade.sh <exercise-name>}"
clings check "$exercise"
