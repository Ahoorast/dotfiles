package main

import (
	"errors"
)

var (
	InvalidUsername = errors.New("invalid username")
	ChatNotCreated  = errors.New("could not create chat")
)

type Bale interface {
	AddUser(username string, isBot bool) (int, error)
	AddChat(chatname string, isGroup bool, creator int, admins []int) (int, error)
	SendMessage(userId int, chatId int, text string) (int, error)
	SendLike(userId, messageId int) error
	GetNumberOfLikes(messageId int) (int, error)
	SetChatAdmin(chatId, userId int) error
	GetLastMessage(chatId int) (string, int, error)
	GetLastUserMessage(userId int) (string, int, error)
}

type User struct {
	id       int
	username string
	isBot    bool
}

type Chat struct {
	id       int
	chatname string
	isGroup  bool
	creator  User
	admins   []User
}

type Message struct {
	id    int
	user  User
	chat  Chat
	text  string
	likes int
}

type BaleImpl struct {
	// TODO: Implement
	users    []User
	chats    []Chat
	messages []Message
}

func same[T comparable](a T, b T) {
	if
}
func getByIds[T comparable](s []T, t T) []T {
	var ret []T
	for _, x := range s {
		if same(x, t) {
			ret = append(ret, x)
		}
	}
	return ret
}

func validateUsername(username string) error {
	if len(username) <= 3 {
		return InvalidUsername
	}
	hasDigits, hasChars := false, false
	for _, c := range username {
		if c >= 'a' && c <= 'z' {
			hasChars = true
		}
		if c >= 'A' && c <= 'Z' {
			hasChars = true
		}
		if c >= '0' && c <= '9' {
			hasDigits = true
		}
	}
	if !hasDigits || !hasChars {
		return InvalidUsername
	}
	return nil
}

func NewBaleImpl() *BaleImpl {
	// TODO: Implement
	return &BaleImpl{}
}

func (bi *BaleImpl) AddUser(username string, isBot bool) (int, error) {
	// TODO: Implement
	err := validateUsername(username)
	if err != nil {
		return 0, err
	}
	for _, user := range bi.users {
		if user.username == username {
			return 0, InvalidUsername
		}
	}
	id := len(bi.users) + 1
	bi.users = append(bi.users, User{id, username, isBot})
	return id, nil
}

func (bi *BaleImpl) AddChat(chatname string, isGroup bool, creator int, admins []int) (int, error) {
	// TODO: Implement
	creator -= 1
	if bi.users[creator].isBot {
		return 0, ChatNotCreated
	}
	id := len(bi.chats) + 1
	bi.chats = append(bi.chats, Chat{id, chatname, isGroup, creator, admins})
	return 0, nil
}

func (bi *BaleImpl) SendMessage(userId int, chatId int, text string) (int, error) {
	// TODO: Implement
	return 0, nil
}

func (bi *BaleImpl) SendLike(userId, messageId int) error {
	// TODO: Implement
	return nil
}

func (bi *BaleImpl) GetNumberOfLikes(messageId int) (int, error) {
	// TODO: Implement
	return 0, nil
}

func (bi *BaleImpl) SetChatAdmin(chatId, userId int) error {
	// TODO: Implement
	return nil
}

func (bi *BaleImpl) GetLastMessage(chatId int) (string, int, error) {
	// TODO: Implement
	return "", 0, nil
}

func (bi *BaleImpl) GetLastUserMessage(userId int) (string, int, error) {
	// TODO: Implement
	return "", 0, nil
}
