# 旧项目迁移 / 接管规则

当用户希望用 project-harness 接管、迁移、整理或规范一个已有项目时，使用这个文档。

用户的提示可以很短，例如：

```text
使用最新 project-harness 接管这个旧项目。本对话作为主控。先检查并给迁移计划，不要覆盖已有文档。
```

类似自然表达也有效。

## 迁移规则

- 除非用户另有说明，当前对话就是主控/集成对话。
- 不要覆盖、删除、重写已有文档。
- 不要重复 `git init`。
- 迁移阶段不要直接修改业务代码。
- 优先用索引、链接、补充小节，而不是替换已有文档。
- 如果现有文档和 harness 模板冲突，保留现有文档，并提出合并建议。
- 先检查并给迁移计划。大量改文件前必须等待用户确认。

## 检查清单

检查：

- 当前目录结构。
- Git 状态、当前分支、工作区改动、remote、默认分支。
- 现有 README、docs、`.github`、prompts、部署、测试、设计、运维文档。
- 如果可见，检查现有 GitHub Issue/PR 流程。
- 判断项目当前阶段：需求澄清、开发中、待验收、待合并、已发布、维护中。

把现有文档分类为：

- 产品
- 架构
- API
- 任务
- 决策
- 部署
- 运维
- 设计
- 测试
- 验收
- 发布

## Harness 缺口分析

对比当前项目和最新版 harness 标准文件：

- `HARNESS.md`
- `README.md` / `README.zh-CN.md`
- `docs/sop.md` / `docs/sop.zh-CN.md`
- `docs/product.md`
- `docs/architecture.md`
- `docs/api-contract.md`
- `docs/tasks.md`
- `docs/intent.md` / `docs/intent.zh-CN.md`
- `docs/migration.md` / `docs/migration.zh-CN.md`
- `docs/dispatch.md` / `docs/dispatch.zh-CN.md`
- `docs/triage.md` / `docs/triage.zh-CN.md`
- `docs/completion.md` / `docs/completion.zh-CN.md`
- `docs/acceptance.md` / `docs/acceptance.zh-CN.md`
- `docs/decisions.md`
- `docs/changelog.md`
- `prompts/*.md` / `prompts/*.zh-CN.md`
- `.github/pull_request_template.md`
- `.github/ISSUE_TEMPLATE/*`

逐项判断：已存在、缺失、已有等价文档替代、应该新增、还是只需要索引链接。

## 迁移计划输出

改文件前，先输出：

```md
## 迁移计划

当前状态：
-

现有文档：
- <文件>：<分类和作用>

Harness 缺口：
- 缺失：
- 已有文档覆盖：
- 作为索引/链接：
- 新增模板：

建议改动：
- 保持不变：
- 新增：
- 追加小节：
- 建立索引：

流程接入：
- 自然语言意图识别：
- 需求分发：
- 问题分流：
- 任务交付：
- 产品验收：
- 主控 review/合并：

建议对话：
- 产品：
- 前端：
- 后端：
- Bugfix：
- 实验：

风险 / 问题：
-
```

## 用户确认后

用户确认后：

- 补充缺失 harness 文件，但不覆盖已有文档。
- 创建 `HARNESS.md` 或 `docs/index.md`，指向已有事实来源文档。
- 新增或更新 `prompts/` 角色文件。
- 安全时，把已知活跃任务整理进 `docs/tasks.md`。
- 保持改动小步、可 review。
- 最后汇报改了哪些文件、Git 状态、事实来源文档、建议新建哪些对话、还有哪些风险。
