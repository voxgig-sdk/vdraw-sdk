package core

type VdrawError struct {
	IsVdrawError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewVdrawError(code string, msg string, ctx *Context) *VdrawError {
	return &VdrawError{
		IsVdrawError: true,
		Sdk:              "Vdraw",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *VdrawError) Error() string {
	return e.Msg
}
