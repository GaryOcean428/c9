_nvmrc_hook() {
  if [[ $PWD == $PREV_PWD ]]; then
    return
  fi
  
  PREV_PWD=$PWD
  [[ -f ".nvmrc" ]] && nvm use
}

if ! [[ "${PROMPT_COMMAND:-}" =~ _nvmrc_hook ]]; then
  PROMPT_COMMAND="_nvmrc_hook${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi

# Welcome message for GaryOcean
echo "🌊 Welcome to C9 IDE, GaryOcean! 🌊"
echo "Your development environment is ready."
echo ""
if [ -n "$DATABASE_URL" ] || [ -n "$POSTGRES_HOST" ]; then
    echo "📊 PostgreSQL database connection is available."
    echo "   Use 'db' or 'dbconnect' to connect to your database."
else
    echo "📊 To connect to PostgreSQL, set your DATABASE_URL environment variable."
fi
echo "🚀 Happy coding!"
echo ""