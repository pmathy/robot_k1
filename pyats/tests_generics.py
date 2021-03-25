import logging, re

from pyats import aetest
from unicon.core.errors import TimeoutError, ConnectionError, StateMachineError

logger = logging.getLogger(__name__)


class GenericGwConnTest(aetest.Testcase):

    @aetest.test
    def testGatewayReachability(self, testbed, device, vrf, gateway):

        try:
            result = testbed.devices[device].ping(gateway, vrf=vrf)

        except Exception as e:
            self.failed('Ping {} from device {} failed with error: {}'.format(gateway,device,str(e),),goto = ['exit'])

        else:
            match = re.search(r'Success rate is (?P<rate>\d+) percent', result)
            success_rate = match.group('rate')

            logger.info('Ping {} with success rate of {}%'.format(gateway,success_rate,))

class GenericRouteTest(aetest.Testcase):

    @aetest.setup
    def learnRoutingInfo(self, testbed, device, vrf):
        
        try:
            self.parameters['routingInfo'] = testbed.devices[device].learn('routing', vrf=vrf).info

        except Exception as e:
            self.failed('Routing Information from device {} could not be read, failed with error: {}'.format(device,str(e),),goto = ['exit'])

    @aetest.test
    def testRoutingInfo(self, device, vrf):
        routeList = self.parameters['routingInfo']['vrf'][vrf]['address_family']['ipv4']['routes'].keys()
        expectedRouteList = self.parameters['expectedRoutes']

        if not all(item in routeList for item in expectedRouteList):
            self.failed('Routing Table on device {} does not match the expected routes. Routes found were:\n{}'.format(device, list(routeList)),goto = ['exit'])

        else:
            logger.info('Route Table Match successful on device {}.'.format(device))
