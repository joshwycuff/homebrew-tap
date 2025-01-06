package gh

import (
	"github.com/spf13/cobra"
)

// GhCmd represents the gh command
var GhCmd = &cobra.Command{
	Use:   "gh",
	Short: "Work with GitHub repository",
	RunE:  RepoFunc,
}
