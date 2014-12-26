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
}
