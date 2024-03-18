

import employees from './model/employees'
import login from './model/login'
import operatingRequest from './model/operatingRequest'
import operatingData from './model/operatingData'
import feedback from './model/feedback'
import dimission from './model/dimission'


export default {
    ...employees,
    ...login,
    ...operatingRequest,
    ...operatingData,
    ...feedback,
    ...dimission
}
