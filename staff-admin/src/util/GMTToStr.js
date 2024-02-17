


export function GMTToStr(time) {
    let date = new Date(time).toISOString()
    let Str = date.slice(0,10)
    return Str
}