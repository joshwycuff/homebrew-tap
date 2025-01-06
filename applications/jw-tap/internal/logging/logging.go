package logging

import (
	"go.uber.org/zap"
	"go.uber.org/zap/zapcore"
)

var LogLevel = zap.NewAtomicLevelAt(zapcore.WarnLevel)
var Log *zap.SugaredLogger

func SetVerbosity(verbosity int) {
	if verbosity == 1 {
		LogLevel.SetLevel(zapcore.InfoLevel)
	} else if verbosity > 1 {
		LogLevel.SetLevel(zapcore.DebugLevel)
	} else {
		LogLevel.SetLevel(zapcore.WarnLevel)
	}
}

func init() {
	cfg := zap.Config{
		Level:            LogLevel,           // Use the atomic LogLevel
		Development:      false,              // Production mode (set to true for development-friendly logs)
		Encoding:         "console",          // Log format: "json" or "console"
		OutputPaths:      []string{"stderr"}, // Default output (stdout)
		ErrorOutputPaths: []string{"stderr"}, // Default error output (stderr)
		EncoderConfig: zapcore.EncoderConfig{
			TimeKey:       "time",                      // Add timestamp
			LevelKey:      "LogLevel",                  // Add log LogLevel
			NameKey:       "logger",                    // Add logger name (if any)
			CallerKey:     "caller",                    // Add caller information
			MessageKey:    "msg",                       // Add the message field
			StacktraceKey: "stacktrace",                // Add stack traces for errors
			EncodeTime:    zapcore.ISO8601TimeEncoder,  // Use ISO 8601 format for time
			EncodeLevel:   zapcore.CapitalLevelEncoder, // Capitalized log levels (e.g., INFO, DEBUG)
			EncodeCaller:  zapcore.ShortCallerEncoder,  // Short caller information
		},
	}

	logger, err := cfg.Build()
	if err != nil {
		panic("Failed to initialize logger: " + err.Error())
	}
	Log = logger.Sugar()
}
