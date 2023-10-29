package helper

import (
	_ "fmt"
	"snapp/the_lib"
)

func longString() string {
	var ret string
	for i := 0; i < 300; i++ {
		ret += "a"
	}
	return ret
}

func constructData() *the_lib.Data {
	data := the_lib.Data{}
	return &data
}

func sameDataCase() error {
	data := constructData()
	return data.Manipulate(data)
}

var (
	_, ErrNoPath           = the_lib.LoadData()
	_, ErrPathShort        = the_lib.LoadDataWithPath("a")
	_, ErrPathLong         = the_lib.LoadDataWithPath(longString())
	_, ErrPathNotLowercase = the_lib.LoadDataWithPath("asdfasdfASDFASDFA")
	_, ErrPathNotRelative  = the_lib.LoadDataWithPath("/asdfasdfasdfasdf")
	_, ErrPathNotTrimmed   = the_lib.LoadDataWithPath("   asdfasdf asd fa sdfasdf")
	_, ErrPathRetreat      = the_lib.LoadDataWithPath("asdfasdfa../asdfasdf..")
	ErrDataNil             = constructData().Manipulate(nil)
	ErrSameData            = sameDataCase()
)
