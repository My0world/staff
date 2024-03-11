

import employees from './model/employees'
import login from './model/login'
import operatingRequest from './model/operatingRequest'

export default {
    ...employees,
    ...login,
    ...operatingRequest
}
