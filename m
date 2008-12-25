From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: [PATCH] Also warn about sizeof(function)
Date: Thu, 25 Dec 2008 23:10:58 +0300
Message-ID: <20081225200613.15414.96407.stgit@zaytsev.su>
References: <70318cbf0812251145k1fa1e3bbh58b33a1aadf277cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:54325 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751994AbYLYUBk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 25 Dec 2008 15:01:40 -0500
Received: by ug-out-1314.google.com with SMTP id 39so905604ugf.37
        for <linux-sparse@vger.kernel.org>; Thu, 25 Dec 2008 12:01:38 -0800 (PST)
In-Reply-To: <70318cbf0812251145k1fa1e3bbh58b33a1aadf277cc@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Tommy Thorn <tommy@numba-tu.com>

Signed-off-by: Alexey Zaytsev <alexey.zaytsev@gmail.com>
---

> Hi Alexey,
> 
> On Thu, Dec 25, 2008 at 10:36 AM, Alexey Zaytsev
> <alexey.zaytsev@gmail.com> wrote:
>> I added (hopefully the right way) handling of (sizeof(function)) to the
>> patch. function++ was already prohibited.
> 
> Can you send me an incremental patch for the sizeof(function) change?
Sure. Btw, your patches come demaged lately. Could you please use
git-send-email to send them in the future?

> BTW, is it one of the gcc special treatment as well?

It was just mentioned in the same option's description:
http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/gcc/pointer-arith.html

 evaluate.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index e23c4eb..1424ce1 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -2049,6 +2049,12 @@ static struct symbol *evaluate_sizeof(struct expression *expr)
 		warning(expr->pos, "expression using sizeof(void)");
 		size = bits_in_char;
 	}
+
+	if (is_function(type->ctype.base_type)) {
+		warning(expr->pos, "expression using sizeof on a function");
+		size = bits_in_char;
+	}
+
 	if ((size < 0) || (size & (bits_in_char - 1)))
 		expression_error(expr, "cannot size expression");
 

