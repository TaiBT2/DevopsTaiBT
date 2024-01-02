// String text ="hell2232o" 
// println(text)

def listApp = [
    key1 : "hello",
    key2 : "Tai"
]

String demo = ""
if (demo.isEmpty()) {
    println "null"
}

// listApp.each {
//     key, val -> 
//     println "$val"
// }

for (key in listApp.keySet()) {
    // println "$key"
    if(key == null) {
        println "hello $key"
    }else {
        println "wrong"
    }
}
