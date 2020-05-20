package controller

import (
	"githut.com/928234269/log-alert-operator/pkg/controller/logalert"
)

func init() {
	// AddToManagerFuncs is a list of functions to create controllers and add them to a manager.
	AddToManagerFuncs = append(AddToManagerFuncs, logalert.Add)
}
