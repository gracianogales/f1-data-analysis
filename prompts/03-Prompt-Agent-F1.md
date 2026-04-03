# Prompt 3 real MCP Integration

Now I want to replace mock mode with a real MCP integration.

CONTEXT
The application already has the base UI. Now I need to implement a real connection to an MCP server configurable by URL.

GOAL
Implement a real MCP client so the application can:

- connect to an MCP server through a URL
- optionally authenticate with JWT
- discover available tools
- invoke tools
- return tool results into the chat

TECHNICAL REQUIREMENTS
- analyze the best way to integrate MCP into this stack
- if necessary, implement an intermediate backend or proxy
- abstract the MCP layer into a clean service
- support reconnection and tool reload
- handle errors and timeouts elegantly

REQUIRED FEATURES

1. MCP connection service
Implement a service that:
- receives the MCP URL
- receives an optional JWT token
- initializes the connection
- checks availability
- retrieves the list of tools

2. Tool discovery
Implement real tool discovery from MCP and transform the response into a UI-friendly format:
- id
- category
- functionName
- description
- schema or parameters, when available

3. Tool execution
Implement real invocation of MCP tools from the backend or other appropriate layer.

It should support example tools such as:
- generate_sql
- execute_sql
- search
- get_collections
- get_documents_in_collection

4. Chat orchestration
Implement the logic so the assistant:
- receives a user question
- decides whether a tool is needed
- invokes the tool
- incorporates the result into the final answer
- shows traceability in the UI

5. Security / config
- optional JWT
- environment-variable based configuration
- do not expose unnecessary secrets in the frontend

6. Error handling
Handle:
- connection errors
- tool errors
- empty responses
- malformed JSON
- timeout / unavailable server

IMPORTANT
Before implementing, explain:
1. how you will integrate MCP in this stack
2. which libraries or SDKs you will use
3. what belongs in the frontend vs backend
4. how tool discovery and tool invocation will work

Then implement all required changes file by file.

Also include example payloads and how to test against a local server such as:
http://localhost:6000/mcp