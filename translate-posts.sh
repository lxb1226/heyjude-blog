#!/bin/bash

# translate-posts.sh
# Script to automate translation of blog posts using h7ml/ai-file-translator
# Uses zh-cn as the source language and translates to specified target languages

# Strict mode
set -euo pipefail

# Default configuration
SOURCE_LANG="zh-cn"
POSTS_DIR="content/posts"

# Default target languages if not set via environment variable
if [ -z "${TARGET_LANGS+x}" ]; then
  declare -a TARGET_LANGS=("en")
else
  # If TARGET_LANGS is set as a string, convert it to an array
  if [ -z "${TARGET_LANGS[*]+x}" ]; then
    IFS=' ' read -r -a TARGET_LANGS <<< "$TARGET_LANGS"
  fi
fi

# OpenAI API Configuration
# If not set, we'll rely on the tool's defaults or configuration file
OPENAI_API_KEY=${OPENAI_API_KEY:-""}
OPENAI_MODEL=${OPENAI_MODEL:-"gpt-3.5-turbo"}

# Color codes for better output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions for logging
log_error() {
  echo -e "${RED}ERROR:${NC} $1" >&2
}

log_success() {
  echo -e "${GREEN}SUCCESS:${NC} $1"
}

log_info() {
  echo -e "${BLUE}INFO:${NC} $1"
}

log_warning() {
  echo -e "${YELLOW}WARNING:${NC} $1"
}

# Function to check prerequisites
check_prerequisites() {
  log_info "Checking prerequisites..."
  
  # Check if npm is installed
  if ! command -v npm &> /dev/null; then
    log_error "npm is not installed. Please install Node.js and npm first."
    exit 1
  fi
  
  # Check if posts directory exists
  if [ ! -d "$POSTS_DIR" ]; then
    log_error "Posts directory '$POSTS_DIR' does not exist"
    exit 1
  fi
  
  # Install ai-markdown-translator if not already installed
  if ! command -v npx ai-markdown-translator &> /dev/null; then
    log_info "Installing ai-markdown-translator globally..."
    npm install -g ai-markdown-translator
    
    # Check if installation was successful
    if ! command -v ai-markdown-translator &> /dev/null; then
      log_error "Failed to install ai-markdown-translator"
      log_info "Try installing manually: npm install -g ai-markdown-translator"
      exit 1
    fi
  fi
  
  # Warn if OPENAI_API_KEY is not set
  if [ -z "$OPENAI_API_KEY" ]; then
    log_warning "OPENAI_API_KEY is not set. Make sure it's configured in your environment or .env file"
    log_info "Example: export OPENAI_API_KEY='your-api-key'"
  else
    log_success "OPENAI_API_KEY is set"
  fi
  
  log_success "All prerequisites met"
}

# Function to get base name from filename
# Example: input "how-to-use-mess-auto.zh-cn.md" -> output "how-to-use-mess-auto"
get_base_name() {
  local filename=$(basename "$1")
  echo "$filename" | sed 's/\.[^.]*\.[^.]*$//'
}

# Function to translate a single file
translate_file() {
  local source_file="$1"
  local target_lang="$2"
  local base_name=$(get_base_name "$source_file")
  local target_file="$POSTS_DIR/$base_name.$target_lang.md"
  
  # Check if translation already exists
  if [ -f "$target_file" ]; then
    log_info "Skipping $base_name.$target_lang.md (already exists)"
    return 0
  fi
  
  log_info "Translating $base_name from $SOURCE_LANG to $target_lang..."
  
  # Prepare command based on whether API key is provided
  local cmd_args=()
  cmd_args+=(--input "$source_file")
  cmd_args+=(--output "$target_file")
  cmd_args+=(--source-lang "$SOURCE_LANG")
  cmd_args+=(--target-lang "$target_lang")
  cmd_args+=(--preserve-formatting)
  cmd_args+=(--preserve-front-matter)
  
  if [ -n "$OPENAI_API_KEY" ]; then
    cmd_args+=(--api-key "$OPENAI_API_KEY")
    cmd_args+=(--model "$OPENAI_MODEL")
  fi
  
  # Execute translation
  if npx ai-markdown-translator "${cmd_args[@]}"; then
    log_success "Created $base_name.$target_lang.md"
    return 0
  else
    log_error "Failed to translate $base_name to $target_lang"
    return 1
  fi
}

# Main function
main() {
  local translated_count=0
  local skipped_count=0
  local error_count=0
  
  # Print banner
  echo "========================================="
  echo "   Blog Post Translation Automation"
  echo "========================================="
  
  # Check prerequisites
  check_prerequisites
  
  # Print configuration
  log_info "Source language: $SOURCE_LANG"
  log_info "Target languages: ${TARGET_LANGS[*]}"
  log_info "Posts directory: $POSTS_DIR"
  log_info "OpenAI model: $OPENAI_MODEL"
  echo "----------------------------------------"
  
  # Count source files
  local source_files=("$POSTS_DIR"/*."$SOURCE_LANG".md)
  local source_file_count=${#source_files[@]}
  
  if [ $source_file_count -eq 0 ]; then
    log_warning "No $SOURCE_LANG files found in $POSTS_DIR"
    exit 0
  fi
  
  log_info "Found $source_file_count $SOURCE_LANG files to process"
  
  # Process each source file
  for source_file in "${source_files[@]}"; do
    base_name=$(get_base_name "$source_file")
    log_info "Processing $base_name..."
    
    for target_lang in "${TARGET_LANGS[@]}"; do
      if [ "$target_lang" = "$SOURCE_LANG" ]; then
        log_warning "Skipping translation to $target_lang (same as source language)"
        continue
      fi
      
      if translate_file "$source_file" "$target_lang"; then
        if [ -f "$POSTS_DIR/$base_name.$target_lang.md" ] && [ $(stat -f %z "$POSTS_DIR/$base_name.$target_lang.md") -gt 0 ]; then
          ((translated_count++))
        else
          ((skipped_count++))
        fi
      else
        ((error_count++))
      fi
    done
  done
  
  # Print summary
  echo "========================================="
  log_info "Translation complete!"
  log_info "Summary:"
  log_info "  Files processed: $source_file_count"
  log_info "  Files translated: $translated_count"
  log_info "  Files skipped (already exist): $skipped_count"
  log_info "  Errors encountered: $error_count"
  echo "========================================="
  
  # Return non-zero exit code if there were errors
  [ "$error_count" -eq 0 ]
}

# Execute main function
main
