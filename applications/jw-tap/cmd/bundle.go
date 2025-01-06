package cmd

import (
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/homebrew"
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/logging"
	"github.com/spf13/cobra"
	"os"
)

// bundleCmd represents the bundle command
var bundleCmd = &cobra.Command{
	Use:   "bundle [name1] ... [nameN]",
	Short: "Install joshwycuff/homebrew-tap Brewfiles.",
	Args:  cobra.MinimumNArgs(1), // Expect at least 1 positional argument
	Run:   bundleFunc,
}

func bundleFunc(cmd *cobra.Command, args []string) {
	err := homebrew.InstallBundles(args...)
	if err != nil {
		logging.Log.Error(err)
		os.Exit(1)
	}
}

func init() {
	rootCmd.AddCommand(bundleCmd)
}
