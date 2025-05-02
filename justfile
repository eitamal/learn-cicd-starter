alias f := fmt
alias l := lint
alias yf := yml_fmt
alias yl := yml_lint
alias df := deno_fmt
alias gf := go_fmt
alias gl := go_lint
alias gsu := goose_up
alias gsd := goose_down
alias jf := just_fmt

_default: fmt lint

fmt:
    #!/usr/bin/env -S parallel --shebang --ungroup --jobs {{ num_cpus() }}
    just yml_fmt
    just deno_fmt
    just go_fmt
    just just_fmt

lint:
    #!/usr/bin/env -S parallel --shebang --ungroup --jobs {{ num_cpus() }}
    just yml_lint
    just go_lint

yml_fmt:
    yamlfmt

yml_lint:
    yamllint .

deno_fmt:
    deno fmt --ignore=vendor/

go_fmt:
    golangci-lint fmt

go_lint:
    golangci-lint run

goose_up:
    goose up

goose_down:
    goose down

just_fmt:
    just --fmt
