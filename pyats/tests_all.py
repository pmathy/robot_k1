import logging

from pyats import aetest
from unicon.core.errors import TimeoutError, ConnectionError, StateMachineError

logger = logging.getLogger(__name__)

class CommonSetup(aetest.CommonSetup):
    @aetest.subsection
    def connect(self, testbed):
        assert testbed, "Testbed is not provided!"

        try:
            testbed.connect()
        except (TimeoutError, ConnectionError, StateMachineError):
            logger.error("Unable to connect to all devices")

class BasicConnTest(aetest.Testcase):

    @aetest.test
    def testOobConnectivity(self, testbed, steps):
        for device_name, device in testbed.devices.items():
            with steps.start(
                f"Test Connection Status of {device_name}", continue_=True
            ) as step:
                # Test "connected" status
                if device.connected:
                    logger.info(f"{device_name} connected status: {device.connected}")
                else:
                    logger.error(f"{device_name} connected status: {device.connected}")
                    step.failed()