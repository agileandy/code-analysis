# Code Cartographer Redux

Optimized knowledge graph generation tools powered by Gemini 3.0 Pro.

## Contents

*   **repomix.config.json**: Optimized configuration for Repomix to filter noise upstream.
*   **graph_generation_prompt.md**: The 'Prompt as Code' driver for generating Dependency and Class diagrams.
*   **generate_graph.sh**: Automation script to run the workflow.

## Usage

1.  Install Repomix: `npm install -g repomix`
2.  Run the script: `./generate_graph.sh`

## Does it scale?

To test out the scalability, I cloned the Opennote book repo at 
https://github.com/lfnovo/open-notebook

- 297 files
- 50+ classes
- 516,000 tokens
- ~35,000 lines of code

Running against Claude Sonnet 4.5 this gave

<img width="1531" height="661" alt="2025-11-20_17-47-53" src="https://github.com/user-attachments/assets/a942ad12-8f70-4717-97f1-33a7de3e0352" />

<img width="1365" height="814" alt="2025-11-20_17-43-24" src="https://github.com/user-attachments/assets/06f85343-781c-4ae3-8a7a-5b9b2b75dcd8" />
