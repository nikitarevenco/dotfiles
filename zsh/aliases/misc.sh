# lots of commands on the web contain $ at the beginning. This makes it simpler to copy those commands, $ will evaluate the same command
alias \$='noglob eval'

alias eslint='r .eslintrc.json ; r eslint.config.mjs; cp $DOTFILES/eslint/eslint.config.mjs .; \
if [ -f "tsconfig.json" ]; then \
  if ! grep -q "\"eslint.config.mjs\"" "tsconfig.json"; then \
    jq ".include += [\"eslint.config.mjs\"]" tsconfig.json > tsconfig.tmp && mv tsconfig.tmp tsconfig.json; \
  fi; \
fi; \
p add -D @eslint/compat eslint-import-resolver-typescript eslint-plugin-import-x eslint-plugin-simple-import-sort @eslint/js @next/eslint-plugin-next eslint@latest eslint-config-prettier eslint-plugin-boundaries eslint-plugin-eslint-comments eslint-plugin-functional eslint-plugin-github eslint-plugin-json eslint-plugin-jsx-a11y eslint-plugin-prettier eslint-plugin-promise eslint-plugin-react eslint-plugin-react-hooks eslint-plugin-regexp eslint-plugin-security eslint-plugin-sonarjs eslint-plugin-tailwindcss eslint-plugin-unicorn prettier prettier-plugin-tailwindcss typescript-eslint'

# needs to be loaded after `e` alias has been defined
function t() {
  z "$@"
  e
}
