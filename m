From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH 1/1] jffs2: fix sparse warning: unexpected unlock
Date: Mon, 22 Sep 2014 11:12:50 -0700
Message-ID: <20140922181250.GN1193@ld-irv-0074>
References: <1411065976-20386-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:49142 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbaIVSMy (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Sep 2014 14:12:54 -0400
Content-Disposition: inline
In-Reply-To: <1411065976-20386-1-git-send-email-fabf@skynet.be>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, linux-sparse@vger.kernel.org

+ linux-sparse

On Thu, Sep 18, 2014 at 08:46:16PM +0200, Fabian Frederick wrote:
> fs/jffs2/summary.c:846:5: warning: context imbalance in 'jffs2_sum_write_sumnode' - unexpected unlock
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  fs/jffs2/summary.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jffs2/summary.c b/fs/jffs2/summary.c
> index c522d09..a0bac7b 100644
> --- a/fs/jffs2/summary.c
> +++ b/fs/jffs2/summary.c
> @@ -844,6 +844,8 @@ static int jffs2_sum_write_data(struct jffs2_sb_info *c, struct jffs2_eraseblock
>  /* Write out summary information - called from jffs2_do_reserve_space */
>  
>  int jffs2_sum_write_sumnode(struct jffs2_sb_info *c)
> +	__releases(&c->erase_completion_lock)
> +	__acquires(&c->erase_completion_lock)

I'm not too familiar with sparse notations, but Documentation/sparse.txt
suggests the above is wrong, and the following is more accurate:

	__must_hold(&c->erase_completion_lock)

But it looks like there are several other examples which do this.
Anyway, here's the relevant doc text, in case someone wants to clarify
it for me, or else tell me the documentation is wrong:

    __must_hold - The specified lock is held on function entry and exit.

    __acquires - The specified lock is held on function exit, but not entry.

    __releases - The specified lock is held on function entry, but not exit.

So __acquires and __releases look mutually exclusive, but it's not clear
if __must_hold will actually cover what we want. (I haven't tested it.)

>  {
>  	int datasize, infosize, padsize;
>  	struct jffs2_eraseblock *jeb;

Brian
