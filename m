From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 19/28] testsuite: allow arch-specific tests
Date: Fri, 15 Sep 2017 09:13:49 +0200
Message-ID: <20170915071358.7312-20-luc.vanoostenryck@gmail.com>
References: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37360 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbdIOHQ0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 15 Sep 2017 03:16:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id f4so1958205wmh.4
        for <linux-sparse@vger.kernel.org>; Fri, 15 Sep 2017 00:16:26 -0700 (PDT)
In-Reply-To: <20170915071358.7312-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/test-suite |  5 +++++
 validation/test-suite    | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/test-suite b/Documentation/test-suite
index a745da850..3c07100e7 100644
--- a/Documentation/test-suite
+++ b/Documentation/test-suite
@@ -22,6 +22,11 @@ check-command: <command arg ...>
 	run time.
 	It defaults to "sparse $file".
 
+check-arch-ignore: <arch[|...]>
+check-arch-only: <arch[|...]>
+	Ignore the test if the current architecture (as returned by 'uname -m')
+	match or not one of the archs given in the pattern.
+
 check-exit-value: <value>
 	The expected exit value of check-command. It defaults to 0.
 
diff --git a/validation/test-suite b/validation/test-suite
index 84e359fb8..746c0fb3a 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -56,6 +56,8 @@ get_tag_value()
 	check_output_excludes=0
 	check_output_pattern=0
 	check_output_pattern_minmax=0
+	check_arch_ignore=""
+	check_arch_only=""
 
 	lines=$(grep 'check-[a-z-]*' $1 | \
 		sed -e 's/^.*\(check-[a-z-]*:*\) *\(.*\)$/\1 \2/')
@@ -76,6 +78,10 @@ get_tag_value()
 		check-output-excludes:)	check_output_excludes=1 ;;
 		check-output-pattern-)	check_output_pattern=1 ;;
 		check-output-pattern)	check_output_pattern_minmax=1 ;;
+		check-arch-ignore:)	arch=$(uname -m)
+					check_arch_ignore="$val" ;;
+		check-arch-only:)	arch=$(uname -m)
+					check_arch_only="$val" ;;
 		esac
 	done << EOT
 	$lines
@@ -271,6 +277,18 @@ do_test()
 			return 3
 		fi
 	done
+	if [ "$check_arch_ignore" != "" ]; then
+		if echo $arch | egrep -q -w "$check_arch_ignore"; then
+			disable "$test_name" "$file"
+			return 3
+		fi
+	fi
+	if [ "$check_arch_only" != "" ]; then
+		if ! (echo $arch | egrep -q -w "$check_arch_only"); then
+			disable "$test_name" "$file"
+			return 3
+		fi
+	fi
 
 	cmd=`eval echo $default_path/$check_command`
 
-- 
2.14.0

