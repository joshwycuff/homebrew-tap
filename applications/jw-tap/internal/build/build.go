package build

import "fmt"

var CommitId = ""
var Tag = ""
var Version = ""

func PrintBuildInfo() {
	fmt.Printf("{\"CommitId\":\"%s\",\"Tag\":\"%s\",\"Version\":\"%s\"}\n", CommitId, Tag, Version)
}
