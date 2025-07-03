# The AI Code Cartographer: A Prompt for Self-Generating Knowledge Graphs

This repository contains a single, powerful prompt designed to be given to an AI coding agent (like Cursor, Aider, or a sufficiently capable GPT-4/Claude instance with shell access). The agent will perform a deep analysis of your codebase and generate a self-contained, interactive `knowledge_graph.html` report.

The goal is to provide developers with a zero-setup, instant way to visualize their code's architecture, understand its key components, and receive actionable refactoring advice, all driven by a "pure LLM" approach.

## Small python app example
<img width="1757" alt="2025-07-02_15-59-37" src="https://github.com/user-attachments/assets/76dc8ca1-8734-4d13-b7f1-5e3de09912af" />

## Key Features

-   **🧠 Pure LLM Analysis:** Requires no external parsers or complex dependencies. The agent uses its own native code-reading abilities.
-   **📄 Single-File Interactive Report:** Generates a `knowledge_graph.html` file that works in any modern browser without needing a server or database.
-   **🗺️ Visual Knowledge Graph:** Creates a structured Mermaid.js diagram showing files, functions, classes, and their relationships.
-   **🤖 Actionable Refactoring Advice:** The report includes a sidebar with analysis on orphan code, stale files, and architectural suggestions.
-   **🌐 Language-Agnostic by Design:** While tested on specific languages, its principles are universal and should apply to most modern codebases.
-   **🛡️ Robust and Reliable:** The prompt has been iteratively designed (over 14 versions!) to be highly specific, preventing common agent failures like writing incorrect scripts or generating broken HTML.

## How to Use

1.  **Open Your Project in an AI Agent:** Make sure your AI coding agent has access to your project's terminal and file system.
2.  **Copy the Prompt:** Copy the entire contents of the prompt from the collapsible section below.
3.  **Give the Prompt to the Agent:** Paste the entire prompt into the agent's chat interface and instruct it to begin.
4.  **Let it Run:** The agent will perform the multi-phase analysis. This may take a few minutes depending on the size of your repository.
5.  **View the Report:** Once finished, the agent will have created a `knowledge_graph.html` file in your project's root directory. Open this file in your web browser to see the interactive report.

## Small nodejs example

<img width="1757" alt="2025-07-02_16-44-30" src="https://github.com/user-attachments/assets/01ab3159-df53-4948-bbc9-82a0f1cfb991" />


## The Version 1.0 Prompt
Copy _everything_ from the codebox below and paste into your agent.  This really needs a git repo to be effective, but if you want code maps I'm guessing you are already managing your code propery.

```

Your task is to act as an AI code analysis and refactoring advisor. You will perform a deep analysis of the repository to create a **correctly rendered, visually organized knowledge graph** and a detailed analysis report.

**Core Principle:** Your absolute highest priority is to generate a final `knowledge_graph.html` where the Mermaid diagram renders successfully. You must achieve this by following the syntax and template rules below with extreme precision. **Under no circumstances should you write or execute helper scripts.**

---

### **Critical Rules for Generating a Successful Report**

**1. Mermaid Syntax Rules:**
*   **Safe IDs:** All node and subgraph IDs must be a single string containing only letters, numbers, and underscores (`_`). Replace all other characters (`/`, `.`, `-`) with an underscore.
*   **Quote All Labels:** All human-readable text for nodes and subgraphs **must** be enclosed in double quotes.
*   **Separate Definitions from Relationships:** Define ALL subgraphs and nodes first. List ALL relationship links (`-->`) at the end of the Mermaid block.
*   **Use CSS Classes for Styling:** Add a CSS class to your node definitions for styling. Example: `my_function("my_function()"):::functionNode`.

**2. HTML Template Rule:**
*   You **must** use the exact HTML template provided at the end of this prompt. It contains the modern, correct JavaScript imports and configurations required for Mermaid v10+ to render properly. **Do not modify the template's script or style sections.**

---

### **Phase 1: File Discovery**

**Goal:** To get a clean, filtered list of relevant, user-written source files, ignoring third-party and minified code.

**Execution Steps:**
1.  **Get Full List:** Run `git ls-files --cached --others --exclude-standard`.
2.  **Apply Filters:** Create a new list, removing files from `lib/`, `vendor/`, etc., and any files containing `.min.` in their name.

---

### **Phase 2: Code Inventory Creation**

**Goal:** To perform a full analysis on the filtered files and create a detailed JSON inventory.

**Execution Steps:**
1.  **Create Directory:** Ensure `./codeanalysis/` exists.
2.  **Analyze Filtered Files:** For each file in your filtered list, identify its type and all primary **named structural constructs**.
3.  **Create JSON:** Structure a JSON object with `metadata` (including a `timestamp`) and a `files` section.
4.  **Save Inventory:** Save the object to a timestamped file: `./codeanalysis/YYYY-MM-DD_HH-MM-SS_code_inventory.json`.

---

### **Phase 3: Structured Graph and Report Generation**

**Goal:** To create a visually organized graph and a detailed report by following the strict syntax rules.

**Execution Steps:**
1.  **Load Inventory:** Load the most recent inventory JSON file.
2.  **Perform Analysis:**
    *   Find all relationships (`IMPORTS`, `CALLS`, `REFERENCES`).
    *   Identify orphan entities and stale files (`git log`).
3.  **Build the Mermaid Graph (Following the Rules):**
    *   Start your Mermaid list with `graph TD;`.
    *   **Create Logical Groupings:** Define high-level subgraphs for logical areas like "Source & Logic", "Build & Dependencies", and "Documentation & Config".
    *   **Define All Nodes First:** Iterate through your inventory and write the syntax for every subgraph and every node, following all Mermaid Syntax Rules.
    *   **Define All Relationships Last:** After all nodes are defined, write all the relationship lines using descriptive labels. Example: `main_py_worker_thread --"calls"--> main_py_process_chunk`
4.  **Generate Sidebar Report:** Create the HTML for the sidebar containing your analysis of orphans, stale files, and other refactoring suggestions.

---

### **Phase 4: Final HTML Report Generation**

**Goal:** To create the final report using the **correct and modern** HTML template provided below.

**Execution Steps:**
1.  **Consolidate and Embed:** Place your final Mermaid syntax and sidebar report strings into the robust HTML template below.
2.  **Save File:** Save the complete string as `knowledge_graph.html`.

---

### **Final HTML Output Template (Modern and Correct)**

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Codebase Analysis Report</title>
    <style>
        body { font-family: sans-serif; display: flex; flex-direction: column; align-items: center; }
        #report-container { display: flex; width: 98%; gap: 16px; margin-top: 20px; }
        #graph-container { flex-grow: 1; border: 1px solid #ccc; padding: 10px; border-radius: 8px; }
        #sidebar { width: 400px; flex-shrink: 0; border: 1px solid #ccc; padding: 10px; border-radius: 8px; max-height: 85vh; overflow-y: auto; }
        h1, h2 { color: #333; }
        #analysis-report ul { list-style-type: none; padding-left: 0; }
        #analysis-report h3 { border-bottom: 1px solid #eee; padding-bottom: 5px; margin-top: 20px;}
        #analysis-report li { background-color: #f9f9f9; border: 1px solid #eee; padding: 8px; margin-bottom: 5px; border-radius: 4px; }
        #analysis-report strong { color: #c0392b; }
        /* Mermaid Node Styling */
        .classNode { fill:#DDA0DD; stroke:#8A2BE2; stroke-width:2px; }
        .functionNode { fill:#87CEEB; stroke:#4682B4; stroke-width:2px; }
        .dependencyNode { fill:#90EE90; stroke:#2E8B57; stroke-width:2px; }
        .fileNode { fill:#FFFACD; stroke:#FFD700; stroke-width:2px; }
    </style>
</head>
<body>
    <h1>Codebase Analysis Report</h1>
    <div id="report-container">
        <div id="graph-container">
            <h2>Knowledge Graph</h2>
            <pre class="mermaid">
%% --- PASTE YOUR GENERATED MERMAID SYNTAX HERE --- %%
            </pre>
        </div>
        <div id="sidebar">
            <h2>Analysis & Refactoring</h2>
            <div id="analysis-report">
                <!-- %% --- PASTE YOUR GENERATED SIDEBAR REPORT HTML HERE --- %% -->
            </div>
        </div>
    </div>
    <script type="module">
        import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.esm.min.mjs';
        
        mermaid.initialize({
            startOnLoad: true,
            theme: 'default',
            mermaid: {
              curve: 'basis'
            },
            htmlLabels: true
        });
    </script>
</body>
</html>
```



## Design Philosophy & The Collaborative Journey

This prompt is the result of a rigorous, iterative design process between a human and an AI assistant. We went through over a dozen versions to arrive at this point, discovering several key principles for effective agentic prompting along the way:

1.  **Be Explicit, Not Algorithmic:** Early versions described *how* to perform complex tasks (like incremental caching). Agents would often "default" to writing a script to solve the algorithm, violating our "pure LLM" constraint. The final prompt uses simple, direct commands and reasoning steps that the agent can execute natively.
2.  **Negative Constraints are Crucial:** Explicitly telling the agent what *not* to do (e.g., "Under no circumstances should you write helper scripts") is as important as telling it what to do.
3.  **The Template is Law:** Many failures occurred because the agent would try to be "helpful" by modifying the HTML template, often breaking it. The final prompt strictly forbids this and provides a modern, known-working template.
4.  **Structure Aids Reasoning:** Instructing the agent to create logical groupings in the diagram (`subgraph "Source & Logic"`) helps it structure its own analysis and produce a more human-readable result.
5.  **Let the Agent Debug Itself:** One of the key breakthroughs came from asking the agent to diagnose *why* its own generated HTML was failing to render, which led directly to the corrected V14 template.

## Future Vision (The "Icebox")

This prompt represents the peak of a "pure LLM" approach. The next evolution would be a hybrid "Code Companion" model.

-   **The "Code Companion":** A future version could involve a small set of local, hyper-efficient helper scripts (e.g., a Rust-based `indexer` using a real Tree-sitter parser). The LLM's role would shift from low-level parsing to high-level orchestration and reasoning based on the perfect data provided by its tools.
-   **The Self-Aware Agent:** The ultimate goal is to wrap this entire process into a meta-prompt where the agent runs this analysis *first* to orient itself before tackling any user-requested coding task, effectively closing the agentic coding loop and grounding its plans in the reality of the codebase.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

This prompt was co-designed through an iterative and collaborative process. Special thanks to the human user for their sharp-eyed debugging, insightful feedback, and brilliant suggestions that drove the evolution from a simple idea to this robust and powerful tool.   (yeah, I let Gemini write the readme...)
