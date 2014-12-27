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
	[IntegerType(rank = 6)] // basically defined to be a 32-bit type of some sort, undefined interpretation.
	[CCode(has_type_id = false)]
	public struct Word {}
	}

	[SimpleType]
	[IntegerType(rank = 6)] // defined to be a type that can hold from -2^31 to (2^31 - 1), equivalent to gint32
	[CCode(has_type_id = false)]
	public struct Int {}

	[SimpleType]
	[IntegerType(rank = 2)] // defined to be a type that can hold from 0 to (255), equivalent to gchar
	[CCode(has_type_id = false)]
	public struct Byte {}

	[SimpleType]
	[IntegerType(rank = 2)] // defined to be a type that can hold from 0 to (255), equivalent to gchar
	[CCode(has_type_id = false)]
	public struct Char {}

	[CCode(has_type_id = false)]
	public class String : GLib.string{}

	[SimpleType]
	[BooleanType]
	public struct Bool {}

	[CCode(cname="SANE_String_Const", has_type_id = false)]
	public class StringConst {}

	[CCode(has_type_id = false)]
	public struct Device
	{
		public StringConst name;
		public StringConst vendor;
		public StringConst model;
		public StringConst type;
	}

	[CCode(cname="SANE_Option_Descriptor", has_type_id = false)]
	public struct OptionDescriptor
	{
		StringConst name;
		StringConst title;
		StringConst desc;
		ValueType type;
		Unit unit;
		Int size;
		Int cap;
		ConstraintType constraint_type;

		[CCode(array_null_terminated = true, cname="constraint.string_list")]
		StringConst[] string_list;

		[CCode(array_length = false, cname="constraint.word_list")] // Array length is first element of the array
		Word[] word_list;

		[CCode(cname="constraint.range")]
		Range range;
	}

	[CCode(has_type_id = false)]
	public struct Range
	{
		Word min;
		Word max;
		Word quant;
	}

	[CCode(has_type_id = false)]
	public struct Parameters
	{
		Frame format;
		Bool last_frame;
		Int bytes_per_line;
		Int pixels_per_line;
		Int lines;
		Int depth;
	}

	[CCode(cname="SANE_Value_Type", cprefix="TYPE_", has_type_id = false)]
	public enum ValueType
	{
		BOOL,
		INT,
		FIXED,
		STRING,
		BUTTON,
		GROUP
	}

	[CCode(cprefix="UNIT_", has_type_id = false)]
	public enum Unit
	{
		NONE,
		PIXEL,
		BIT,
		MM,
		DPI,
		PERCENT,
		MICROSECOND
	}

	[CCode(cname="SANE_Constraint_Type", cprefix="CONSTRAINT_", has_type_id = false)]
	public enum ConstraintType
	{
		NONE,
		RANGE,
		WORD_LIST,
		STRING_LIST
	}

	[CCode(cprefix="ACTION_", has_type_id = false)]
	public enum Action
	{
		GET_VALUE,
		SET_VALUE,
		SET_AUTO
	}

	[CCode(cprefix="FRAME_", has_type_id = false)]
	public enum Frame
	{
		GRAY,
		RGB,
		RED,
		GREEN,
		BLUE
	}

	[CCode(has_construct_function = false, has_copy_function = false, has_destroy_function = false, has_type_id = false)]
	public class Handle
	{
		[CCode(cname="sane_open")]
		public static Status open(StringConst name, out Handle h);

		[CCode(cname="sane_close")]
		[DestroysInstance]
		public void close();

		[CCode(cname="sane_get_option_descriptor")]
		public unowned OptionDescriptor get_option_descriptor(Int n);

		[CCode(cname="sane_control_option")]
		public Status control_option(Int n, Action a, void *v, out Int i);

		[CCode(cname="sane_get_parameters")]
		public Status get_parameters(out Parameters p);

		[CCode(cname="sane_start")]
		public Status start();

		[CCode(cname="sane_read")]
		public Status read([CCode(array_length_pos = 1.1)]Byte[] buf, out Int len);
	}

	[CCode(cname="SANE_Authorization_Callback")]
	public delegate void AuthorizationCallback(
		StringConst resource,
		[CCode(array_length_cexpr="SANE_MAX_USERNAME_LEN")]Char username[],
		[CCode(array_length_cexpr="SANE_MAX_PASSWORD_LEN")]Char password[]
	);

	public Status init(out Int version_code, AuthorizationCallback authorize);

	public void exit();

	public Status get_devices([CCode(array_null_terminated = true)]out unowned Device[] device_list, Bool local_only);
}
