From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: Signed divides vs shifts (Re: [Security] /dev/urandom uses
 uninit bytes, leaks user data)
Date: Mon, 17 Dec 2007 18:55:57 +0100
Message-ID: <20071217185557.0b501e23.dada1@cosmosbay.com>
References: <E1J3RD5-0006yU-00@gondolin.me.apana.org.au>
	<alpine.LFD.0.9999.0712170856050.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759345AbXLQR4S@vger.kernel.org>
In-Reply-To: <alpine.LFD.0.9999.0712170856050.21557@woody.linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, John Reiser <jreiser@BitWagon.com>, Andrew Morton <akpm@linux-foundation.org>, security@kernel.org, tytso@mit.edu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mpm@selenic.com, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, 17 Dec 2007 09:28:57 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sat, 15 Dec 2007, Herbert Xu wrote:
> > 
> > There ought to be a warning about this sort of thing.
> 
> We could add it to sparse. The appended (untested) patch seems to say 
> there's a lot of those signed divides-by-power-of-twos.
> 
> However, the problem with such warnings is that it encourages people to do 
> the simple fix that may be *wrong*. For example, you fixed it with patches 
> like
> 
> > -		int rsvd = r->limit ? 0 : random_read_wakeup_thresh/4;
> > +		int rsvd = r->limit ? 0 : random_read_wakeup_thresh / 4u;
> 
> which is really quite dangerous for several reasons:
> 
>  - it depends intimately on the type of the thing being divided (try it: 
>    it will do nothing at all if the thing you divide is larger than 
>    "unsigned int", since then the "4u" will be turned into a _signed_ 
>    larger type by the C type expansion).
> 

I was looking at lib/extable.c which does emit a signed divide on i386 but not on x86_64:

mid = (last - first) / 2 + first;

So I tried to compiled this on x86_64 :

long *mid(long *a, long *b)
{
	return ((a - b) / 2 + a);
}

It gave :
mid:
        movq    %rdi, %rdx
        subq    %rsi, %rdx
        sarq    $3, %rdx
        movq    %rdx, %rax
        shrq    $63, %rax
        addq    %rdx, %rax
        sarq    %rax
        leaq    (%rdi,%rax,8), %rax
        ret

while 

long *mid(long *a, long *b)
{
	return ((a - b) / 2u + a);
}

gave :
mid:
        movq    %rdi, %rdx
        subq    %rsi, %rdx
        sarq    $3, %rdx
        movq    %rdx, %rax
        shrq    $63, %rax
        addq    %rdx, %rax
        sarq    %rax
        leaq    (%rdi,%rax,8), %rax
        ret

and while :

long *mid(long *a, long *b)
{
	return (((unsigned long)(a - b)) / 2 + a);
}

gave :
mid:
        movq    %rdi, %rax
        subq    %rsi, %rax
        sarq    %rax
        andq    $-8, %rax
        addq    %rdi, %rax
        ret


But I found this cast ugly so I cooked this patch.

[PATCH] Avoid signed arithmetics in search_extable()

On i386 and gcc-4.2.{1|2}, search_extable() currently does integer divides (by 2 !!!), while
we can certainly use a right shift. This looks more a typical bsearch() implementation.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

diff --git a/lib/extable.c b/lib/extable.c
index 463f456..03a81bd 100644
--- a/lib/extable.c
+++ b/lib/extable.c
@@ -54,20 +54,20 @@ search_extable(const struct exception_table_entry *first,
 	       const struct exception_table_entry *last,
 	       unsigned long value)
 {
-	while (first <= last) {
-		const struct exception_table_entry *mid;
+	unsigned long mid, low = 0, high = (last - first);
 
-		mid = (last - first) / 2 + first;
+	while (low <= high) {
+		mid = (low + high) / 2;
 		/*
 		 * careful, the distance between entries can be
-		 * larger than 2GB:
+		 * larger than MAX_LONG:
 		 */
-		if (mid->insn < value)
-			first = mid + 1;
-		else if (mid->insn > value)
-			last = mid - 1;
+		if (first[mid].insn < value)
+			low = mid + 1;
+		else if (first[mid].insn > value)
+			high = mid - 1;
 		else
-			return mid;
+			return first + mid;
         }
         return NULL;
 }
