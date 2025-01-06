package cmd

import (
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/build"
	"github.com/spf13/cobra"
)

// buildInfoCmd represents the build-info command
var buildInfoCmd = &cobra.Command{
	Use:   "build-info",
	Short: "Print build info",
	Run: func(cmd *cobra.Command, args []string) {
		build.PrintBuildInfo()
	},
}

func init() {
	rootCmd.AddCommand(buildInfoCmd)
}
