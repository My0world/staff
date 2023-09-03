export default (name, type) => {
    return new URL(`../assets/images/${name}.${type}`, import.meta.url).href
}