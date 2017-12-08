From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 09/16] testsuite: validate the 'check-...' tags
Date: Fri,  8 Dec 2017 14:14:48 +0100
Message-ID: <20171208131455.7786-10-luc.vanoostenryck@gmail.com>
References: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39518 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbdLHNPT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 8 Dec 2017 08:15:19 -0500
Received: by mail-wm0-f68.google.com with SMTP id i11so3132838wmf.4
        for <linux-sparse@vger.kernel.org>; Fri, 08 Dec 2017 05:15:18 -0800 (PST)
In-Reply-To: <20171208131455.7786-1-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Making a typo in one of the 'check-...' tags can make
a testcase useless and thus incapable of detecting a regression.

Add some validation to these tags in order to detect wrong
tags.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/validation/test-suite b/validation/test-suite
index 6a939846f..d50a3bfa2 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -108,6 +108,18 @@ get_tag_value()
 					check_arch_ignore="$val" ;;
 		check-arch-only:)	arch=$(uname -m)
 					check_arch_only="$val" ;;
+
+		check-description:)	;;	# ignore
+		check-note:)		;;	# ignore
+		check-warning:)		;;	# ignore
+		check-error-start)	;;	# ignore
+		check-error-end)	;;	# ignore
+		check-output-start)	;;	# ignore
+		check-output-end)	;;	# ignore
+		check-should-pass)	;;	# ignore, unused annotation
+		check-should-fail)	;;	# ignore, unused annotation
+		check-should-warn)	;;	# ignore, unused annotation
+		check-*)		error "$1: unknown tag '$tag'" 1 ;;
 		esac
 	done << EOT
 	$lines
-- 
2.15.0

