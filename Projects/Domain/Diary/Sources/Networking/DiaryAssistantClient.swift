import Moya

enum AssistantClient {
    case createThread
    case createMessage(threadId: String, dto: CreateMessageRequest)
    case createRun(threadId: String, assistantId: String)
    case fetchOne(threadId: String)
}
