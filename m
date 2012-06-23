From: Daniel Santos <daniel.santos@pobox.com>
Subject: [PATCH v4 13/13] documentation for rbtrees
Date: Fri, 22 Jun 2012 23:00:48 -0500
Message-ID: <1340424048-7759-14-git-send-email-daniel.santos@pobox.com>
References: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340424048-7759-1-git-send-email-daniel.santos@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Christopher Li <sparse@chrisli.org>, Daniel Santos <daniel.santos@pobox.com>, David Daney <david.daney@cavium.com>, David Howells <dhowells@redhat.com>, David Rientjes <rientjes@google.com>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>, Joe Perches <joe@perches.com>, Konstantin Khlebnikov <khlebnikov@openvz.org>, linux-doc@vger.kernel.org, linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Paul Turner <pjt@google.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Richard Weinberger <richard@nod.at>, Rob Landley <rob@landley.net>, Steven Rostedt <rostedt@goodmis.org>, Suresh Siddha <suresh.b.siddha@intel.com>
List-Id: linux-sparse@vger.kernel.org

Signed-off-by: Daniel Santos <daniel.santos@pobox.com>
---
 Documentation/DocBook/kernel-api.tmpl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/DocBook/kernel-api.tmpl b/Documentation/DocBook/kernel-api.tmpl
index 00687ee..210e9aa 100644
--- a/Documentation/DocBook/kernel-api.tmpl
+++ b/Documentation/DocBook/kernel-api.tmpl
@@ -43,6 +43,10 @@
      <sect1><title>Doubly Linked Lists</title>
 !Iinclude/linux/list.h
      </sect1>
+     <sect1><title>Red-Black Trees</title>
+!Iinclude/linux/rbtree.h
+!Ilib/rbtree.c
+     </sect1>
   </chapter>
 
   <chapter id="libc">
-- 
1.7.3.4
