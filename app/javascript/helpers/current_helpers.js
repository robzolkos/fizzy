// On-demand JavaScript objects from "current" HTML <meta> elements. Example:
//
// <meta name="current-identity-id" content="123">
// <meta name="current-identity-time-zone-name" content="Central Time (US & Canada)">
//
// >> current.identity
// => { id: "123", timeZoneName: "Central Time (US & Canada)" }
//
// >> current.foo
// => {}
  export const current = new Proxy({}, {
    get(_target, propertyName) {
      const result = {}
      const prefix = `current-${propertyName}-`
      for (const { name, content } of document.head.querySelectorAll(`meta[name^=${prefix}]`)) {
        const key = camelize(name.slice(prefix.length))
        result[key] = content
      }
      return result
    }
  })

  function camelize(string) {
    return string.replace(/(?:[_-])([a-z0-9])/g, (_, char) => char.toUpperCase())
  }
