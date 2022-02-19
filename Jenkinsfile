#!/usr/bin/groovy
def appName = "Flavor Demo"

node('someNode') {
	withEnv(["PATH=path-to-a-flutter-bin:$PATH"]) {
        def flavorName = env.BRANCH_NAME;

		if (flavorName == 'development' || flavorName == 'recette' || flavorName == 'production') {
			def appNameAndroid = appName + "-${flavorName}-" + env.BUILD_NUMBER + ".aab";
			def appNameiOS = appName + "-${flavorName}-" + env.BUILD_NUMBER + ".ipa";
            def exportPlistFile = "./ios/exportOptions.${flavorName}.plist"

            stage('flutter doctor') {
                sh "flutter doctor"
            }
		
			stage("Build AAB Flutter Android for flavor ${flavorName}") {
				sh "mkdir -p build_ci"
				sh """
					flutter build appbundle --release --flavor ${flavorName} -t lib/main-${flavorName}.dart
					cp -pr build/app/outputs/bundle/${flavorName}Release/app-${flavorName}-release.aab build_ci/flutter_app.aab
				"""
			}

            stage("Build IPA Flutter iOS for flavor ${flavorName}") {
                sh "mkdir -p build_ci"
                sh """
                    export LANG=en_US.UTF-8
                    flutter build ipa --release --flavor ${flavorName} -t lib/main-${flavorName}.dart
                    xcodebuild -exportArchive -archivePath ./build/ios/archive/Runner.xcarchive -exportOptionsPlist ${exportPlistFile} -exportPath flutter_app_ios
                    mv flutter_app_ios/*.ipa ./build_ci/flutter_app.ipa
                """
            }

			stage('Creating Artifacts') {
				dir("build_ci") {
					sh "mv flutter_app.aab ${appNameAndroid}"
					sh "mv flutter_app.ipa ${appNameiOS}"


					archiveArtifacts allowEmptyArchive: true, artifacts: appNameAndroid
					archiveArtifacts allowEmptyArchive: true, artifacts: appNameiOS
				}
			}
		}
	}
}
