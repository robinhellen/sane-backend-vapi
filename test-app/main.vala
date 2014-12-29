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

		unowned Device?[] devices = null;

		status = get_devices(out devices, Bool.FALSE);
		if(status != Status.GOOD)
		{
			stderr.printf(@"Unable to get devices: $status\n");
			return -1;
		}

		int i = 0;
		while(devices[i] != null)
		{
			stderr.printf(@"found scanner: $(devices[i].name)\n");
			++i;
		}

		if(i == 0)
		{
			stderr.printf("No scanners found.\n");
			return -1;
		}
		stderr.printf(@"Got $i devices.\n");

		var default_device = devices[0];
		Handle deviceHandle;
		status = Handle.open(default_device.name, out deviceHandle);
		if(status != Status.GOOD)
		{
			stderr.printf(@"Unable to open first scanner: $status\n");
			return -2;
		}

		deviceHandle.close();

		exit();
		return 0;
	}
}
