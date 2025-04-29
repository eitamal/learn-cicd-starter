package auth

import (
	"net/http"
	"testing"
)

func TestGetAPIKey(t *testing.T) {
	cases := []struct {
		header  string
		key     string
		wantErr bool
		want    string
	}{
		{"Authorization", "ApiKey 12345", false, "12345"},
		{"Authorization", "ApiKey ", true, ""},
		{"Authorization", "invalid 12345", true, ""},
	}

	for _, c := range cases {
		headers := http.Header{}
		headers.Add(c.header, c.key)
		got, gotErr := GetAPIKey(headers)
		if gotErr != nil {
			if c.wantErr {
				continue
			}

			t.Fatalf("GetAPIKey(%s %s) want: %s, err: %v", c.header, c.key, c.want, gotErr)
		}
		if got != c.want {
			t.Fatalf("GetAPIKey(%s %s) want: %s, got: %s", c.header, c.key, c.want, got)
		}
	}
}
