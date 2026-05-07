# 项目开发 SOP

## 角色

- 主控对话：集成、Git、GitHub、PR、合并、发布。
- 产品对话：需求、架构、任务拆分、决策。
- 前端对话：UI、组件、页面、客户端行为。
- 后端对话：API、数据库、鉴权、服务端逻辑。
- Bug 对话：聚焦调试和 CI 修复。
- 实验对话：隔离验证不确定方案。

## 事实来源

项目知识必须沉淀到文档：

- `docs/product.md`
- `docs/architecture.md`
- `docs/api-contract.md`
- `docs/tasks.md`
- `docs/completion.zh-CN.md`
- `docs/acceptance.zh-CN.md`
- `docs/decisions.md`
- `docs/changelog.md`

聊天用于讨论和执行，文档用于同步。

## 工作流

1. 产品对话讨论需求。
2. 产品对话更新文档和任务。
3. 主控对话检查任务拆分。
4. 前端/后端对话处理指定任务 ID。
5. 每个功能使用自己的分支或工作树。
6. 功能对话更新文档、提交改动，并按照 `docs/completion.zh-CN.md` 输出任务交付。
7. 产品对话按照 `docs/acceptance.zh-CN.md` 对交付结果给出通过、不通过或有条件通过。
8. 如果不通过或有条件通过，产品对话写出可直接复制给负责对话的返工指令。
9. 如果通过，产品对话把任务交给主控做技术 review 和合并前验证。
10. 主控 review 分支或 PR，运行测试、lint、build，并检查文档。
11. 条件允许时通过 GitHub PR 合并。
12. 主控更新任务状态和 changelog。

## 规则

- 不要把功能改动直接合并进 `main`。
- 不要重复执行 `git init`。
- 不要让多个对话随意修改同一个文件。
- API 变化必须更新 `docs/api-contract.md`。
- 架构决策必须更新 `docs/decisions.md`。
- 功能完成必须使用 `docs/completion.zh-CN.md`。
- 需要验收的任务必须使用 `docs/acceptance.zh-CN.md`。
- 验收不通过时必须包含未通过点、负责对话、需更新文档和可直接复制的返工指令。
- 每个任务都应该有 ID、负责人、分支、状态、依赖和验收标准。
