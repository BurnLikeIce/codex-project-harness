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
- 对旧版 Project Harness 项目的兼容更新

Project Harness 不要求固定的开发方法、对话数量、分支策略、工作树策略或辅助 Skill。

## 自适应判断

Project Harness 会分别判断两个维度：

1. **长期影响**：工作是否因为改变产品行为、包含重要决策、影响共享契约，或者需要跨验收、负责人和对话持续保存而必须记录。
2. **执行结构**：工作适合直接完成、结构化多阶段执行，还是拆成可以协调并行的单元。

很小的产品或技术决定也可能需要长期记录。大型机械修改可能需要结构化执行，但不一定需要永久决策记录。

## 新项目最小结构

新项目默认只创建：

```text
AGENTS.md
HARNESS.md
docs/
  tasks.md
  decisions.md
```

产品、架构、API、安全、部署、测试、发布和交接文档只在项目实际需要时创建。已有同类文件会直接复用，不建立重复的事实来源。

## 安装

### 不使用终端安装

1. 从 GitHub 下载仓库 ZIP。
2. 解压 ZIP。
3. 把 `skills/project-harness` 文件夹复制到 Codex 的 Skills 目录。
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

Project Harness 根据自然语言含义判断，不要求一字不差地输入下面的句子。

### 新项目

```text
按照 project-harness 启动这个项目，这个对话作为主控。
```

### 已有项目

```text
让这个旧项目开始使用 project-harness，保留现有文件，这个对话作为主控。
```

### 同步当前对话

```text
同步最新的 project-harness。
```

这个操作只让当前对话重新读取最新规则，不能修改项目文件。

### 更新旧版 Harness 项目

```text
更新当前项目的 project-harness。
```

这个操作执行原地兼容更新。它保留现有文件和自定义内容，只更新 `HARNESS.md` 和 `AGENTS.md` 中带有明确标记的 Harness 管理区块。

### 可选的结构迁移

```text
把这个项目迁移到最新的 Harness 结构。
```

迁移不是必需操作。移动、合并、归档或删除文件之前，Codex 必须先检查并提出方案。

## 更新不等于迁移

使用 V1 创建的项目不需要重新整理文档，也能继续使用最新 Project Harness。V2 可以理解 V1 的文件结构，并映射已有的任务、决策、产品、架构、API、验收、交接和流程文件。

原地更新脚本可以重复执行，不会修改管理区块之外的内容。在项目状态和 Skill 版本不变时，重复更新不会产生新的差异。

## 内置脚本

Windows PowerShell：

```powershell
skills/project-harness/scripts/inspect-project.ps1 -ProjectPath <路径>
skills/project-harness/scripts/init-project.ps1 -ProjectPath <路径> -Language zh-CN
skills/project-harness/scripts/update-project.ps1 -ProjectPath <路径> -Language zh-CN
skills/project-harness/scripts/validate-project.ps1 -ProjectPath <路径>
```

macOS/Linux：

```bash
skills/project-harness/scripts/inspect-project.sh <路径>
skills/project-harness/scripts/init-project.sh --project-path <路径> --language zh-CN
skills/project-harness/scripts/update-project.sh --project-path <路径> --language zh-CN
skills/project-harness/scripts/validate-project.sh <路径>
```

## 开发与验证

```powershell
tests/run-tests.ps1
```

```bash
sh tests/run-tests.sh
```

测试覆盖中英文最小初始化、V1 自定义内容保留、事实来源映射、原地更新幂等性和管理结构验证。

## 项目状态

Harness 2.0 是当前正式版本。旧版基线保存在 `v1.0.0` Git 标签中。

这是一个社区项目，不是 OpenAI 官方项目。

## 许可证

[MIT](LICENSE)
