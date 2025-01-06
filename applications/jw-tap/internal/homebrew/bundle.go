package homebrew

import (
	"fmt"
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/constants"
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/logging"
	"os"
	"os/exec"
	"path/filepath"
)

func InstallBundles(selectors ...string) error {
	for _, selector := range selectors {
		logging.Log.Infof("Installing bundle %s", selector)
		err := InstallSelectedBundle(selector)
		if err != nil {
			return err
		}
	}
	return nil
}

func InstallSelectedBundle(selector string) error {
	brewfilePath := filepath.Join(constants.TapPath, "bundles", selector, "Brewfile")

	logging.Log.Debug("Selected Brewfile:", brewfilePath)

	_, err := os.Stat(brewfilePath)
	if err != nil {
		return fmt.Errorf("selected Brewfile not found")
	}

	return InstallBrewfile(brewfilePath)
}

func InstallBrewfile(brewfilePath string) error {
	cmd := exec.Command("brew", "bundle", "--file", brewfilePath)

	// Inherit stdout and stderr
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	return cmd.Run()
}
