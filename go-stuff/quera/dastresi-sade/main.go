package main

type Permissions struct {
	canSeeMessages      bool
	canDeleteMessages   bool
	canEditMessages     bool
	canKickMembers      bool
	canMakeMembersAdmin bool
	canAddMembers       bool
}

func toInt8(x bool) int8 {
	var ret int8
	if x {
		ret = 1
	}
	return ret
}

func SetUserPermissions(permissions *Permissions) int8 {
	// TODO: Implement
	var ret int8
	ret += toInt8(permissions.canSeeMessages)
	ret += toInt8(permissions.canDeleteMessages) * 2
	ret += toInt8(permissions.canEditMessages) * 4
	ret += toInt8(permissions.canKickMembers) * 8
	ret += toInt8(permissions.canEditMessages) * 16
	ret += toInt8(permissions.canAddMembers) * 32
	return ret
}

func GetUserPermissions(permissionsMask int8) *Permissions {
	// TODO: Implement
	return &Permissions{
		permissionsMask&1 != 0,
		permissionsMask&2 != 0,
		permissionsMask&4 != 0,
		permissionsMask&8 != 0,
		permissionsMask&16 != 0,
		permissionsMask&32 != 0,
	}
}
