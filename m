From: Phil Carmody <phil@dovecot.fi>
Subject: [PATCHv2 3/3] validation: dubious bitwise operations with bitwise nots
Date: Tue, 10 Jun 2014 10:54:07 +0300
Message-ID: <1402386847-23477-4-git-send-email-phil@dovecot.fi>
References: <1402315082-14102-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-1-git-send-email-phil@dovecot.fi>
 <1402386847-23477-2-git-send-email-phil@dovecot.fi>
 <1402386847-23477-3-git-send-email-phil@dovecot.fi>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wursti.dovecot.fi ([87.106.245.223]:39525 "EHLO
	wursti.dovecot.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934317AbaFJHyA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 10 Jun 2014 03:54:00 -0400
In-Reply-To: <1402386847-23477-3-git-send-email-phil@dovecot.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: josh@joshtriplett.org, linux-sparse@vger.kernel.org, phil@dovecot.fi

Add some bitwise not tests.

v2: add the double-twiddle case, and made less cryptic.

Signed-off-by: Phil Carmody <phil@dovecot.fi>
---
 validation/dubious-bitwise-with-not.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/validation/dubious-bitwise-with-not.c b/validation/dubious-bitwise-with-not.c
index c48bcae..5e232b8 100644
--- a/validation/dubious-bitwise-with-not.c
+++ b/validation/dubious-bitwise-with-not.c
@@ -10,8 +10,34 @@ static unsigned int ok5  = !1 && !2;
 static unsigned int bad5 = !1 &  !2;
 static unsigned int ok6  = !1 || !2;
 static unsigned int bad6 = !1 |  !2;
+static unsigned long long ok7a  = 0x100000001ull & ~1;
+static unsigned long long ok7b  = 0x100000001ull & ~1ull;
+static unsigned long long bad7  = 0x100000001ull & ~1u;
+static unsigned long long ok8a  = ~1    & 0x100000001ull;
+static unsigned long long ok8b  = ~1ull & 0x100000001ull;
+static unsigned long long bad8  = ~1u   & 0x100000001ull;
+static unsigned long long ok9a  = 0x100000001ull | ~1;
+static unsigned long long ok9b  = 0x100000001ull | ~1ull;
+static unsigned long long bad9  = 0x100000001ull | ~1u;
+static unsigned long long ok10a = ~1    | 0x100000001ull;
+static unsigned long long ok10b = ~1ull | 0x100000001ull;
+static unsigned long long bad10 = ~1u   | 0x100000001ull;
+static unsigned long long ok11a = 0x100000001ull + ~1;
+static unsigned long long ok11b = 0x100000001ull + ~1ull;
+static unsigned long long bad11 = 0x100000001ull + ~1u;
+static unsigned long long ok12a = ~1    + 0x100000001ull;
+static unsigned long long ok12b = ~1ull + 0x100000001ull;
+static unsigned long long bad12 = ~1u   + 0x100000001ull;
+static unsigned long long ok13a = 0x100000001ull - ~1;
+static unsigned long long ok13b = 0x100000001ull - ~1ull;
+static unsigned long long bad13 = 0x100000001ull - ~1u;
+static unsigned long long ok14a = ~1    - 0x100000001ull;
+static unsigned long long ok14b = ~1ull - 0x100000001ull;
+static unsigned long long bad14 = ~1u   - 0x100000001ull;
+static unsigned long long bad15 = ~0x100000001ull ^ ~1u;
+static unsigned long long bad16 = ~1u   ^ ~0x100000001ull;
 /*
- * check-name: Dubious bitwise operation on !x
+ * check-name: Dubious bitwise operations with !x or ~x
  *
  * check-error-start
 dubious-bitwise-with-not.c:2:31: warning: dubious: !x & y
@@ -20,5 +46,15 @@ dubious-bitwise-with-not.c:6:31: warning: dubious: x & !y
 dubious-bitwise-with-not.c:8:31: warning: dubious: x | !y
 dubious-bitwise-with-not.c:10:31: warning: dubious: !x & !y
 dubious-bitwise-with-not.c:12:31: warning: dubious: !x | !y
+dubious-bitwise-with-not.c:15:50: warning: dubious zero-extended '~': x & ~y
+dubious-bitwise-with-not.c:18:41: warning: dubious zero-extended '~': ~x & y
+dubious-bitwise-with-not.c:21:50: warning: dubious zero-extended '~': x | ~y
+dubious-bitwise-with-not.c:24:41: warning: dubious zero-extended '~': ~x | y
+dubious-bitwise-with-not.c:27:50: warning: dubious zero-extended '~': x + ~y
+dubious-bitwise-with-not.c:30:41: warning: dubious zero-extended '~': ~x + y
+dubious-bitwise-with-not.c:33:50: warning: dubious zero-extended '~': x - ~y
+dubious-bitwise-with-not.c:36:41: warning: dubious zero-extended '~': ~x - y
+dubious-bitwise-with-not.c:37:51: warning: dubious zero-extended '~': x ^ ~y
+dubious-bitwise-with-not.c:38:41: warning: dubious zero-extended '~': ~x ^ y
  * check-error-end
  */
-- 
2.0.0

