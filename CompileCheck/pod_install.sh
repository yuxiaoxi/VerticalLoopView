export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export COCOAPODS_DISABLE_DETERMINISTIC_UUIDS=YES

if [ "$1"  = "clean" ]
then 
	rm -rf CompileCheck.xcworkspace
	rm -rf CompileCheck.xcodeproj/xcuserdata
	rm -rf Pods/
    rm -rf Podfile.lock
fi

if [ -d DerivedData ]
	then
		rm -rf DerivedData/
fi

pod update --no-repo-update





