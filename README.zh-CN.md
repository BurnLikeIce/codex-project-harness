# Codex Project Harness

Project Harness 帮助 Codex 在长期开发和任务切换中，保持项目事实、重要决策、进度和验证依据准确。支持中英文。

Agent 维护项目记录，并根据工作需要选择实现方法。用户可以直接讨论需求、反馈问题和继续项目。

[English README](README.md)

## 它保留什么

- 指向已有需求和技术文档的简洁项目地图。
- 重要决策、未完成工作、阻塞和下一步。
- 区分实现、验证、验收、合并与发布的实际依据。
- 换任务后继续工作所需的上下文。

很小的修改，只要影响后续产品行为或技术选择，也会留下记录。优先更新已有任务和文档，避免把同一内容重复写入多处。恢复工作和收尾时，Agent 会核对记录与实际结果。

执行方法、计划、测试和内部子智能体按需选择，不要求固定执行等级、专项角色或辅助 Skill。

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

## 日常使用

明确接入 Harness 时，可以说：

```text
使用 project-harness 管理这个项目。
```

Agent 会复用已有文档，只补缺少的记录和项目入口，并自动维护任务、决策编号及历史进度。

不需要记住固定口令。普通项目表达可以触发 Skill，项目入口帮助后续任务发现它。讨论和只读审查保持在请求范围内；明确执行后，Agent 完成已授权工作并更新相关记录。

| 你可以说 | 对应行为 |
| --- | --- |
| “这个功能能不能做？” | 讨论可行方案，等明确要求后再实现。 |
| “好，按这样开始做。” | 实现已确定的改动，记录重要结果。 |
| “这里显示不对，修一下。” | 在范围内排查和修复，保留重要决策。 |
| “验收一下结果。” | 说明发现、依据和下一步；尊重只读审查范围。 |
| “同步最新的 project-harness。” | 重新读取本机已安装规则，不修改文件、不下载更新。 |
| “换个新任务继续这个项目。” | 更新状态并通过原生能力交接；不可用时给出接续指令。 |

新任务默认独立，需要继承上下文时可要求派生。旧任务保留，不自动归档或持续监控。工作目录遵循用户要求和原生工具规则，Harness 不按角色批量创建工作树。

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

Agent 在接入或维护项目绑定时按需使用这些脚本，不要求每个任务都运行。

## 开发与验证

```powershell
tests/run-tests.ps1
```

```bash
sh tests/run-tests.sh
```

这些测试供维护者检查会修改文件的脚本，覆盖中英文初始化、内容保护、来源映射、重复更新和结构验证。平时使用 Skill 不会自动运行这套测试。提示词修改以一致性检查和必要的小范围试用为主，不检查固定句子是否出现。

## 项目状态

这是一个社区项目，不是 OpenAI 官方项目。

## 许可证

[MIT](LICENSE)
