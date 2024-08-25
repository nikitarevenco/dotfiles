import { fixupPluginRules } from "@eslint/compat";

import js from "@eslint/js";
import typescriptEslint from "typescript-eslint";
import configPrettier from "eslint-config-prettier";
import pluginPrettier from "eslint-plugin-prettier";
import jsxA11y from "eslint-plugin-jsx-a11y";
import functional from "eslint-plugin-functional";
import react from "eslint-plugin-react";
import reactHooks from "eslint-plugin-react-hooks";
import unicorn from "eslint-plugin-unicorn";
import regexp from "eslint-plugin-regexp";
import security from "eslint-plugin-security";
import sonarjs from "eslint-plugin-sonarjs";
import promise from "eslint-plugin-promise";
import eslintComments from "eslint-plugin-eslint-comments";
import importX from "eslint-plugin-import-x";
import tailwindcss from "eslint-plugin-tailwindcss";
import simpleImportSort from "eslint-plugin-simple-import-sort";
import next from "@next/eslint-plugin-next";

const namingConvention = [
  "error",
  {
    selector: ["memberLike", "property", "parameter"],
    format: ["camelCase"],
  },
  {
    selector: ["typeLike"],
    format: ["PascalCase"],
  },
  {
    selector: ["function"],
    format: ["camelCase", "PascalCase"],
  },
  // Required prefix for boolean variables
  {
    selector: "variable",
    types: ["boolean"],
    format: ["camelCase"],
    prefix: ["is", "should", "has", "can", "did", "will"],
  },
  // Ignore naming convention if we are required to use quotes to access a property e.g. Set-Cookie
  {
    selector: [
      "classProperty",
      "objectLiteralProperty",
      "typeProperty",
      "method",
      "accessor",
      "enumMember",
    ],
    format: null,
    modifiers: ["requiresQuotes"],
  },
  // Ignore naming convention for destructured variables for consistency
  {
    selector: "variable",
    modifiers: ["destructured"],
    format: null,
  },
];

const customRulesTypescriptEslint = {
  "@typescript-eslint/array-type": [
    "error",
    { default: "array-simple", readonly: "array-simple" },
  ],
  "@typescript-eslint/naming-convention": namingConvention,
  "@typescript-eslint/class-methods-use-this": "error",
  "@typescript-eslint/consistent-type-definitions": ["error", "type"],
  "@typescript-eslint/consistent-type-imports": [
    "error",
    {
      fixStyle: "inline-type-imports",
      prefer: "type-imports",
    },
  ],
  "@typescript-eslint/consistent-type-exports": "error",
  "@typescript-eslint/default-param-last": "error",
  "@typescript-eslint/init-declarations": "error",
  "@typescript-eslint/no-loop-func": "error",
  "@typescript-eslint/max-params": "error",
  "@typescript-eslint/no-empty-function": "off",
  "@typescript-eslint/no-explicit-any": ["error", { fixToUnknown: true }],
  "@typescript-eslint/no-shadow": "error",
  "@typescript-eslint/no-use-before-define": "error",
  "@typescript-eslint/no-useless-empty-export": "error",
  "@typescript-eslint/parameter-properties": "error",
  "@typescript-eslint/no-unnecessary-parameter-property-assignment": "error",
  "@typescript-eslint/prefer-destructuring": "error",
  "@typescript-eslint/promise-function-async": "error",
  "@typescript-eslint/no-unnecessary-qualifier": "error",
  "@typescript-eslint/no-unused-vars": [
    "error",
    {
      argsIgnorePattern: "^_$",
      varsIgnorePattern: "^_$",
      caughtErrorsIgnorePattern: "^_$",
    },
  ],
  "@typescript-eslint/restrict-template-expressions": [
    "error",
    {
      allowBoolean: true,
      allowNullish: true,
      allowNumber: true,
      allowRegExp: true,
    },
  ],
  "@typescript-eslint/switch-exhaustiveness-check": [
    "error",
    { requireDefaultForNonUnion: true },
  ],
};

const customRulesReact = {
  "react/forbid-component-props": "off",
  "react/jsx-filename-extension": ["error", { extensions: [".jsx", ".tsx"] }],
  "react/jsx-max-depth": "off",
  "react/jsx-no-bind": ["error", { allowArrowFunctions: true }],
  "react/jsx-no-constructed-context-values": "off",
  "react/jsx-no-leaked-render": "off",
  "react/jsx-no-literals": "off",
  "react/jsx-props-no-spreading": "off",
  "react/jsx-sort-props": "off",
  "react/no-multi-comp": "off",
  "react/no-unescaped-entities": "off",
  "react/prop-types": ["error", { ignore: ["className"] }],
  "react/react-in-jsx-scope": "off",
  "react/require-default-props": "off",
};

const customRulesTailwindcss = {
  "tailwindcss/enforces-negative-arbitrary-values": "error",
  "tailwindcss/enforces-shorthand": "error",
  "tailwindcss/no-contradicting-classname": "error",
  "tailwindcss/no-unnecessary-arbitrary-value": "error",
};

const customRulesUnicorn = {
  "unicorn/no-array-reduce": "off",
  "unicorn/no-keyword-prefix": "off",
  "unicorn/no-null": "off",
  "unicorn/prefer-at": ["error", { checkAllIndexAccess: true }],
  "unicorn/prevent-abbreviations": "off",
};

const customRulesSimpleImportSort = {
  "simple-import-sort/exports": "error",
  "simple-import-sort/imports": "error",
};

const customRulesEslintComments = {
  "eslint-comments/require-description": "error",
  "eslint-comments/no-unused-disable": "error",
};

const customRulesJs = {
  "capitalized-comments": "off",
  "class-methods-use-this": "off",
  "consistent-return": "off",
  "default-param-last": "off",
  "func-style": "off",
  "prefer-destructuring": "off",
  "no-use-before-define": "off",
  "id-length": "off",
  "init-declarations": "off",
  "max-lines-per-function": "off",
  "max-params": "off",
  "max-statements": "off",
  "multiline-comment-style": "off",
  "no-loop-func": "off",
  "new-cap": "off",
  "sort-imports": "off",
  "sort-keys": "off",
  "no-duplicate-imports": "off",
  "no-magic-numbers": "off",
  "no-shadow": "off",
  "no-ternary": "off",
  "no-underscore-dangle": "off",
  "no-unused-expressions": "off",
  "no-void": ["error", { allowAsStatement: true }],
  "one-var": ["error", "never"],
  "prettier/prettier": ["warn"],
  "promise/always-return": "off",
  "promise/catch-or-return": "off",
};

const customRules = {
  ...customRulesTypescriptEslint,
  ...customRulesReact,
  ...customRulesTailwindcss,
  ...customRulesUnicorn,
  ...customRulesSimpleImportSort,
  ...customRulesEslintComments,
  ...customRulesJs,
};

const plugins = {
  prettier: pluginPrettier,
  tailwindcss,
  "simple-import-sort": simpleImportSort,
  "import-x": importX,
  "react-hooks": fixupPluginRules(reactHooks),
  "eslint-comments": fixupPluginRules(eslintComments),
  "@next/next": fixupPluginRules(next),
};

const settings = {
  "import/parsers": {
    "@typescript-eslint/parser": [".ts", ".tsx"],
  },
  "import/resolver": {
    typescript: {
      alwaysTryTypes: true, // always try to resolve types under `<root>@types` directory even it doesn't contain any source code, like `@types/unist`
      project: "tsconfig.json",
    },
  },

  react: {
    version: "detect",
  },
};

const rules = {
  ...next.configs.recommended.rules,
  ...reactHooks.configs.recommended.rules,
  ...eslintComments.configs.recommended.rules,
  ...importX.configs.recommended.rules,
  ...customRules,
  ...configPrettier.rules,
};

const languageOptions = {
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    project: true,
    tsconfigRootDir: import.meta.dirname,
  },
};

const config = [
  promise.configs["flat/recommended"],
  jsxA11y.flatConfigs.strict,
  sonarjs.configs.recommended,
  security.configs.recommended,
  unicorn.configs["flat/all"],
  regexp.configs["flat/all"],
  js.configs.all,
  react.configs.flat.all,
  ...typescriptEslint.configs.strictTypeChecked,
  ...typescriptEslint.configs.stylisticTypeChecked,
  functional.configs.noMutations,
  {
    languageOptions,
    plugins,
    settings,
    rules,
  },
  {
    ignores: ["eslint.config.mjs"],
  },
];

export default typescriptEslint.config(...config);
