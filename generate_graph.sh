#!/bin/bash

# Generate Knowledge Graph Workflow Script

echo "🚀 Starting Knowledge Graph Generation Workflow..."

# 1. Run Repomix to pack the codebase
echo "📦 Packing codebase with Repomix..."
if repomix --config repomix.config.json; then
    echo "✅ Codebase packed to repomix-output.xml"
else
    echo "❌ Repomix failed. Please check repomix.config.json"
    exit 1
fi

# 2. Display Instructions for the User
echo ""
echo "📋 NEXT STEPS:"
echo "1. Copy the content of 'graph_generation_prompt.md'"
echo "2. Upload 'repomix-output.xml' to your LLM context."
echo "3. Paste the prompt to generate the 'knowledge_graph.mmd' and report."
echo ""
echo "🎉 Ready for analysis!"
