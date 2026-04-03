# Prompt 4 Integration mcp sqlcl

Now I want to replace mock mode with a real MCP integration specifically targeting a SQLcl MCP Server for Oracle Database.

CONTEXT
The application already has the base UI. Now I need to implement a real connection to an MCP server configurable by URL, with special focus on compatibility with a SQLcl MCP server.

GOAL
Implement a real MCP client so the application can:

- connect to an MCP server through a URL
- optionally authenticate with JWT
- discover the real tools exposed by the server
- invoke real MCP tools
- return results to the chat
- act as an Oracle Database query assistant

IMPORTANT
Do not assume tool names that may not exist.

The implementation must dynamically discover the real tools exposed by the SQLcl MCP Server and adapt to them.

If the server exposes tools such as Connect, Disconnect, RunSQL, RunSQLCL, or equivalent names, use those. If the real names differ, use the actual discovered tool names.

TECHNICAL REQUIREMENTS
- analyze the best way to integrate MCP into this stack
- if necessary, implement an intermediate backend or proxy
- abstract the MCP layer cleanly
- support reconnection and tool reload
- handle errors and timeouts gracefully
- prioritize real SQLcl MCP compatibility over over-engineered abstractions

REQUIRED FEATURES

1. MCP connection service
Implement a service that:
- receives the MCP URL
- receives an optional JWT token
- initializes the connection
- checks availability
- retrieves the real list of tools from the MCP server
- stores useful metadata for the UI

2. Tool discovery
Implement real tool discovery from MCP and transform the response into a UI-friendly format:
- id
- category
- functionName
- description
- schema or parameters, when available
- original raw tool name
- inferred capability type (connection, sql, sqlcl, metadata, utility)

Categorization should be inferred automatically from the tool name, description, or schema.

3. Tool execution
Implement real invocation of MCP tools from the backend or appropriate layer.

The app should especially support tools related to:
- database connection
- SQL execution
- SQLcl command execution
- metadata inspection or querying, if available

If the server exposes tools equivalent to:
- Connect
- Disconnect
- RunSQL
- RunSQLCL
or similar, integrate them correctly.

4. Chat orchestration
Implement the logic so the assistant:
- receives a user question
- decides whether a tool is needed
- selects the appropriate tool based on the actually discovered tools
- invokes the tool
- incorporates the result into the final response
- shows traceability in the UI

The flow should support cases such as:
- querying Oracle Database data
- listing tables or metadata when such tools exist
- executing a SQL query
- executing SQLcl when needed
- explaining query results

5. Oracle Database assistant behavior
The application should behave like an Oracle Database assistant:
- if the user asks a natural-language question about data, try to translate it into SQL reasonably
- if a dedicated SQL tool exists, use it
- if there is no SQL-generation tool, the backend may use the LLM to propose SQL and then execute it with the corresponding SQL tool
- show the generated SQL clearly before or during execution
- render tabular results properly
- summarize the results for the user

6. Security / config
- optional JWT
- environment variables for configuration
- do not expose unnecessary secrets in the frontend
- keep sensitive credentials out of the UI if the MCP server already manages its own database connection
- clearly document which credentials are expected in the frontend and which are not

7. Error handling
Handle:
- connection errors
- tool errors
- empty responses
- malformed JSON
- timeout / unavailable server
- SQL errors
- SQLcl errors
- tools not found
- incomplete parameter schemas

8. SQL result rendering
Implement elegant rendering for:
- tabular results
- success messages
- Oracle errors
- SQLcl text blocks
- raw JSON when that is the best possible fallback

9. Debugging / observability
Add enough logging and traceability to debug:
- MCP connection
- discovered tools
- selected tool
- parameters sent
- response received
- errors

IMPORTANT
Before implementing, explain:
1. how you will integrate MCP into this stack
2. which libraries or SDKs you will use
3. what belongs in frontend vs backend
4. how tool discovery and invocation will work
5. how you will adapt the app specifically to SQLcl MCP
6. how you will handle differences between real tool names and UI categories

Then implement all required changes file by file.

Also include:
- examples of real or plausible payloads
- examples of tool invocation
- how to test against a local server such as http://localhost:6000/mcp
- how to validate that RunSQL or an equivalent tool works correctly