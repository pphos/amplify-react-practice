# amplify-react-practice <!-- omit in toc -->

Amplify と React の学習を進めるためのリポジトリ

## 目次 <!-- omit in toc -->

- [環境構築](#環境構築)
  - [Vite による環境構築](#vite-による環境構築)
    - [Vite プロジェクトの作成](#vite-プロジェクトの作成)
      - [非相対インポートの起点となるディレクトリを追加](#非相対インポートの起点となるディレクトリを追加)
    - [ESLint の環境作成](#eslint-の環境作成)
      - [ESLint のインストール](#eslint-のインストール)
      - [ESLint 用の設定ファイル作成](#eslint-用の設定ファイル作成)
      - [`extends`について](#extendsについて)
      - [`rules`について](#rulesについて)
      - [ESLint チェック対象外のファイル定義](#eslint-チェック対象外のファイル定義)
    - [Prettier の環境作成](#prettier-の環境作成)
      - [Prettier のインストール](#prettier-のインストール)
      - [`.prettierrc.json`の作成](#prettierrcjsonの作成)
    - [Jest の環境作成](#jest-の環境作成)
      - [Jest のインストール](#jest-のインストール)
    - [npm スクリプトの追加](#npm-スクリプトの追加)
    - [Tips](#tips)
      - [Vite の環境変数定義方法](#vite-の環境変数定義方法)
  - [create-react-app による環境構築](#create-react-app-による環境構築)
    - [create-react-app プロジェクトの作成](#create-react-app-プロジェクトの作成)
      - [パッケージの更新](#パッケージの更新)
      - [脆弱性情報の修正](#脆弱性情報の修正)
      - [非相対インポートの起点となるディレクトリを追加](#非相対インポートの起点となるディレクトリを追加-1)
    - [ESLint の環境作成](#eslint-の環境作成-1)
      - [ESLint のインストール](#eslint-のインストール-1)
      - [ESLint 用の設定ファイル作成](#eslint-用の設定ファイル作成-1)
      - [`extends`について](#extendsについて-1)
      - [`rules`について](#rulesについて-1)
      - [ESLint チェック対象外のファイル定義](#eslint-チェック対象外のファイル定義-1)
    - [Prettier の環境作成](#prettier-の環境作成-1)
      - [Prettier のインストール](#prettier-のインストール-1)
      - [`.prettierrc.json`の作成](#prettierrcjsonの作成-1)
    - [Jest の環境作成](#jest-の環境作成-1)
      - [Jest のインストール](#jest-のインストール-1)
    - [npm スクリプトの追加](#npm-スクリプトの追加-1)

## 環境構築

### Vite による環境構築

【② React 基礎編】第 6 ~ 7 章を参照

#### Vite プロジェクトの作成

下記コマンドを実行して vite プロジェクトを作成する

```bash
yarn create vite <project> --template=react-ts
```

作成したプロジェクトに移動して, モジュールをインストールする

```bash
cd <project>
yarn
```

更新パッケージの確認
`ncu`コマンドを実行して更新を確認する

```bash
ncu
```

```
[====================] 8/8 100%

 @types/react  ^18.0.17  →  ^18.0.20
 typescript      ^4.6.4  →    ^4.8.3
 vite            ^3.1.0  →    ^3.1.2
```

パッケージの更新がある場合は更新する

```
ncu -u
yarn
```

##### 非相対インポートの起点となるディレクトリを追加

下記コマンドを実行して, vite プロジェクトにオプション追加

```bash
yarn add -D vite-tsconfig-paths
```

`vite.config.ts`を以下の内容に置換

```javascript
import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import tsconfigPaths from "vite-tsconfig-paths";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react(), tsconfigPaths()],
});
```

`tsconfig.json`を以下の内容に置換

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "useDefineForClassFields": true,
    "lib": ["DOM", "DOM.Iterable", "ESNext"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": false,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "module": "ESNext",
    "moduleResolution": "Node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": "src"
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
```

#### ESLint の環境作成

##### ESLint のインストール

ESLint のパッケージをインストール

```bash
yarn add -D eslint
```

ESLint のカスタムパッケージのインストール

```bash
yarn add -D \
  @typescript-eslint/eslint-plugin \
  eslint-config-standard-with-typescript \
  eslint-plugin-jsx-a11y \
  eslint-plugin-import \
  eslint-plugin-n \
  eslint-plugin-promise \
  eslint-plugin-react \
  eslint-plugin-react-hooks \
  eslint-config-prettier \
  eslint-plugin-jest
```

- `eslint-plugin-jsx-a11y`: jsx へのアクセシビリティのルールを追加
- `eslint-plugin-react-hooks`: React Hooks 用のルールを追加
- `eslint-config-prettier`: Prettier と競合する可能性のある ESLint の各種ルールを無効にする共有設定
- `eslint-plugin-jest`: Jest 記法のルール拡張

##### ESLint 用の設定ファイル作成

以下の`.eslintrc.json`を作成する

```json
{
  "env": {
    "browser": true,
    "es2022": true,
    "jest/globals": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "standard-with-typescript",
    "plugin:jsx-a11y/recommended",
    "plugin:react/recommended",
    "plugin:react/jsx-runtime",
    "plugin:react-hooks/recommended",
    "plugin:jest/recommended",
    "prettier"
  ],
  "parserOptions": {
    "ecmaVersion": "latest",
    "tsconfigRootDir": ".",
    "project": ["./tsconfig.json"],
    "sourceType": "module"
  },
  "plugins": ["@typescript-eslint", "jest", "jsx-a11y", "react", "react-hooks"],
  "rules": {
    "padding-line-between-statements": [
      "error",
      {
        "blankLine": "always",
        "prev": "*",
        "next": "return"
      }
    ],
    "@typescript-eslint/consistent-type-definitions": "off",
    "@typescript-eslint/explicit-function-return-type": "off",
    "@typescript-eslint/no-misused-promises": [
      "error",
      {
        "checksVoidReturn": false
      }
    ],
    "@typescript-eslint/no-unused-vars": [
      "error",
      {
        "argsIgnorePattern": "^_",
        "varsIgnorePattern": "^_"
      }
    ],
    "@typescript-eslint/strict-boolean-expressions": [
      "error",
      {
        "allowNullableObject": true
      }
    ],
    "@typescript-eslint/triple-slash-reference": [
      "error",
      {
        "types": "always"
      }
    ],
    "import/extensions": [
      "error",
      {
        "ignorePackages": true,
        "pattern": {
          "js": "never",
          "jsx": "never",
          "ts": "never",
          "tsx": "never"
        }
      }
    ],
    "import/order": [
      "error",
      {
        "groups": [
          "builtin",
          "external",
          "internal",
          "parent",
          "sibling",
          "object",
          "index"
        ],
        "pathGroups": [
          {
            "pattern": "{react,react-dom/**}",
            "group": "builtin",
            "position": "before"
          },
          {
            "pattern": "{[A-Z]*,**/[A-Z]*}",
            "group": "internal",
            "position": "after"
          },
          {
            "pattern": "./*.{css,scss,sass,less}",
            "group": "index",
            "position": "after"
          }
        ],
        "pathGroupsExcludedImportTypes": ["builtin"],
        "alphabetize": {
          "order": "asc"
        }
      }
    ]
  },
  "overrides": [
    {
      "files": ["*.tsx"],
      "rules": {
        "react/prop-types": "off"
      }
    }
  ],
  "settings": {
    "react": {
      "version": "detect"
    }
  }
}
```

##### `extends`について

- `eslint:recommended`

  - ESLint の推奨設定

- `plugin:@typescript-eslint/recommended`
  - ESLint Plugin TypeScript パッケージの推奨設定

##### `rules`について

- `padding-line-between-statements`

  - 任意の構文の間に区切りの空行を入れるかどうかを定義するルール
  - 設定値
    - `return`文の前に常に空行を入れるように設定

- `@typescript-eslint/consistent-type-definitions`

  - オブジェクトの型定義にインターフェースまたは型エイリアスのどちらかを強制するルール
  - 設定値
    - eslint-config-standard-with-typescript がインターフェースを強制しているのを無効化

- `@typescript-eslint/explicit-function-return-type`

  - 関数の戻り値に必ず型定義を書かなければいけないルール
  - 設定値
    - eslint-config-standard-with-typescrip が全面採用しているが, 厳しすぎる制約のため off

- `@typescript-eslint/no-misused-promises`

  - Promise の誤用を防ぐためのルール
  - 設定値
    - void 返却のチェックの無効化

- `@typescript-eslint/no-unused-vars`

  - 使用していない変数の定義を許さないルール。
  - 設定値
    - 変数および引数の先頭を`_`にしたときのみ許容するように設定

- `@typescript-eslint/strict-boolean-expressions`

  - Boolean 値が期待される表現で Boolean 型以外の使用を許さないルール
  - 設定値
    - オブジェクト, 関数, `null`, `undefined`の場合には許容するように設定

- `@typescript-eslint/triple-slash-reference`

  - トリプルスラッシュ・ディレクティブの使用を許可するかどうかを定義するルール
  - 設定値 - eslint-config-standard-with-typescript が一律禁止にしていたのを, type 属性の場合に限り許可するよう
    に設定。

- `import/extensions`

  - インポートの際のファイル拡張子を記述するかを定義するルール
  - 設定値
    - npm パッケージ以外のファイルについて .js 、.jsx 、.ts 、.tsx のファイルのみ拡張子を省略し, 他のファイルは拡張子を記述させるように設定

- `import/order`
  - モジュールインポートの順番をカスタマイズできるルール
  - 設定値
    - 下記順番でインポートされるように修正
      - react
      - react-dom
      - 内部モジュール
      - 相対インポートモジュール

##### ESLint チェック対象外のファイル定義

`.eslintignore`ファイルを作成して下記内容を追加

```
vite.config.ts
```

#### Prettier の環境作成

##### Prettier のインストール

```bash
yarn add -D prettier
```

##### `.prettierrc.json`の作成

`.prettierrc.json`ファイルを作成して下記内容を追加

```json
{
  "singleQuote": true,
  "endOfLine": "auto"
}
```

#### Jest の環境作成

##### Jest のインストール

```bash
yarn add -D jest
```

#### npm スクリプトの追加

ESLint と Prettier が npm スクリプトで実行可能なように`"scripts"`内を下記に変更

```json
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview",
    "lint": "eslint 'src/**/*.{js,jsx,ts,tsx}'",
    "lint:fix": "eslint --fix 'src/**/*.{js,jsx,ts,tsx}'",
    "preinstall": "npx typesync || :",
    "format": "prettier --write --loglevel=warn 'src/**/*.{js,jsx,ts,tsx,html,json,gql,graphql}'",
    "fix": "npm run --silent format; npm run --silent lint:fix"
  }
```

#### Tips

##### Vite の環境変数定義方法

- ユーザ定義の環境変数は, `VITE_`をプレフィックスとしてつける
- アプリケーションで利用する際は, `import.meta.env`から参照する

### create-react-app による環境構築

#### create-react-app プロジェクトの作成

プロジェクト名を指定して下記コマンドを実行し, React プロジェクトを作成する

```bash
yarn create react-app <project> --template typescript
```

React 用の型インストール

```bash
yarn add -D @types/react @types/react-dom
```

##### パッケージの更新

更新パッケージの確認
`ncu`コマンドを実行して更新を確認する

```bash
ncu
```

```
[====================] 12/12 100%

 @testing-library/jest-dom     ^5.14.1  →   ^5.16.5
 @testing-library/react        ^13.0.0  →   ^13.4.0
 @testing-library/user-event   ^13.2.1  →   ^14.4.3
 @types/jest                   ^27.0.1  →   ^29.0.3
 @types/node                  ^16.7.13  →  ^18.7.18
 @types/react                  ^18.0.0  →  ^18.0.20
 @types/react-dom              ^18.0.0  →   ^18.0.6
 typescript                     ^4.4.2  →    ^4.8.3
 web-vitals                     ^2.1.0  →    ^3.0.2
```

パッケージの更新がある場合は更新する

```
ncu -u
yarn
```

##### 脆弱性情報の修正

`audit`によりプロダクション環境の脆弱性情報を確認する

```bash
yarn audit --groups dependencies
```

```
yarn audit v1.22.19
┌───────────────┬──────────────────────────────────────────────────────────────┐
│ high          │ Inefficient Regular Expression Complexity in nth-check       │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ Package       │ nth-check                                                    │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ Patched in    │ >=2.0.1                                                      │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ Dependency of │ react-scripts                                                │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ Path          │ react-scripts > @svgr/webpack > @svgr/plugin-svgo > svgo >   │
│               │ css-select > nth-check                                       │
├───────────────┼──────────────────────────────────────────────────────────────┤
│ More info     │ https://www.npmjs.com/advisories/1070415                     │
└───────────────┴──────────────────────────────────────────────────────────────┘
1 vulnerabilities found - Packages audited: 1240
Severity: 1 High
```

`package.json`を開き`react-scripts`を devDependencies に移動する

```json
  "devDependencies": {
    "react-scripts": "5.0.1"
  },
```

再度`audit`コマンドを実行し, プロダクション環境用の脆弱性が表示されないことを確認する

```bash
yarn audit --groups dependencies
```

```
yarn audit v1.22.19
0 vulnerabilities found - Packages audited: 89
```

##### 非相対インポートの起点となるディレクトリを追加

`tsconfig.json`を下記内容に置換

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "lib": ["dom", "dom.iterable", "esnext"],
    "allowJs": true,
    "skipLibCheck": true,
    "esModuleInterop": true,
    "allowSyntheticDefaultImports": true,
    "strict": true,
    "forceConsistentCasingInFileNames": true,
    "noFallthroughCasesInSwitch": true,
    "module": "esnext",
    "moduleResolution": "node",
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "baseUrl": "src"
  },
  "include": ["src"]
}
```

#### ESLint の環境作成

##### ESLint のインストール

ESLint のパッケージをインストール

```bash
yarn add -D eslint
```

ESLint のカスタムパッケージのインストール

```bash
yarn add -D \
  @typescript-eslint/eslint-plugin \
  eslint-config-standard-with-typescript \
  eslint-plugin-jsx-a11y \
  eslint-plugin-import \
  eslint-plugin-n \
  eslint-plugin-promise \
  eslint-plugin-react \
  eslint-plugin-react-hooks \
  eslint-config-prettier \
  eslint-plugin-jest
```

- `eslint-plugin-jsx-a11y`: jsx へのアクセシビリティのルールを追加
- `eslint-plugin-react-hooks`: React Hooks 用のルールを追加
- `eslint-config-prettier`: Prettier と競合する可能性のある ESLint の各種ルールを無効にする共有設定
- `eslint-plugin-jest`: Jest 記法のルール拡張

##### ESLint 用の設定ファイル作成

以下の`.eslintrc.json`を作成する

```json
{
  "env": {
    "browser": true,
    "es2022": true,
    "jest/globals": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended",
    "standard-with-typescript",
    "plugin:jsx-a11y/recommended",
    "plugin:react/recommended",
    "plugin:react/jsx-runtime",
    "plugin:react-hooks/recommended",
    "plugin:jest/recommended",
    "prettier"
  ],
  "parserOptions": {
    "ecmaVersion": "latest",
    "tsconfigRootDir": ".",
    "project": ["./tsconfig.json"],
    "sourceType": "module"
  },
  "plugins": ["@typescript-eslint", "jest", "jsx-a11y", "react", "react-hooks"],
  "rules": {
    "padding-line-between-statements": [
      "error",
      {
        "blankLine": "always",
        "prev": "*",
        "next": "return"
      }
    ],
    "@typescript-eslint/consistent-type-definitions": "off",
    "@typescript-eslint/explicit-function-return-type": "off",
    "@typescript-eslint/no-misused-promises": [
      "error",
      {
        "checksVoidReturn": false
      }
    ],
    "@typescript-eslint/no-unused-vars": [
      "error",
      {
        "argsIgnorePattern": "^_",
        "varsIgnorePattern": "^_"
      }
    ],
    "@typescript-eslint/strict-boolean-expressions": [
      "error",
      {
        "allowNullableObject": true
      }
    ],
    "@typescript-eslint/triple-slash-reference": [
      "error",
      {
        "types": "always"
      }
    ],
    "import/extensions": [
      "error",
      {
        "ignorePackages": true,
        "pattern": {
          "js": "never",
          "jsx": "never",
          "ts": "never",
          "tsx": "never"
        }
      }
    ],
    "import/order": [
      "error",
      {
        "groups": [
          "builtin",
          "external",
          "internal",
          "parent",
          "sibling",
          "object",
          "index"
        ],
        "pathGroups": [
          {
            "pattern": "{react,react-dom/**}",
            "group": "builtin",
            "position": "before"
          },
          {
            "pattern": "{[A-Z]*,**/[A-Z]*}",
            "group": "internal",
            "position": "after"
          },
          {
            "pattern": "./*.{css,scss,sass,less}",
            "group": "index",
            "position": "after"
          }
        ],
        "pathGroupsExcludedImportTypes": ["builtin"],
        "alphabetize": {
          "order": "asc"
        }
      }
    ]
  },
  "overrides": [
    {
      "files": ["*.tsx"],
      "rules": {
        "react/prop-types": "off"
      }
    }
  ],
  "settings": {
    "react": {
      "version": "detect"
    }
  }
}
```

##### `extends`について

- `eslint:recommended`

  - ESLint の推奨設定

- `plugin:@typescript-eslint/recommended`
  - ESLint Plugin TypeScript パッケージの推奨設定

##### `rules`について

- `padding-line-between-statements`

  - 任意の構文の間に区切りの空行を入れるかどうかを定義するルール
  - 設定値
    - `return`文の前に常に空行を入れるように設定

- `@typescript-eslint/consistent-type-definitions`

  - オブジェクトの型定義にインターフェースまたは型エイリアスのどちらかを強制するルール
  - 設定値
    - eslint-config-standard-with-typescript がインターフェースを強制しているのを無効化

- `@typescript-eslint/explicit-function-return-type`

  - 関数の戻り値に必ず型定義を書かなければいけないルール
  - 設定値
    - eslint-config-standard-with-typescrip が全面採用しているが, 厳しすぎる制約のため off

- `@typescript-eslint/no-misused-promises`

  - Promise の誤用を防ぐためのルール
  - 設定値
    - void 返却のチェックの無効化

- `@typescript-eslint/no-unused-vars`

  - 使用していない変数の定義を許さないルール。
  - 設定値
    - 変数および引数の先頭を`_`にしたときのみ許容するように設定

- `@typescript-eslint/strict-boolean-expressions`

  - Boolean 値が期待される表現で Boolean 型以外の使用を許さないルール
  - 設定値
    - オブジェクト, 関数, `null`, `undefined`の場合には許容するように設定

- `@typescript-eslint/triple-slash-reference`

  - トリプルスラッシュ・ディレクティブの使用を許可するかどうかを定義するルール
  - 設定値 - eslint-config-standard-with-typescript が一律禁止にしていたのを, type 属性の場合に限り許可するよう
    に設定。

- `import/extensions`

  - インポートの際のファイル拡張子を記述するかを定義するルール
  - 設定値
    - npm パッケージ以外のファイルについて .js 、.jsx 、.ts 、.tsx のファイルのみ拡張子を省略し, 他のファイルは拡張子を記述させるように設定

- `import/order`
  - モジュールインポートの順番をカスタマイズできるルール
  - 設定値
    - 下記順番でインポートされるように修正
      - react
      - react-dom
      - 内部モジュール
      - 相対インポートモジュール

##### ESLint チェック対象外のファイル定義

`.eslintignore`ファイルを作成して下記内容を追加

```
build/
public/
**/coverage/
**/node_modules/
**/*.min.js
*.config.js
.*lintrc.js
```

#### Prettier の環境作成

##### Prettier のインストール

```bash
yarn add -D prettier
```

##### `.prettierrc.json`の作成

`.prettierrc.json`ファイルを作成して下記内容を追加

```json
{
  "singleQuote": true,
  "endOfLine": "auto"
}
```

#### Jest の環境作成

##### Jest のインストール

```bash
yarn add -D jest
```

#### npm スクリプトの追加

ESLint と Prettier が npm スクリプトで実行可能なように`"scripts"`内を下記に変更

```json
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject",
    "lint": "eslint 'src/**/*.{js,jsx,ts,tsx}'",
    "lint:fix": "eslint --fix 'src/**/*.{js,jsx,ts,tsx}'",
    "preinstall": "npx typesync || :",
    "format": "prettier --write --loglevel=warn 'src/**/*.{js,jsx,ts,tsx,html,json,gql,graphql}'",
    "fix": "npm run --silent format; npm run --silent lint:fix"
  },
```
