From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC 2/4] include/linux/compiler.h: allow memory operands
Date: Wed, 2 Jan 2019 15:57:54 -0500
Message-ID: <20190102205715.14054-3-mst@redhat.com>
References: <20190102205715.14054-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190102205715.14054-1-mst@redhat.com>
Sender: netdev-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <andrea.parri@amarulasolutions.com>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

We don't really care whether the variable is in-register
or in-memory. Relax the constraint accordingly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 1ad367b4cd8d..6601d39e8c48 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -154,7 +154,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #ifndef OPTIMIZER_HIDE_VAR
 /* Make the optimizer believe the variable can be manipulated arbitrarily. */
 #define OPTIMIZER_HIDE_VAR(var)						\
-	__asm__ ("" : "=r" (var) : "0" (var))
+	__asm__ ("" : "=rm" (var) : "0" (var))
 #endif
 
 /* Not-quite-unique ID. */
-- 
MST
