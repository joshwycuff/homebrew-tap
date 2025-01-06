package gh

import (
	"github.com/joshwycuff/homebrew-tap/applications/jw-tap/internal/github"
	"github.com/spf13/cobra"
)

// repoCmd represents the repo command
var repoCmd = &cobra.Command{
	Use:   "repo",
	Short: "Open repository in the default browser",
	RunE:  RepoFunc,
}

func RepoFunc(cmd *cobra.Command, args []string) error {
	return github.OpenRepo()
}

func init() {
	GhCmd.AddCommand(repoCmd)
}
