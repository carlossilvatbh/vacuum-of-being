#!/bin/bash

# Installation script for LaTeX dependencies
# Run this script to install required packages for compiling the document

echo "Installing LaTeX and required packages..."

# Update package list
sudo apt-get update

# Install TeX Live (basic LaTeX distribution)
sudo apt-get install -y texlive-latex-base texlive-latex-recommended texlive-latex-extra

# Install additional packages for better LaTeX support
sudo apt-get install -y texlive-fonts-recommended texlive-fonts-extra

# Install bibliography tools
sudo apt-get install -y texlive-bibtex-extra biber

# Install make for build automation
sudo apt-get install -y make

# Install PDF viewer (optional)
sudo apt-get install -y evince

echo "Installation complete!"
echo "You can now compile the document using:"
echo "  make pdf"
echo "or manually with:"
echo "  pdflatex -output-directory=build src/vacuum_of_being_consolidated.tex"

