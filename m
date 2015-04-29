From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse/parse.c: ignore hotpatch attribute
Date: Wed, 29 Apr 2015 16:22:13 -0700
Message-ID: <CANeU7QkyX+cPEpBm_rW1JUX64NAZ6YM0KR17r1rfPeDpYC1uGA@mail.gmail.com>
References: <1430218119-58354-1-git-send-email-heiko.carstens@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yh0-f45.google.com ([209.85.213.45]:36627 "EHLO
	mail-yh0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbD2XWO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 29 Apr 2015 19:22:14 -0400
Received: by yhrr66 with SMTP id r66so9254063yhr.3
        for <linux-sparse@vger.kernel.org>; Wed, 29 Apr 2015 16:22:13 -0700 (PDT)
In-Reply-To: <1430218119-58354-1-git-send-email-heiko.carstens@de.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

That patch looks fine.

Can you add some test case for the hot patch as well?
It need to cover the case you run into.

Preferably cover each of the variation of hot patch.

It will be useful when we parse these attributes properly.

Chris


On Tue, Apr 28, 2015 at 3:48 AM, Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
> gcc knows about a new "hotpatch" attribute which sparse can safely ignore,
> since it modifies only which code will be generated just like the
> "no_instrument_function" attribute.
>
> The gcc hotpatch feature patch:
> https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=11762b8363737591bfb9c66093bc2edf289b917f
>
> Currently the Linux kernel makes use of this attribute:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=61f552141c9c0e88b3fdc7046265781ffd8fa68a
>
> Without this patch sparse will emit warnings like
> "error: attribute 'hotpatch': unknown attribute"
>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  parse.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/parse.c b/parse.c
> index b43d6835528b..8afae73d5325 100644
> --- a/parse.c
> +++ b/parse.c
> @@ -540,6 +540,8 @@ const char *ignored_attributes[] = {
>         "__gnu_inline__",
>         "hot",
>         "__hot__",
> +       "hotpatch",
> +       "__hotpatch__",
>          "leaf",
>          "__leaf__",
>         "l1_text",
> --
> 2.1.4
>
