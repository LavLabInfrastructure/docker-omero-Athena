import pytest

import Ice
import omero.clients
from omero.cli import CLI


loginstrings = [
    # ssl and wss are configured
    'omeroserver',
    'ssl://omeroserver',
    'ssl://omeroserver:4064',
    'wss://omeroserver:4066',
    'wss://omeroserver:4066/path/is/ignored',

    # Nginx allows http (and therefore ws) even though OMERO only has wss
    'wss://nginx/omero-wss',
    'wss://nginx:443/omero-wss',
    'ws://nginx/omero-wss',
    'ws://nginx:80/omero-wss',
]

nologinstrings = [
    # tcp and ws are disabled
    'tcp://omeroserver',
    'ws://omeroserver:4065',
    # A path is required for nginx websocket proxy
    'wss://nginx:443/',
    'ws://nginx:80/',
]


class TestCLIConnection(object):

    @pytest.mark.parametrize('connstr', loginstrings)
    def test_cli_login(self, connstr):
        c = CLI()
        c.loadplugins()
        c.invoke(
            'login -q -C {} -u root -w omero'.format(connstr), strict=True)
        c.invoke('logout', strict=True)

    @pytest.mark.parametrize('connstr', nologinstrings)
    def test_cli_nologin(self, connstr):
        c = CLI()
        c.loadplugins()
        with pytest.raises(omero.cli.NonZeroReturnCode):
            c.invoke(
                'login -q -C {} -u root -w omero'.format(connstr), strict=True)


class TestClientConnection(object):

    @pytest.mark.parametrize('connstr', loginstrings)
    def test_client_login(self, connstr):
        c = omero.client(connstr)
        c.createSession('root', 'omero')
        c.closeSession()

    @pytest.mark.parametrize('connstr', nologinstrings)
    def test_client_nologin(self, connstr):
        c = CLI()
        c.loadplugins()
        with pytest.raises(Exception) as exc:
            c = omero.client(connstr)
            c.createSession('root', 'omero')
        assert issubclass(exc.type, (
            Ice.ConnectionRefusedException,
            Ice.ConnectionLostException,
            Ice.ProtocolException,
        ))
