allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

// Load the key.properties file if it exists
val keyProperties = rootProject.file("android/app-key.properties")
if (keyProperties.exists()) {
    val properties = java.util.Properties()
    keyProperties.inputStream().use { properties.load(it) }

    // Pass the properties to the Gradle build script
    project.extensions.extraProperties["keyProperties"] = properties
}

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
