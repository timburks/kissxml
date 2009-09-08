(set platform "native")

(case platform
      ("iPhone"
               (set PLATFORM "-isysroot /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk")
               (set @arch '("armv6"))
               (set @cc "/Developer/Platforms/iPhoneOS.platform/Developer/usr/bin/gcc-4.0"))
      ("simulator"
                  (set PLATFORM "-isysroot /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator2.0.sdk")
                  (set @arch '("i386")))
      ("native"
                  (set @cc "/usr/bin/gcc")
                  (set PLATFORM "")
                  (set @arch '("i386" "ppc")))
      (else nil))

(set SYSTEM ((NSString stringWithShellCommand:"uname") chomp))
(case SYSTEM
      ("Darwin"
  	       (set @cflags "-I /usr/include/libxml2 -g -ObjC -Iinclude -std=gnu99 #{PLATFORM} -mmacosx-version-min=10.5")
               (set @ldflags "-framework Foundation -lxml2"))
      ("Linux"
              (set @arch (list "i386"))
              (set gnustep_flags ((NSString stringWithShellCommand:"gnustep-config --objc-flags") chomp))
              (set gnustep_libs ((NSString stringWithShellCommand:"gnustep-config --base-libs") chomp))
              (set @cflags "-I /usr/include/libxml2 -g -Iinclude -std=gnu99 #{gnustep_flags}")
              (set @ldflags "#{gnustep_libs}"))
      (else nil))



(set @h_files	  (filelist "^objc/.*.h$"))
(set @m_files     (filelist "^objc/.*.m$"))
(set @nu_files 	  (filelist "^nu/.*nu$"))


(set @framework "KissXML")
(set @framework_identifier "nu.programming.nusax")
(set @framework_creator_code "????")
(set @framework_install_path "@executbale_path/../Frameworks")

(compilation-tasks)
(framework-tasks)


(task "test" => "framework" is
     (SH "nutest test/test_*.nu"))
                     
(task "default" => "framework")

(task "clobber" => "clean" is
      (SH "rm -rf build")
      (SH "rm -rf #{@framework_dir}")
      (SH "rm -f example1"))

(task "install" => "framework" is
      (SH "sudo rm -rf /Library/Frameworks/#{@framework}.framework")
      (SH "sudo cp -rp #{@framework}.framework /Library/Frameworks/#{@framework}.framework"))

(task "example" is
      (SH "#{@cc} examples/example1.m -o example1 -lxml2 -I/usr/include/libxml2 -framework Cocoa -framework KissXML"))
