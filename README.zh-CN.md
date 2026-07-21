# Codex Project Harness

Project Harness 是一个面向 Codex 的中英文自适应项目治理 Skill。它用于长期保存项目事实、决策、约束、任务状态、验收证据和协作边界，让软件项目在长对话、任务切换和并行执行中仍然可以可靠恢复。

它为 Codex 提供简洁的项目地图和稳定的事实来源，但不规定每个实现任务必须怎样思考和执行。

[English README](README.md)

## 它管理什么

- 项目知识地图和事实来源
- 需要长期保存的任务与决策
- 产品、架构、契约、授权和发布边界
- 验收证据和明确的下一步行动
- 长对话之间的主控交接
- 并行任务、分支或工作树的协作边界

Project Harness 不要求固定的开发方法、对话数量、分支策略、工作树策略或辅助 Skill。

## 它怎样自适应

Project Harness 会分别判断两个维度：

1. **长期影响**：工作是否因为改变产品行为、包含重要决策、影响共享契约，或者需要跨验收、负责人和对话持续保存而必须记录。
2. **执行结构**：工作适合直接完成、结构化多阶段执行，还是拆成可以协调并行的单元。

很小的产品或技术决定也可能需要长期记录。大型机械修改可能需要结构化执行，但不一定需要永久决策记录。

## 项目结构

默认的治理结构有意保持精简：

```text
AGENTS.md
HARNESS.md
docs/
  tasks.md
  decisions.md
```

产品、架构、API、安全、部署、测试、发布和交接文档只在项目实际需要时创建。Project Harness 会先检查仓库并复用已有同类文件，不建立重复的事实来源。

## 安装

### 不使用终端安装

1. 从[最新 Release](https://github.com/BurnLikeIce/codex-project-harness/releases/latest)下载 Project Harness Skill ZIP。
2. 解压 ZIP。
3. 把 `project-harness` 文件夹复制到 Codex 的 Skills 目录。
4. 重启 Codex。

最终路径必须是：

```text
~/.codex/skills/project-harness/SKILL.md
```

macOS 可以在 Finder 中按 `Command + Shift + G`，输入 `~/.codex/skills`。

Windows 通常放在 `%USERPROFILE%\.codex\skills\project-harness`。

### 使用 Git 安装

克隆仓库，然后把 `skills/project-harness` 复制或链接到 `~/.codex/skills/project-harness`。安装或替换后重启 Codex。

## 快速使用

在项目对话中说：

```text
使用 project-harness 管理这个项目，这个对话作为主控。
```

Project Harness 根据自然语言含义判断，所以类似说法都可以。它会先检查项目、保留已有文件、建立项目地图，并且只创建真正缺少的治理文件。

之后正常沟通即可，例如：

```text
我想和你讨论一下这个功能能不能做。
```

```text
好，就按我们讨论的开始做。
```

```text
验收这些实现结果，并告诉我下一步做什么。
```

长对话需要重新读取当前已安装规则时，可以说：

```text
同步最新的 project-harness。
```

同步对话规则不会修改项目文件。

## 内置脚本

Windows PowerShell：

```powershell
skills/project-harness/scripts/inspect-project.ps1 -ProjectPath <路径>
skills/project-harness/scripts/init-project.ps1 -ProjectPath <路径> -Language zh-CN
skills/project-harness/scripts/validate-project.ps1 -ProjectPath <路径>
```

macOS/Linux：

```bash
skills/project-harness/scripts/inspect-project.sh <路径>
skills/project-harness/scripts/init-project.sh --project-path <路径> --language zh-CN
skills/project-harness/scripts/validate-project.sh <路径>
```

## 开发与验证

```powershell
tests/run-tests.ps1
```

```bash
sh tests/run-tests.sh
```

测试覆盖中英文初始化、项目内容保留、事实来源映射、管理区块幂等更新和结构验证。

## 项目状态

这是一个社区项目，不是 OpenAI 官方项目。

## 许可证

[MIT](LICENSE)
