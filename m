From: behanw@converseincode.com
Subject: [PATCH 3/5] kbuild: LLVMLinux: Fix LINUX_COMPILER definition script for compilation with clang
Date: Tue, 25 Feb 2014 17:08:41 -0800
Message-ID: <1393376923-21892-4-git-send-email-behanw@converseincode.com>
References: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1393376923-21892-1-git-send-email-behanw@converseincode.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: mmarek@suse.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, sparse@chrisli.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, torvalds@linux-foundation.org, dwmw2@infradead.org, pageexec@freemail.hu, =?UTF-8?q?Jan-Simon=20M=C3=B6ller?= <dl9pf@gmx.de>, Behan Webster <behanw@converseincode.com>, Mark Charlebois <charlebm@gmail.com>
List-Id: linux-sparse@vger.kernel.org

=46rom: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>

When building the LINUX_COMPILER definition, instead of merely taking t=
he last
line from "$(CC) -v", grep for ' version ' in the output. This supports=
 both
gcc and clang.

Signed-off-by: Jan-Simon M=C3=B6ller <dl9pf@gmx.de>
Signed-off-by: Behan Webster <behanw@converseincode.com>
Signed-off-by: Mark Charlebois <charlebm@gmail.com>
Cc: PaX Team <pageexec@freemail.hu>
---
 scripts/mkcompile_h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
index f221ddf..cfb8440 100755
--- a/scripts/mkcompile_h
+++ b/scripts/mkcompile_h
@@ -76,7 +76,7 @@ UTS_TRUNCATE=3D"cut -b -$UTS_LEN"
   echo \#define LINUX_COMPILE_BY \"`echo $LINUX_COMPILE_BY | $UTS_TRUN=
CATE`\"
   echo \#define LINUX_COMPILE_HOST \"`echo $LINUX_COMPILE_HOST | $UTS_=
TRUNCATE`\"
=20
-  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -n 1`\"
+  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | grep ' version '`\"
 ) > .tmpcompile
=20
 # Only replace the real compile.h if the new one is different,
--=20
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
