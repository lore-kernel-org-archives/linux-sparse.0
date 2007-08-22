From: Yura Pakhuchiy <pakhuchiy@gmail.com>
Subject: [PATCH] Make cgcc filter out all sparse warning related options
Date: Wed, 22 Aug 2007 12:48:47 +0300
Message-ID: <1187776127.7605.14.camel@chaos.malinovka7.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from iptel.by ([80.94.225.5]:43896 "EHLO iptel.by"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752691AbXHVKz5 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 Aug 2007 06:55:57 -0400
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

Make cgcc filter out all sparse warning related options.

Signed-off-by: Yura Pakhuchiy <pakhuchiy@gmail.com>

diff --git a/cgcc b/cgcc
index 2b9f89c..51fbd86 100755
--- a/cgcc
+++ b/cgcc
@@ -69,7 +69,7 @@ exit 0;
 
 sub check_only_option {
     my ($arg) = @_;
-    return 1 if $arg =~ /^-W(no-?)?(default-bitfield-sig|one-bit-signed-bitfield|cast-truncate|bitwise|typesign|context|undefined-preprocessor|ptr-subtraction-blows|cast-to-address-space|decl|transparent-union|address-space|enum-mismatch|do-while|old-initializer|non-pointer-null)$/;
+    return 1 if $arg =~ /^-W(no-?)?(default-bitfield-sign|one-bit-signed-bitfield|cast-truncate|bitwise|typesign|context|undefined-preprocessor|ptr-subtraction-blows|cast-to-address-space|decl|transparent-union|address-space|enum-mismatch|do-while|old-initializer|non-pointer-null|paren-string|return-void)$/;
     return 1 if $arg =~ /^-v(no-?)?(entry|dead)$/;
     return 0;
 }


-- 
Best regards,
        Yura
