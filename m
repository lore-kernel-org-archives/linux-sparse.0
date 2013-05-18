From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 3/3] symbol.c: Set correct size of array from parenthesized
 string initializer
Date: Sat, 18 May 2013 00:38:03 -0700
Message-ID: <51972FDB.6060201@chrisli.org>
References: <5195370B.9080702@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:52450 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab3ERHiR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 May 2013 03:38:17 -0400
Received: by mail-da0-f53.google.com with SMTP id t11so2805283daj.40
        for <linux-sparse@vger.kernel.org>; Sat, 18 May 2013 00:38:17 -0700 (PDT)
In-Reply-To: <5195370B.9080702@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On 05/16/2013 12:44 PM, Ramsay Jones wrote:

> diff --git a/validation/init-char-array1.c b/validation/init-char-array1.c
> new file mode 100644
> index 0000000..7427702
> --- /dev/null
> +++ b/validation/init-char-array1.c
> @@ -0,0 +1,25 @@
> +/*
> + * for array of char, ("...") as the initializer is an gcc language
> + * extension. check that a parenthesized string initializer is handled
> + * correctly and that -Wparen-string warns about it's use.
> + */
> +static const char u[] = ("hello");
> +static const char v[] = {"hello"};
> +static const char w[] = "hello";
> +static const char x[5] = "hello";

That seems not complete. I haven't found the official gcc rules
about parenthesized string. I just try the following forms and
gcc takes it.

char x1[] = { ("hello") };
char x2[] = { (("hello")) };

I guess the rules is that parenthesized string can appear in
any place where string was allowed.

Chris
