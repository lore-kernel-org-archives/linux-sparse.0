From: alexey.zaytsev@gmail.com
Subject: [PATCH 09/10] Rewrite cgcc, add cld and car to wrap ld and ar
Date: Thu,  4 Sep 2008 01:55:53 +0400
Message-ID: <5a555e4fe88da659e97a22698d58e6e54ec57f54.1220475018.git.xl0@xl0.local>
References: <1220478954-22678-1-git-send-email-alexey.zaytsev@gmail.com>
 <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
 <6f37eec18608be0a86356a874836bea516317084.1220475018.git.xl0@xl0.local>
 <2faea660ccc7cae55a2d2cd28f64059b80356a8f.1220475018.git.xl0@xl0.local>
 <c97fb6bb13fb17d09a2d1525cb5b813ecebb804d.1220475018.git.xl0@xl0.local>
 <b0118cf8f9301f77a141af47739aa599ae1e624b.1220475018.git.xl0@xl0.local>
 <ad58a8f48bbd496a896ef370772e8a12101560f5.1220475018.git.xl0@xl0.local>
 <eb541a9449e5ec380212c85093d3ef206db1db4d.1220475018.git.xl0@xl0.local>
 <22963cd6ccaf20f03b680bde72da86355da740b3.1220475018.git.xl0@xl0.local>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.189]:30220 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYICVyH (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 3 Sep 2008 17:54:07 -0400
Received: by mu-out-0910.google.com with SMTP id g7so2911410muf.1
        for <linux-sparse@vger.kernel.org>; Wed, 03 Sep 2008 14:54:06 -0700 (PDT)
In-Reply-To: <22963cd6ccaf20f03b680bde72da86355da740b3.1220475018.git.xl0@xl0.local>
In-Reply-To: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
References: <20df58606337d58576ba3c10cf8f8c1522f81f91.1220475018.git.xl0@xl0.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Josh Triplett <josh@kernel.org>, Chris Li <christ.li@gmail.com>, Codrin Alexandru Grajdeanu <grcodal@gmail.com>, Alexey Zaytsev <alexey.zaytsev@gmail.com>

From: Alexey Zaytsev <alexey.zaytsev@gmail.com>

cgcc now compiles the serialized data produced by sparse
and also now it is able to handle multiple source files
well.

cld and car are there to integrate the sparse linker
into your build environment, wrapping ld and ar, and
compiling the data serialized by the sparse linker.

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---
 Makefile |    2 +-
 car      |   72 ++++++++++++++++++
 cgcc     |  252 ++++++++++++++++++++++++++++++++++++++++++++++++++++----------
 cld      |   84 +++++++++++++++++++++
 4 files changed, 369 insertions(+), 41 deletions(-)
 create mode 100755 car
 create mode 100755 cld

diff --git a/Makefile b/Makefile
index 4fa2f82..877634c 100644
--- a/Makefile
+++ b/Makefile
@@ -29,7 +29,7 @@ PROGRAMS=test-lexing test-parsing obfuscate compile graph sparse test-linearize
 	 test-unssa test-dissect ctags serialization-test sold
 
 
-INST_PROGRAMS=sparse cgcc sold
+INST_PROGRAMS=sparse sold cgcc cld car
 INST_MAN1=sparse.1 cgcc.1
 
 ifeq ($(HAVE_LIBXML),yes)
diff --git a/car b/car
new file mode 100755
index 0000000..5da892d
--- /dev/null
+++ b/car
@@ -0,0 +1,72 @@
+#!/usr/bin/perl -w
+
+use strict;
+
+my $ar = $ENV{'REAL_AR'} || 'ar';
+my $linker = $ENV{'CLD'} || 'cld';
+
+my $verbose = 1;
+my $do_real_ar = 1;
+my $do_ar = 1;
+
+my $options = "";
+
+# We assume the first argument be the option string,
+# the second - the output name and all other - input names.
+
+die "Not enough arguments" if @ARGV < 2;
+
+foreach(@ARGV) {
+    if ($_ eq '-no-archive') {
+        $do_ar = 0;
+        next;
+    }
+
+    if ($_ eq '-no-real-archive') {
+        $do_real_ar = 0;
+        next;
+    }
+
+    if ($_ eq '-check-verbose') {
+        $verbose = 1;
+        next;
+    }
+
+    $options .= ' ' . &quote_arg ($_);
+}
+
+if ($do_real_ar) {
+    print STDERR "$ar $options\n" if $verbose;
+    my $res = system("$ar $options");
+    $res >>= 8;
+
+    exit $res if $res;
+}
+
+# We use our existing linker wrapper, as it basically does
+# the same thing.
+if ($do_ar) {
+    shift @ARGV; # remove the option string.
+    my $out = shift @ARGV;
+    my $inputs = join(" ", @ARGV); # everything else is an input file
+
+    if ($inputs) {
+        print STDERR "$linker -no-real-link -o $out $inputs";
+        system ("$linker -no-real-link -o $out $inputs");
+    }
+}
+
+exit 0;
+
+# -----------------------------------------------------------------------------
+# Simple arg-quoting function.  Just adds backslashes when needed.
+
+sub quote_arg {
+    my ($arg) = @_;
+    return "''" if $arg eq '';
+    return join ('',
+		 map {
+		     m|^[-a-zA-Z0-9._/,=]+$| ? $_ : "\\" . $_;
+		 } (split (//, $arg)));
+}
+
diff --git a/cgcc b/cgcc
index 89adbed..4484d0c 100755
--- a/cgcc
+++ b/cgcc
@@ -1,75 +1,242 @@
 #!/usr/bin/perl -w
 # -----------------------------------------------------------------------------
 
+use strict;
+
 my $cc = $ENV{'REAL_CC'} || 'cc';
+my $host_cc = $ENV{'HOST_CC'} || 'cc';
 my $check = $ENV{'CHECK'} || 'sparse';
+my $linker = $ENV{'SOLD'} || 'sold';
+
+my $cc_args = "";
+my $link_args = "";
+
+my @check_args_array;
 
 my $m32 = 0;
 my $m64 = 0;
 my $has_specs = 0;
-my $gendeps = 0;
-my $do_check = 0;
+my $do_check = 1;
+my $follow_check_status = 1;
 my $do_compile = 1;
+my $do_emit_code = 0;
+my $do_link = 1;
 my $verbose = 0;
 
-foreach (@ARGV) {
-    # Look for a .c file.  We don't want to run the checker on .o or .so files
-    # in the link run.  (This simplistic check knows nothing about options
-    # with arguments, but it seems to do the job.)
-    $do_check = 1 if /^[^-].*\.c$/;
+my @inputs;
+my $output;
 
-    # Ditto for stdin.
-    $do_check = 1 if $_ eq '-';
+my $compile_res = 0;
+my $check_res = 0;
 
-    $m32 = 1 if /^-m32$/;
-    $m64 = 1 if /^-m64$/;
-    $gendeps = 1 if /^-M$/;
+# split the gcc and sparse options.
+while (@ARGV) {
+    my $quote_arg;
+    $_ = shift @ARGV;
 
-    if (/^-specs=(.*)$/) {
-	$check .= &add_specs ($1);
-	$has_specs = 1;
-	next;
+    if ($_ eq '-no-compile') {
+        $do_compile = 0;
+        next;
     }
 
-    if ($_ eq '-no-compile') {
-	$do_compile = 0;
-	next;
+    if ($_ eq '-no-check') {
+        $do_check = 0;
+        next;
+    }
+
+    # Don't abort the build if the checker fails.
+    if ($_ eq '-no-follow-check-status') {
+        $follow_check_status = 0;
+        next;
+    }
+
+    if (/^-v+$/) {
+        $verbose = 1;
+        next;   # You probably didn't mean passing -v to gcc, right?
+                # Run with REAL_CC='cc -v' in such case.
     }
 
     # If someone adds "-E", don't pre-process twice.
-    $do_compile = 0 if $_ eq '-E';
+    # We can't disable compilation, because the caller may be asking
+    # gcc for its version (e.g. the Linux kernel does this).
+    $do_check = 0 if ($_ eq '-E' && $do_compile);
 
-    $verbose = 1 if $_ eq '-v';
+    # Don't check if called to generate dependencies.
+    $do_check = 0 if /^-M[MFGPQT]?$/;
 
     my $this_arg = ' ' . &quote_arg ($_);
-    $cc .= $this_arg unless &check_only_option ($_);
-    $check .= $this_arg unless &cc_only_option ($_);
+    $cc_args .= $this_arg unless &check_only_option ($_);
+    push @check_args_array, $_ unless &cc_only_option ($_);
 }
 
-if ($gendeps) {
-    $do_compile = 1;
-    $do_check = 0;
+if ($do_compile) {
+    print STDERR "cgcc: $cc $cc_args\n" if $verbose;
+    $compile_res = system ("$cc $cc_args") >> 8;
 }
 
 if ($do_check) {
-    if (!$has_specs) {
-	$check .= &add_specs ('host_arch_specs');
-	$check .= &add_specs ('host_os_specs');
+    my $check_args = "";
+
+    my @src_inputs;
+    my @link_inputs;
+    my $src_out;
+    my $link_out;
+
+    while(@check_args_array) {
+        $_ = shift @check_args_array;
+
+        # There are some options that cause gcc to only print some
+        # information, an not actually compile anything.
+
+        if (/^--(targer-)?help$/ ||
+            /^-dump(specs|version|machine)$/ ||
+            /^-print-*/) {
+
+            exit $compile_res;
+        }
+
+	if (/-arch=(\.*)$/) {
+		$check_args .= &add_specs ($1);
+		$has_specs = 1;
+		next;
+	}
+
+        # Everything that does not start with a dash, or is a dash itself is an input
+        if (!/^-+\w+/) {
+            push @inputs, $_;
+            next;   # We do not pass input files to sparse, instead
+                    # we run sparse for each input.
+        }
+
+        $m32 = 1 if /^-m32$/;
+        $m64 = 1 if /^-m64$/;
+
+        if ($_ eq '-emit-code') {
+            $do_emit_code = 1;
+        }
+
+        $do_link = 0 if $_ eq '-c' or $_ eq '-S';
+
+        # Output file.
+        if (/^-o(.*)/) {
+            if ($1) { # -ofoo
+                $output = $1;
+            } else { # -o foo
+            $output = shift @check_args_array;
+            if (!$output) { # terminal -o
+                die("$0: argument to '-o' is missing");
+                }
+            }
+            next;
+        }
+
+        if (/^-Wl,/) {
+            my @args = split /,/;
+            shift @args;
+            if ($do_link) {
+                $link_args .= join(" ", @args) . " ";
+            } else {
+                push @inputs, @args;    # Yes! Gcc interprets the -Wl options
+                                        # as inputs files, when runnign with -c.
+            }
+            next;
+        }
+
+        # Now there are some options that take arguments possibly separated
+        # with spaces. We have to recognise them to destinguish between
+        # option arguments and input files. Not really tested...
+        if (/^-D(.*)$/ ||
+		    /^-I(.*)$/ ||
+            /^-B(.*)$/ ||
+            /^-MF(.*)$/ ||
+            /^-MT(.*)$/ ||
+            /^-MQ(.*)$/ ||
+            /^-include$/ ||
+            /^-imacros$/ ||
+            /^-isystem$/) {
+            $check_args .= ' ' . &quote_arg ($_);
+            if (!$1) { 
+                $check_args .= ' ' . &quote_arg (shift @check_args_array);
+                # sparse should warn is the argument is actually missing.
+            }
+            next;
+	    }
+
+        # Ok, just a usual gcc option.
+        $check_args .= ' ' . &quote_arg ($_);
     }
-    print "$check\n" if $verbose;
-    if ($do_compile) {
-	system ($check);
-    } else {
-	exec ($check);
+
+    # gcc can have two types of inputs, sources and objects files.
+    # The sources we compile, the objects we link if needed
+    foreach(@inputs) {
+        if (/(\.[ch]|^-)$/) {
+            push @src_inputs, $_;
+        } else {
+            if ($do_link) {
+                push @link_inputs, $_;
+            } else {
+                warn "$0: $_: input file ignored because linking not performed";
+            }
+        }
     }
-}
 
-if ($do_compile) {
-    print "$cc\n" if $verbose;
-    exec ($cc);
+    if ($output) {
+        if ($do_link) {
+            $link_out = $output;
+        } else {
+            $src_out = $output;
+            die "$0: cannot specify -o with -c or -S with multiple files"  if @src_inputs > 1;
+        }
+    }
+
+    foreach (@src_inputs) {
+        my $in = $_;
+        my $out = $_;
+
+        # Won't feed stdin to both gcc and sparse.
+        if ($in =~ s/^-$//) {
+            next if $do_compile;
+        }
+
+        $out =~ s/\.[ch]$/\.o/;
+        $out =~ s/^-$/sparsedump/;
+
+        # In case output was explicitly specified with -o and no linking
+        # is performed, there can't be more than one source.
+
+        $out = $src_out ? $src_out : $out;
+
+        $check .= &add_specs ('host_arch_specs');
+        $check .= &add_specs ('host_os_specs');
+
+        print STDERR "cgcc: $check $check_args $in -o $out\n" if $verbose;
+
+        $check_res = system ("$check $check_args $in -o $out") >> 8;
+        if ($do_emit_code && !$check_res) {
+            # compile the code generated by sparse.
+            print "$host_cc -shared -fPIC $out.sparse.c -o $out.sparse.so\n" if $verbose;
+            system ("$host_cc -shared -fPIC $out.sparse.c -o $out.sparse.so");
+        }
+
+        # Add the checked file to the link list.
+        push @link_inputs, "$out";
+    }
+
+    if ($do_emit_code && !$check_res && $do_link && @link_inputs > 0) {
+    	my $out = $link_out ? $link_out : "a.out";
+        my $link_cmd = "$linker $link_args -o $out " . join(" ", @link_inputs);
+        print STDERR "cgcc: $link_cmd\n" if $verbose;
+        my $res = system($link_cmd);
+        if ($do_emit_code && !($res >> 8)) {
+            # compile the code generated by the linker.
+            print "$host_cc -shared -fPIC $out.sparse.c -o $out.sparse.so\n" if $verbose;
+            system ("$host_cc -shared -fPIC $out.sparse.c -o $out.sparse.so");
+        }
+    }
 }
 
-exit 0;
+my $res = $follow_check_status ? ($check_res | $compile_res ) : $compile_res;
+exit $res;
 
 # -----------------------------------------------------------------------------
 # Check if an option is for "check" only.
@@ -78,6 +245,9 @@ sub check_only_option {
     my ($arg) = @_;
     return 1 if $arg =~ /^-W(no-?)?(default-bitfield-sign|one-bit-signed-bitfield|cast-truncate|bitwise|typesign|context|undef|ptr-subtraction-blows|cast-to-as|decl|transparent-union|address-space|enum-mismatch|do-while|old-initializer|non-pointer-null|paren-string|return-void)$/;
     return 1 if $arg =~ /^-v(no-?)?(entry|dead)$/;
+    return 1 if $arg =~ /^-emit-code$/;
+    return 1 if $arg =~ /^-arch=.*$/;
+    return 1 if $arg =~ /^-v+$/; # You almost certainly don't want to pass -v to gcc.
     return 0;
 }
 
@@ -90,6 +260,8 @@ sub cc_only_option {
     # ones.  Don't include it just because a project wants to pass -Wall to cc.
     # If you really want cgcc to run sparse with -Wall, use
     # CHECK="sparse -Wall".
+
+    return 1 if $arg =~ /^-specs=.*$/;
     return 1 if $arg =~ /^-Wall$/;
     return 0;
 }
@@ -166,7 +338,7 @@ sub float_types {
 	     'EPSILON' => '1.92592994438723585305597794258492732e-34',
 	     'DENORM_MIN' => '6.47517511943802511092443895822764655e-4966',
 	 },
-	 );	     
+	 );
 
     my @types = (['FLT','F'], ['DBL',''], ['LDBL','L']);
     while (@types) {
diff --git a/cld b/cld
new file mode 100755
index 0000000..95196f4
--- /dev/null
+++ b/cld
@@ -0,0 +1,84 @@
+#!/usr/bin/perl -w
+
+use strict;
+
+my $host_cc = $ENV{'HOST_CC'} || 'cc';
+my $real_linker = $ENV{'REAL_LD'} || 'ld';
+my $linker = $ENV{'SOLD'} || 'sold';
+
+my $verbose = 1;
+my $linker_options = "";
+
+my $do_link = 1;
+my $do_real_link = 1;
+
+my $out;
+
+while(@ARGV) {
+    $_ = shift @ARGV;
+
+    if ($_ eq '-no-link') {
+        $do_link = 0;
+        next;
+    }
+
+    if ($_ eq '-no-real-link') {
+        $do_real_link = 0;
+        next;
+    }
+
+    if ($_ eq '-check-verbose') {
+        $verbose = 1;
+        next;
+    }
+
+    # We need to know the output file name to compile the
+    # generated code.
+    if (/^-o(.*)/) {
+        if ($1) { # -ofoo
+            $out = $1;
+        } else { # -o foo
+        $out = shift @ARGV;
+        if (!$out) { # terminal -o
+            die("$0: argument to '-o' is missing");
+            }
+        }
+        next;
+    }
+
+    $linker_options .= ' ' . &quote_arg ($_);
+}
+
+$out = 'a.out' if !$out;
+
+if ($do_real_link) {
+    print STDERR "$real_linker $linker_options -o $out\n" if $verbose;
+    my $res = system ("$real_linker $linker_options -o $out");
+    $res >>= 8;
+    exit $res if $res;
+}
+
+if ($do_link) {
+
+    print STDERR "$linker $linker_options -o $out\n" if $verbose;
+    my $res = system ("$linker $linker_options -o $out");
+    exit 0 if $res >> 8; # Don't fail the whole build.
+
+    # compile the code generated by sold.
+    print STDERR "$host_cc -shared -fPIC $out.sparse.c -o $out.sparse.so\n" if $verbose;
+    system ("$host_cc -shared -fPIC $out.sparse.c -o $out.sparse.so");
+}
+
+exit 0;
+
+# -----------------------------------------------------------------------------
+# Simple arg-quoting function.  Just adds backslashes when needed.
+
+sub quote_arg {
+    my ($arg) = @_;
+    return "''" if $arg eq '';
+    return join ('',
+		 map {
+		     m|^[-a-zA-Z0-9._/,=]+$| ? $_ : "\\" . $_;
+		 } (split (//, $arg)));
+}
-- 
1.5.6.3

