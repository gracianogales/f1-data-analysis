# Prompt 6 - Agent 

Now I want to evolve the application from a simple tool-enabled chat into a true data agent connected through MCP to a database.

GOAL
Turn the app into an agent capable of helping a user explore and analyze database data through natural language using MCP tools.

DESIRED AGENT BEHAVIOR
The assistant should follow a reasonable flow like this:

1. understand the user’s intent
2. decide whether SQL needs to be generated
3. generate the SQL
4. review the generated query
5. execute the SQL when appropriate
6. interpret the results
7. return a clear and useful answer
8. show process traceability

EXPECTED CAPABILITIES
- answer questions about data
- generate safe and reasonable SQL
- execute queries
- summarize results
- display tables
- explain what it did
- optionally chain semantic search or document exploration if those tools exist

IMPORTANT RULES
- avoid executing dangerous SQL by default
- if destructive instructions are detected, require confirmation
- limit the number of returned rows by default
- handle empty or ambiguous queries
- clearly explain which tool was used and why

UI IMPROVEMENTS
Add a more “data agent” style experience:
- Plan panel or badge
- Tools used section
- visible, collapsible generated SQL
- elegant tabular results
- executive summary of findings
- staged states such as:
  - Understanding request
  - Generating SQL
  - Executing query
  - Summarizing result

EXPECTED OUTPUT
1. agent architecture proposal
2. orchestration strategy
3. agent rules
4. required frontend and backend changes
5. complete implementation

IMPORTANT
I want the result to feel much closer to a database copilot or data analyst assistant than to a generic chatbot.