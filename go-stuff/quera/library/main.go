package library

import (
	"strings"
)

var messages = []string{
	"The book has not been borrowed",
	"The book is already borrowed by ",
	"The book is already in the library",
	"The book is not defined in the library",
	"Not enough capacity",
	"OK",
}

type Book struct {
	name     string
	borrower string
}

type Library struct {
	capacity int
	books    []Book
}

func NewLibrary(capacity int) *Library {
	// TODO
	var books []Book
	var lib Library = Library{capacity, books}
	return &lib
}

func (library *Library) getBook(name string) *Book {
	for i := range library.books {
		if library.books[i].name == name {
			return &library.books[i]
		}
	}
	return nil
}

func (library *Library) AddBook(name string) string {
	// TODO
	name = strings.ToLower(name)
	book := library.getBook(name)
	if book != nil {
		return messages[2]
	}
	if len(library.books) >= library.capacity {
		return messages[4]
	}
	library.books = append(library.books, Book{name, ""})
	return messages[5]
}

func (library *Library) BorrowBook(bookName, personName string) string {
	// TODO
	bookName = strings.ToLower(bookName)
	book := library.getBook(bookName)
	if book == nil {
		return messages[3]
	}
	if book.borrower != "" {
		return messages[1] + book.borrower
	}
	book.borrower = personName
	return messages[5]
}

func (library *Library) ReturnBook(bookName string) string {
	// TODO
	bookName = strings.ToLower(bookName)
	book := library.getBook(bookName)
	if book == nil {
		return messages[3]
	}
	if book.borrower == "" {
		return messages[0]
	}
	book.borrower = ""
	return messages[5]
}
