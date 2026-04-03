# Prompt 2 Implement the full scaffold

Now implement the full project following the architecture defined previously.

GOAL
Build a functional “AI Assistant” style web application that can connect to an MCP server, with a professional dark UI and a codebase ready to work with database-oriented tools.

GENERAL REQUIREMENTS
- generate the complete project structure
- use the stack chosen in the previous phase
- include frontend and backend if needed
- clean, modular, maintainable code
- properly typed TypeScript
- a README.md with setup and run instructions
- documented environment variables
- modern, dark, professional UI

REQUIRED FEATURES

1. Left sidebar
Implement a sidebar with these sections:

- Connection
  - MCP URL input
  - “Enable JWT tokens” toggle
  - JWT token field visible only when enabled
  - connection status indicator

- LLM Model
  - model selector
  - “Show citations” toggle

- Document
  - placeholder block prepared for PDF upload, even if initially mocked

- Actions
  - Connect / Reload tools
  - Clear chat history

2. Main panel
Implement:

- main title: “AI Assistant”
- conversation area
- bottom input for user questions
- available tools table

3. Tools table
The table must display:
- Category
- Tool (function)
- Description

It should be populated either from real MCP-discovered tools or from mock data if no real connection exists yet.

4. Chat
Implement:
- user messages
- assistant messages
- loading state
- conversation history
- support for rendering:
  - plain text
  - JSON
  - tables
  - errors
  - tool call logs

5. Tool call panel
Every time the assistant invokes a tool, visually show:
- tool name
- parameters
- status
- summarized or full result

6. Database-agent readiness
The app must be structured to support tools such as:
- generate_sql
- execute_sql
- search
- get_collections
- get_documents_in_collection
- internet_search
- call_history

Even if some of these are mocked at first, the architecture should already be ready to integrate them properly.

7. Mock mode
If no real MCP server is available at runtime:
- use well-structured mock data
- simulate available tools
- simulate at least one tool execution so the UI can be tested end-to-end

VISUAL DESIGN
I want the UI to feel close to the reference screenshot:
- dark mode
- narrow left sidebar
- large main panel
- elegant table
- subtle borders
- technical / enterprise / modern developer-tool aesthetic
- readable typography
- strong spacing and layout

DELIVERABLES
Generate:
1. directory tree
2. all project files
3. README.md
4. .env.example
5. mock tool data
6. reusable components
7. a brief explanation of how to replace mocks with real MCP integration

WORKING STYLE
Build the project file by file, starting with:
1. folder tree
2. config files
3. types and models
4. main layout
5. sidebar
6. tools table
7. chat panel
8. mock services
9. README