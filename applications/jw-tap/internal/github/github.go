package github

import (
	"fmt"
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/constants"
	"os/exec"
	"runtime"
)

func OpenRepo() error {
	switch runtime.GOOS {
	case "darwin":
		cmd := exec.Command("open", constants.RepoUrl)
		err := cmd.Start()
		if err != nil {
			return err
		}
	default:
		return fmt.Errorf("unsupported platform")
	}
	return nil
}
