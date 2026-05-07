# Harness 同步 / 刷新规则

当用户要求任何一个对话同步、刷新、更新或继续使用最新版 project-harness 规则时，使用这个文档。

典型短提示：

```text
同步最新 project-harness skill。
```

类似自然表达也有效。

## 硬边界

同步分成两种完全不同的动作：

- 对话规则刷新：任何对话都可以做。
- 项目 harness 文件刷新：只有主控/集成对话可以做。

非主控对话不能因为用户说“同步最新 project-harness skill”就修改 `docs/`、`prompts/`、`HARNESS.md`、README、`.github` 等 harness 文件。

如果非主控对话发现项目 harness 文档缺失或过期，只能输出可复制给主控对话的指令，不要自己改文件。

## 对话规则刷新

任何对话都可以刷新自己的行为。

当用户要求同步最新 project-harness skill 时：

- 先判断当前对话角色：主控、产品、前端、后端、Bugfix、实验或其他。
- 如果项目里有对应 `prompts/` 文件，读取或遵循对应角色提示词。
- 使用和当前角色相关的流程文档：
  - `docs/intent.zh-CN.md`
  - `docs/dispatch.zh-CN.md`
  - `docs/triage.zh-CN.md`
  - `docs/completion.zh-CN.md`
  - `docs/acceptance.zh-CN.md`
  - `docs/migration.zh-CN.md`
- 后续工作按最新规则继续。
- 除非当前对话是主控/集成对话，并且用户明确要求更新项目 harness 文档，否则不要修改 harness 文件。

## 项目 Harness 文件刷新

只有主控/集成对话负责。

当主控对话被要求更新当前项目的 harness 文档时：

- 检查当前 `docs/`、`prompts/`、`HARNESS.md`、README 和 `.github`。
- 对比最新版 project-harness 模板。
- 不要覆盖已有文档。
- 如果改动不只是很小的补缺，先给更新计划。
- 对缺失模板进行补充；如果已有文档已覆盖内容，则创建索引/链接文件。

## 非主控升级指令

如果产品/前端/后端/Bugfix/实验对话发现项目 harness 文件需要更新，输出：

```text
请把这段发给主控/集成对话：

同步最新 project-harness skill，并检查当前项目的 harness 文档是否需要更新。
不要覆盖已有文档；如果需要更新，请先给计划。
```

## 输出

刷新后简短说明：

- 已识别角色：
- 已启用的规则/文档：
- 是否需要项目文件刷新：
- 建议下一步：
