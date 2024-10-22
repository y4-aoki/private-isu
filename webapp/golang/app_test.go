package main

import (
	"testing"
)

func TestDigest(t *testing.T) {
	testCases := []struct {
		input    string
		expected string
	}{
		{"test", "ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff"},
		{"hello", "9b71d224bd62f3785d96d46ad3ea3d73319bfbc2890caadae2dff72519673ca72323c3d99ba5c11d7c7acc6e14b8c5da0c4663475c2e5c3adef46f73bcdec043"},
		{"world", "11853df40f4b2b919d3815f64792e58d08663767a494bcbb38c0b2389d9140bbb170281b4a847be7757bde12c9cd0054ce3652d0ad3a1a0c92babb69798246ee"},
	}

	for _, tc := range testCases {
		result := digest(tc.input)
		if result != tc.expected {
			t.Errorf("digest(%q) = %q; want %q", tc.input, result, tc.expected)
		}
	}
}
