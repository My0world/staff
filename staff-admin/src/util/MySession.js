export function setSession(key, value) {
    if (value instanceof Object) {
        sessionStorage.setItem(key, JSON.stringify(value))
        return
    }
    sessionStorage.setItem(key, value)
}
export function getSession(key) {
    return JSON.parse(sessionStorage.getItem(key))
}
export function clearSession() {
    sessionStorage.clear()
}