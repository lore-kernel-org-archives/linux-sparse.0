From: Greg Price <price@MIT.EDU>
Subject: [PATCH] Clarify error on directive in macro arguments (Re: [PATCH]
 jffs2: fix sparse errors: directive in argument list)
Date: Sun, 17 Nov 2013 21:07:46 -0500
Message-ID: <20131118020746.GX16018@ringworld.MIT.EDU>
References: <20131118013349.GM13318@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20131118013349.GM13318@ZenIV.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-sparse@vger.kernel.org, linux-mtd <linux-mtd@lists.infradead.org>, Joe Perches <joe@perches.com>, dwmw2 <dwmw2@infradead.org>, Erico Nunes <nunes.erico@gmail.com>
List-Id: linux-sparse@vger.kernel.org

[+linux-sparse and Chris]

On Mon, Nov 18, 2013 at 01:33:49AM +0000, Al Viro wrote:
> On Sun, Nov 17, 2013 at 02:45:05PM -0800, Joe Perches wrote:
> > Yes.  I think it's a defect in how sparse
> > treats string concatenation.
> > 
> > That style [... with printk ...] is pretty common in the kernel sources.
> 
> ... and it's perfectly fine, until somebody starts playing in nasal
> daemon country and do that in *macro* arguments.  And a nasal daemon
> country it is - it's an undefined behaviour.  See 6.10.3p11 in C99.
> And trying to define a semantics for that gets real ugly real fast.
> sparse matches gcc behaviour (I hope), but it warns about such abuses.
> It's a defect, all right - one being reported by sparse.

Perhaps the following tweak to the error message would make this
subtlety clearer?

Cheers,
Greg


From: Greg Price <price@mit.edu>
Date: Sun, 17 Nov 2013 17:57:41 -0800
Subject: [PATCH] Clarify error on directive in macro arguments

Preprocessor directives in the arguments of a real function
are innocuous and in some contexts common.  If a developer
doesn't realize that a "function" is implemented as a macro,
they may mistake this error for a false alarm.

See http://www.spinics.net/lists/kernel/msg1636974.html
and http://www.spinics.net/lists/kernel/msg1636976.html
for an example.

Easy enough to clarify that this is a macro, so do it.

Signed-off-by: Greg Price <price@mit.edu>
---
 pre-process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pre-process.c b/pre-process.c
index d521318..db58a97 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -204,7 +204,7 @@ static struct token *collect_arg(struct token *prev, int vararg, struct position
 		if (next->pos.newline && match_op(next, '#')) {
 			if (!next->pos.noexpand) {
 				sparse_error(next->pos,
-					     "directive in argument list");
+					     "directive in macro argument list");
 				preprocessor_line(stream, p);
 				__free_token(next);	/* Free the '#' token */
 				continue;
-- 
1.8.3.2

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
