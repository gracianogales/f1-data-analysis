# Prompt 5 Add tool search internet

Now I want to add a new MCP tool to the current server. I only want to implement a web search tool.

GOAL
Create an MCP tool called search_internet so the agent can perform web searches and return structured results.

CONTEXT
There is already an MCP server with other tools. I want to extend that server with a new internet-search tool.

The tool must:
- follow MCP conventions
- be automatically discoverable by the agent
- include name, description, and input schema
- return structured results that are easy to render in the UI

TOOL NAME
search_internet

CATEGORY
Internet Search

DESCRIPTION
Perform an internet search and return relevant results with title, snippet, and URL.

PARAMETERS
The tool must support at least:

- query (string, required)
  Description: search query in natural language

- num_results (integer, optional, default 5)
  Description: maximum number of results to return

- language (string, optional)
  Description: preferred result language, for example "en" or "es"

- safe_search (boolean, optional, default true)
  Description: whether to enable safe-search filtering

EXPECTED RESPONSE
The tool should return a structured object like this:

- query
- results_count
- results: array of objects containing:
  - title
  - snippet
  - url
  - source (optional)

If an error occurs, return a structured error that the agent can handle gracefully.

IMPLEMENTATION
I want you to analyze the best way to implement this tool.

You may use:
- an external search API
- an open-source library
- a simple reusable wrapper

Prioritize an implementation that is:
- clear
- extensible
- easy to configure
- easy to test

If you use an external API:
- use environment variables for keys and configuration
- do not hardcode secrets
- document configuration clearly

TECHNICAL REQUIREMENTS
1. Add the MCP tool definition
2. Add its JSON input schema
3. Implement the real handler
4. Handle errors and timeouts
5. Add basic logging
6. Return consistent results
7. Ensure the agent discovers it automatically if dynamic discovery already exists

QUALITY REQUIREMENTS
- clean code
- clear naming
- proper error handling
- predictable responses
- easy maintenance

EXPECTED OUTPUT
Generate:
1. tool design
2. full MCP schema
3. handler implementation
4. required server changes
5. example response
6. example invocation
7. required environment variables
8. testing instructions

IMPORTANT
Before implementing:
1. explain which search strategy you will use
2. justify the chosen library or API
3. explain how you will integrate the tool into the existing MCP server

Then implement all changes file by file.