# Codex Project Harness

一个中英文通用的 Codex Skill，用来管理“多对话协作”的软件项目：共享文档、角色提示词、Git 分支、GitHub PR 和合并流程。

这是一个实验性的 Codex 工作流模板。它可以帮助你启动新项目、迁移已有项目，并让多个 Codex 对话围绕同一套项目文档协同工作，而不是互相复制大段聊天记录。

## 它能做什么

- 把项目第一个对话变成主控/集成对话。
- 创建共享项目文档：产品、架构、API 约定、任务、决策、changelog。
- 提供不同角色的提示词：主控、产品、前端、后端、Bug/CI、实验。
- 标准化 Git/GitHub 分支、PR、review、合并流程。
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

已有项目迁移时说：

```text
请使用 project-harness skill，把当前已有项目迁移到多对话协作框架里。
不要覆盖已有文档，先检查项目并提出迁移计划。
从现在开始，本对话就是项目主控/集成对话。
```

## 对话分工

- 主控/集成对话：Git、GitHub、PR、合并、发布、整体协调。
- 产品/架构对话：需求、架构、任务拆分、决策。
- 前端对话：页面、组件、样式、交互、客户端行为。
- 后端对话：API、数据库、鉴权、服务端逻辑、后端测试。
- Bug/CI 对话：聚焦调试和失败检查。
- 实验对话：隔离验证不确定方案。

## 核心规则

聊天负责讨论和执行，文档负责同步。

产品或架构讨论出结论后，先更新项目文档，再用简短任务 ID 交接，例如：

```text
前端：读取 prompts/frontend.zh-CN.md，处理 docs/tasks.md 里的 FE-001。
后端：读取 prompts/backend.zh-CN.md 和 docs/api-contract.md，处理 BE-001。
```

不要在多个对话之间复制大段聊天记录。

## License

MIT
