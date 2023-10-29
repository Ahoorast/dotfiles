package handlers

import (
	"crypto/md5"
	_ "crypto/md5"
	_ "encoding/hex"
	"encoding/json"
	_ "encoding/json"
	"fmt"
	_ "fmt"
	"net/http"
	"net/mail"
)

type GravatarResponse struct {
	Ok          bool   `json:"ok"`
	GravatarUrl string `json:"gravatar_url"`
}

type ErrorResponse struct {
	Ok      bool   `json:"ok"`
	Message string `json:"message"`
}

func HandleGravatarRequest(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("X-Content-Type-Options", "nosniff")

	email := r.URL.Query().Get("email")
	if email == "" {
		res, _ := json.Marshal(ErrorResponse{false, "No email address provided"})
		w.WriteHeader(http.StatusBadRequest)
		w.Write(res)
		return
	}
	address, _ := mail.ParseAddress(email)
	if address == nil {
		res, _ := json.Marshal(ErrorResponse{false, "Invalid email address"})
		w.WriteHeader(http.StatusBadRequest)
		w.Write(res)
		return
	}
	hash := fmt.Sprintf("%x", md5.Sum([]byte(email)))
	gravatar_url := fmt.Sprintf("https://www.gravatar.com/avatar/%s", hash)
	res, _ := json.Marshal(GravatarResponse{true, gravatar_url})
	w.Write(res)
}
