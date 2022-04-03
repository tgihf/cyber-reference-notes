# Prototype Pollution

In JavaScript, all objects are subclasses of the [Object class](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object). As subclasses, they inherit the fields and methods of the Object class. When a field or method is called on an object, JavaScript first sees if there is a definition for that field or method in the object's class definition. If it doesn't find one, it looks in its parent class. For example, if the `toString()` method is called on an object that hasn't defined `toString()` itself, the Object class's `toString()` definition will be used.

Prototype pollution is a vulnerability in which a web application allows user input to modify arbitrary key/value pairs on a JavaScript object. To exploit this vulnerability, an attacker uses particular fields (i.e., `.__proto__` and `.constructor.prototype`) to navigate up the inheritance hierarchy to modify key/value pairs on the Object class itself, instead of the intended object. As a result, the modified key/value pairs will be written to all other objects, since they are subclasses of the Object class. Depending on the application, this can lead to information disclosure, denial of service, or even remote code execution.

Prototype pollution is uniquely a JavaScript vulnerability. As such, frontend JavaScript code that receives user input and backend Node.js code can be susceptible.

---

## Accessing the Base Class (Prototype)

Given a particular JavaScript object, there are two popular ways of accessing its base class (prototype).

Method 1, `__proto__`:

```javascript
const a = {};
const b = {};
a.__proto__.blah = 4;
console.log(a.blah === b.blah); // true
```

Method 2, `constructor.prototype`:

```javascript
const a = {};
const b = {};
a.constructor.prototype.blah = 4;
console.log(a.blah === b.blah); // true
```

---

## Example: Prototype Pollution, Environment Variables, and `require`

See [Hack the Box - Breaking Grad](https://app.hackthebox.com/challenges/130).

---

## References

[The Daily Swig - Prototype Pollution](https://portswigger.net/daily-swig/prototype-pollution-the-dangerous-and-underrated-vulnerability-impacting-javascript-applications)

[Hack the Box - Breaking Grad](https://app.hackthebox.com/challenges/130)
