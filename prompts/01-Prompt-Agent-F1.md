# Prompt 1: Architecture & design

Act as a senior software architect specializing in MCP-based agent applications (Model Context Protocol), chat interfaces, and database-connected tools.

I need to design a web application similar to an “AI Assistant” connected through MCP to a database. I do NOT want code implementation yet. At this stage I only want architecture, technical design, project structure, and interaction flow.

GOAL
Design a web application that can:

1. Connect to an MCP server through a configurable URL
2. Discover the tools exposed by the MCP server
3. Display those tools in a table with category, function name, and description
4. Let the user chat with an LLM capable of invoking MCP tools
5. Show tool-call results as part of the conversational experience
6. Be especially suited for tools related to databases, SQL, vector search, and document search

MAIN USE CASE
I want a data agent that acts as an assistant connected to a database through MCP, able to:

- discover tools from the MCP server
- invoke tools such as generate_sql, execute_sql, search, get_collections, get_documents_in_collection, etc.
- answer in a chat interface
- present tables and results clearly
- serve as a polished professional technical demo

VISUAL REFERENCE
Use an application with a layout similar to this:

- Left sidebar
  - Connection
  - MCP URL
  - Enable JWT tokens option
  - LLM model selector
  - Show citations option
  - Optional document/upload block
  - Connect / Reload tools button
  - Clear chat history button

- Main panel
  - Title: “AI Assistant”
  - Conversation area
  - Available tools table
  - Bottom input box for user questions

The overall look and feel should be dark, modern, technical, and professional.

FUNCTIONAL REQUIREMENTS
The application should support at minimum:

1. Connection configuration
- MCP URL field
- button to connect to the MCP server
- optional JWT token support
- connection status indicator
- reload tools action

2. LLM model
- model selector
- abstraction layer for connecting to the LLM backend
- ability to switch provider or endpoint easily

3. Tool discovery
- fetch the list of tools from MCP
- normalize metadata
- display:
  - category
  - tool/function
  - description
- support automatic grouping or categorization of tools

4. Chat agent
- user input
- conversation history
- assistant responses
- ability to invoke MCP server tools
- clear visualization of when a tool is called
- clear visualization of tool outputs

5. Result presentation
- tables for SQL results
- preformatted JSON blocks
- elegant error messages
- loading indicators
- traceability of which tool was executed

6. Database-oriented behavior
The app should be particularly suited for scenarios such as:
- generating SQL from natural language
- executing SQL
- semantic search
- browsing document collections
- analyzing returned results

TECHNICAL DECISIONS
Choose the most appropriate stack for building this app with strong UX and fast iteration speed. Prefer one of these:

- React + TypeScript + Tailwind
- Next.js + TypeScript + Tailwind
- another equivalent option, only if you justify it clearly

Include a backend if needed for:
- MCP proxying
- model integration
- token handling
- chat-agent orchestration

EXPECTED OUTPUT
Return exactly these sections:

1. Proposed stack
2. Overall system architecture
3. Frontend components
4. Backend components
5. MCP connection flow
6. Chat flow with tool invocation
7. Project folder structure
8. Data model / main types
9. Tool categorization strategy
10. Result rendering strategy
11. Technical risks and mitigations
12. Phased implementation plan

IMPORTANT
- Do not implement anything yet
- Think in terms of a professional product, not a toy prototype
- Prioritize clarity, modularity, and demo quality
- The app should feel ideal for a database-connected MCP data agent