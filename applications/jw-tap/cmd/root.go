package cmd

import (
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/cmd/gh"
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/logging"
	"github.com/spf13/cobra"
)

var verbosity int

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "jw-tap",
	Short: "A Homebrew tap helper CLI.",
	PersistentPreRun: func(cmd *cobra.Command, args []string) {
		logging.SetVerbosity(verbosity)
	},
}

// Execute adds all child commands to the root command and sets flags appropriately.
// This is called by main.main(). It only needs to happen once to the rootCmd.
func Execute() {
	err := rootCmd.Execute()
	if err != nil {
		logging.Log.Fatal(err)
	}
}

func init() {
	rootCmd.PersistentFlags().CountVarP(&verbosity, "verbosity", "v", "Logging verbosity level")

	rootCmd.AddCommand(gh.GhCmd)
}
