using Sane;

namespace TestApp
{
	public static int main(string[] args)
	{
		Int saneVersion;
		var status = init(out saneVersion, null);
		if(status != Status.GOOD)
		{
			stderr.printf(@"Unable to initialize SANE library: $status\n");
			return -1;
		}
		stderr.printf(@"Successfully initialized library\n");

		unowned Device[] devices = null;

		status = get_devices(out devices, Bool.FALSE);
		if(status != Status.GOOD)
		{
			stderr.printf(@"Unable to get devices: $status\n");
			return -1;
		}

		stderr.printf(@"Got devices.\n");
		exit();
		return 0;
	}
}
