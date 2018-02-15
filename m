From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] disable sparse warnings about unknown attributes
Date: Thu, 15 Feb 2018 22:07:50 +0100
Message-ID: <20180215210750.28813-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Randy Dunlap <rdunlap@infradead.org>, linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-sparse@vger.kernel.org

Currently, sparse issues warnings on code using an attribute
it doesn't know about.

One of the problem with this is that these warnings have no
value for the developer, it's just noise for him. At best these
warnings tell something about some deficiencies of sparse itself
but not about a potential problem with code analyzed.

A second problem with this is that sparse release are, alas,
less frequent than new attributes are added to GCC.

So, avoid the noise by asking sparse to not warn about
attributes it doesn't know about.

Reference: https://marc.info/?l=linux-sparse&m=151871600016790
Reference: https://marc.info/?l=linux-sparse&m=151871725417322
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 79ad2bfa2..8d9a7374c 100644
--- a/Makefile
+++ b/Makefile
@@ -388,7 +388,7 @@ PYTHON		= python
 CHECK		= sparse
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
-		  -Wbitwise -Wno-return-void $(CF)
+		  -Wbitwise -Wno-return-void -Wno-unknown-attribute $(CF)
 NOSTDINC_FLAGS  =
 CFLAGS_MODULE   =
 AFLAGS_MODULE   =
-- 
2.16.0

