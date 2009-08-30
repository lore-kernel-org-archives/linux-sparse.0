From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: sparse segv with simple test
Date: Mon, 31 Aug 2009 00:53:58 +0200
Message-ID: <200908310053.59138.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22261 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754093AbZH3W5r (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Aug 2009 18:57:47 -0400
In-Reply-To: <20090830153202.4dc5c58c@s6510>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Stephen Hemminger <shemminger@vyatta.com>
Cc: Josh Triplett <josh@kernel.org>, linux-sparse@vger.kernel.org

On Monday 31 of August 2009 00:32:02 Stephen Hemminger wrote:
> I was checking up on some enum issues and tried running the following:
> 	sparse -Wenum-mismatch enum.c
> It dies here:
> gdb) run -Wenum-mismatch e.c
> Starting program: /home/shemminger/src/sparse/sparse -Wenum-mismatch enum.c
>
> Program received signal SIGSEGV, Segmentation fault.
> 0x0805c81d in linearize_store_gen (ep=0xb7e7600c, value=0xb7e4e00c,
>     ad=0xbfd43134) at linearize.h:293
> 293		return (p && p->type != PSEUDO_VOID && p->type != PSEUDO_VAL);
> (gdb) where
> #0  0x0805c81d in linearize_store_gen (ep=0xb7e7600c, value=0xb7e4e00c,
>     ad=0xbfd43134) at linearize.h:293
> #1  0x080609da in linearize_symbol (sym=0xb7e244cc) at linearize.c:1526
> #2  0x080494bd in main (argc=-1209907772, argv=0xb7e245c4) at sparse.c:266
> ------
> #include <stdio.h>
>
> enum x { A, B, C };
>
> static enum x foo(int n) {
> 	return (n > 0) ? A : B;
> }
>
> int main(int ac, char **av) {
> 	int x = foo(ac);
> 	enum x y = 99;
>
> 	printf("%d %d\n", x, y);
> 	return 0;
> }

I am unable to reproduce the crash, tested with sparse 0.4.1 and current git 
HEAD. Even no suspicious place reported by valgrind. Maybe your <stdio.h> is 
the trigger. Could you please attach the preprocessed code?

Kamil
