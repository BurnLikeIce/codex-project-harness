# Codex Project Harness

一个中英文通用的 Codex Skill，用来管理软件项目：单主控对话、可选专项对话、共享文档、任务 ID、Git 分支、worktree、GitHub PR 和合并流程。

这是一个实验性的 Codex 工作流模板。它可以帮助你启动新项目、迁移已有项目，把日常工作收敛到一个长期主控对话里，并且只在确实有用时才创建专项对话。

## 它能做什么

- 把项目第一个对话变成主控/集成对话。
- 支持“单主对话 Harness 模式”：产品讨论、实现、验收和发布决策优先在一个主控对话里完成。
- 提供“主控迁移包”模板，方便长对话迁移到新的主控对话。
- 创建共享项目文档：产品、架构、API 约定、任务、决策、changelog。
- 提供不同角色的提示词：主控、产品、前端、后端、Bug/CI、实验。
- 标准化 Git/GitHub 分支、worktree、PR、review、合并流程。
- 提供英文和中文模板。

## 仓库结构

```text
codex-project-harness/
  README.md
  README.zh-CN.md
  LICENSE
  skills/
    project-harness/
      SKILL.md
      agents/
      assets/
      references/
      scripts/
```

## 安装

把这个文件夹：

```text
skills/project-harness
```

复制到你的本地 Codex skills 目录：

```text
~/.codex/skills/project-harness
```

然后重启 Codex。

最终路径应该是：

```text
~/.codex/skills/project-harness/SKILL.md
```

## Mac 不用终端的安装方法

1. 在 GitHub 下载这个仓库的 ZIP。
2. 解压 ZIP。
3. 打开 Finder。
4. 按 `Command + Shift + G`。
5. 输入：

```text
~/.codex/skills
```

6. 从解压后的仓库里找到 `skills/project-harness` 文件夹。
7. 把 `project-harness` 文件夹拖进 `~/.codex/skills`。
8. 重启 Codex。

请确认最终路径是：

```text
~/.codex/skills/project-harness/SKILL.md
```

而不是：

```text
~/.codex/skills/project-harness/project-harness/SKILL.md
```

## 使用方法

新项目的第一个对话里说：

```text
请使用 project-harness skill 启动这个新项目。
从现在开始，本对话就是项目主控/集成对话。
项目名是：<你的项目名>
我使用 Git 和 GitHub。
```

默认使用单主对话 Harness 模式。只有需要并行、隔离或降低风险时，才创建前端/后端/Bugfix 等专项对话。

已有项目迁移时说：

```text
请使用 project-harness skill，把当前已有项目迁移到项目 harness 工作流里。
不要覆盖已有文档，先检查项目并提出迁移计划。
从现在开始，本对话就是项目主控/集成对话。
```

## 对话分工

- 默认：一个长期主控/主产品对话在同一线程里切换产品、主控、实现、验收、发布和迁移模式。
- 可选：产品、前端、后端、Bugfix、实验对话仍可用于大型、高风险或并行任务。
- worktree 是可选隔离工具，不是每个任务的默认动作。
- 主控对话太长时，使用 `docs/handovers/current-control-state.zh-CN.md` 迁移到新的主控对话。

## 核心规则

聊天负责讨论和执行，文档负责同步。

产品或架构讨论出结论后，先更新项目文档。确实需要专项对话时，再用简短任务 ID 交接，例如：

```text
前端：读取 prompts/frontend.zh-CN.md，处理 docs/tasks.md 里的 FE-001。
后端：读取 prompts/backend.zh-CN.md 和 docs/api-contract.md，处理 BE-001。
```

不要在多个对话之间复制大段聊天记录。

## License

MIT
