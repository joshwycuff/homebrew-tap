package cmd

import (
	"fmt"
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/build"
	"github.com/spf13/cobra"
)

// versionCmd represents the version command
var versionCmd = &cobra.Command{
	Use:   "version",
	Short: "Print the version number",
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Println(build.Version)
	},
}

func init() {
	rootCmd.AddCommand(versionCmd)
}
