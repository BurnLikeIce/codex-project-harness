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

## 自然开始

Project Harness 没有必须输入的启动口令。安装后，正常描述项目意图就可以触发，例如：

```text
我想做一个个人记账应用。
```

```text
接着做这个项目，先看看现在的进度。
```

```text
这个功能能不能做？
```

```text
这个页面显示不对，帮我检查一下。
```

Project Harness 会自行判断用户是在讨论、启动、继续、确认实施、反馈问题、验收结果还是交接工作。探索性讨论保持只读；用户明确要求执行后，它才检查项目、保留已有文件，并只创建缺少的治理文件。项目已经有 Harness 入口后，会自动持续使用当前安装的规则。

用户不需要理解“主控”或“专项对话”等内部概念。点选或提到 Project Harness 只会启用规则，本身不代表允许修改项目文件。要明确采用并持久化 Project Harness，可以让它管理项目：

```text
使用 project-harness 管理这个项目。
```

明确采用代表允许 Agent 检查项目并写入最小绑定，而不是只在当前对话里临时启用。Agent 会保留已有 `AGENTS.md` 和项目文档，分别复用已有任务与决策来源，只补缺少的记录文件，验证结果，并返回 `ADOPTED`、`ALREADY_ADOPTED` 或 `BLOCKED`。

采用后，任务和决策记录主要供后续 Agent 使用。当前项目协调者自动分配并预留 `TASK-0001` 和 `DEC-0001` 格式的编号、保留历史、更新状态，并在创建新任务前检查是否存在可以继续、复用或需要处理冲突的相关工作；并行执行单元只使用分配到的编号，不会竞争创建全局编号。用户不需要手动维护。

长对话需要重新读取更新后的规则时，可以说：

```text
同步最新的 project-harness。
```

同步对话规则不会修改项目文件。

普通工作默认留在当前 Codex 任务中。需要单独建立任务时，可以直接说：

```text
新建一个任务做登录页。
```

只有用户明确提出新建、分开、派生或交接时，Project Harness 才会使用 Codex 的原生任务能力。项目内的新任务默认干净、独立，只接收精简的项目上下文；新建任务不会自动创建 Git 分支或工作树，也不要求固定建立产品、前端和后端任务。

需要把整个项目的控制权交给新任务时，可以说“把这个项目交接到一个新任务”。Agent 会先刷新持久状态，再通过原生能力发送交接内容；旧任务会保留，但不会自动跟踪新任务或归档自己。如果原生创建或消息发送不可用，则返回 `READY_TO_HANDOFF` 和一条可以直接使用的启动指令。

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
