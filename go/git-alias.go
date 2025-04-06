package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

var gitCmd = "/opt/homebrew/bin/git"

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Usage:")
		fmt.Println("  git-alias commit <msg>            # コミットメッセージを指定")
		fmt.Println("  git-alias pull [branch]           # 引数があればそのブランチにcheckoutしてpull、なければmainでpull")
		fmt.Println("  git-alias push                    # 現在のブランチをpush")
		fmt.Println("  git-alias add [files...]          # 引数があれば指定したファイルをadd、なければ全ファイルをadd")
		fmt.Println("  git-alias status                  # git status")
		fmt.Println("  git-alias diff-cached             # git diff --cached")
		os.Exit(0)
	}

	switch os.Args[1] {
	case "commit":
		commit()
	case "pull":
		pull()
	case "push":
		push()
	case "add":
		add()
	case "status":
		status()
	case "diff-cached":
		diffCached()
	default:
		fmt.Printf("Unknown subcommand: %s\n", os.Args[1])
		os.Exit(1)
	}
}

func runGitCmd(args ...string) error {
	gitArgs := append([]string{"-c", "color.ui=always"}, args...)
	cmd := exec.Command(gitCmd, gitArgs...)
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	return err
}

func commit() {
	if len(os.Args) < 3 {
		fmt.Fprintln(os.Stderr, "Usage: git-alias commit <commit message>")
		os.Exit(1)
	}
	message := strings.Join(os.Args[2:], " ")
	cmd := exec.Command(gitCmd, "commit", "-m", message)
	output, err := cmd.CombinedOutput()
	if err != nil {
		fmt.Fprintln(os.Stderr, string(output))
		fmt.Fprintln(os.Stderr, "Error:", err)
		os.Exit(1)
	}
	fmt.Print(string(output))
}

func pull() {
	var branch string
	if len(os.Args) > 2 {
		branch = os.Args[2]
	} else {
		branch = "main"
	}
	if err := runGitCmd("checkout", branch); err != nil {
		os.Exit(1)
	}
	if err := runGitCmd("pull", "origin", branch); err != nil {
		os.Exit(1)
	}
}

func push() {
	branch, err := currentBranch()
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	if err := runGitCmd("push", "origin", branch); err != nil {
		os.Exit(1)
	}
}

func add() {
	if len(os.Args) > 2 {
		paths := os.Args[2:]
		if err := runGitCmd(append([]string{"add"}, paths...)...); err != nil {
			os.Exit(1)
		}
	} else {
		if err := runGitCmd("add", "."); err != nil {
			os.Exit(1)
		}
	}
}

func status() {
	if err := runGitCmd("status"); err != nil {
		os.Exit(1)
	}
}

func currentBranch() (string, error) {
	cmd := exec.Command(gitCmd, "rev-parse", "--abbrev-ref", "HEAD")
	output, err := cmd.Output()
	if err != nil {
		return "", fmt.Errorf("failed to get current branch: %v", err)
	}
	return strings.TrimSpace(string(output)), nil
}

func diffCached() {
	if err := runGitCmd("diff", "--cached"); err != nil {
		os.Exit(1)
	}
}