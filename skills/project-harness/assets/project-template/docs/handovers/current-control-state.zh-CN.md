# 当前主控迁移状态

更新时间：YYYY-MM-DD

本文是当前主控/主产品对话的迁移快照。新的主控对话接手项目前，先读取本文。

## 当前工作模式

- 默认模式：
- 当前角色：
- 协作方式：

## 项目路径

```text
<项目路径>
```

## Git 状态快照

开始新任务前先运行：

```text
git status --short --branch
git diff --name-status
```

最近一次已知快照：

```text
branch:
HEAD:
remote status:
working tree:
```

## 当前版本或里程碑

- 目标：
- 范围：
- 不做：

## 已完成任务

- `<TASK-ID>`：

## 正在进行的任务

- `<TASK-ID>`：

## 未提交或未跟踪改动

- `<路径>`：

## 关键决策

- `<日期>`：

## 安全边界

- 未经用户明确确认，不推送、不上线、不改生产数据、不删除分支、不删除 worktree。
- 迁移或刷新 harness 时，不覆盖已有项目文档。
- 实现或发布前重新检查 Git 状态。

## 下一步建议

1. 重新检查 Git 状态。
2. 确认下一个任务或产品决策。
3. 范围变化时，先更新任务/决策文档，再进入实现。

## 新主控对话启动提示词

```text
你是这个项目新的主控/主产品对话。

请读取：
- <项目路径>/docs/handovers/current-control-state.zh-CN.md
- <项目路径>/HARNESS.md
- <项目路径>/docs/single-conversation-harness.zh-CN.md
- <项目路径>/docs/tasks.md
- <项目路径>/docs/decisions.md

先只做角色初始化和状态复述。不要改代码、不要推送、不要上线、不要清理分支或 worktree。
```
