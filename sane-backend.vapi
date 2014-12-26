/* sane-backend.vapi written by Robin Hellen */

[CCode(cprefix="SANE_", lower_case_cprefix="sane_")]
namespace Sane
{
	[CCode (cprefix="STATUS_", has_type_id = false)]
	public enum Status
	{
		GOOD,
		UNSUPPORTED,
		CANCELLED,
		DEVICE_BUSY,
		INVAL,
		EOF,
		JAMMED,
		NO_DOCS,
		COVER_OPEN,
		IO_ERROR,
		NO_MEM,
		ACCESS_DENIED
	}

	[SimpleType]
	[IntegerType(rank = 6)] // defined to be a type that can hold from -2^31 to (2^31 - 1), equivalent to gint32
	[CCode(has_type_id = false)]
	public struct Int {}

	[SimpleType]
	[IntegerType(rank = 2)] // defined to be a type that can hold from 0 to (255), equivalent to gchar
	[CCode(has_type_id = false)]
	public struct Char {}

	[CCode(has_type_id = false)]
	public class String : GLib.string{}

	[CCode(cname="SANE_String_Const", has_type_id = false)]
	public class StringConst {}

	[CCode(cname="SANE_Authorization_Callback")]
	public delegate void AuthorizationCallback(
		StringConst resource,
		[CCode(array_length_cexpr="SANE_MAX_USERNAME_LEN")]Char username[],
		[CCode(array_length_cexpr="SANE_MAX_PASSWORD_LEN")]Char password[]
	);

	public Status init(out Int version_code, AuthorizationCallback authorize);
}
