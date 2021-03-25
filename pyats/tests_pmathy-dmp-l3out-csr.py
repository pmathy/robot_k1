import logging, re
import tests_generics as generics

from pyats import aetest
from unicon.core.errors import TimeoutError, ConnectionError, StateMachineError

logger = logging.getLogger(__name__)

parameters = {
    'device': 'pmathy-dmp-l3out-csr',
    'vrf': 'demopipeline',
    'gateway': '10.255.1.1',
    'expectedRoutes': ['1.1.1.1/32', '2.2.2.2/32', '10.1.3.0/24']
}

class CsrGwConnTest(generics.GenericGwConnTest):
    pass

class CsrRouteTest(generics.GenericRouteTest):
    pass
