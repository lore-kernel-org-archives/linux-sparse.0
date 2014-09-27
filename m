From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 04/10] compile-i386.c: don't mix calls to write(2) with stdio
Date: Sat, 27 Sep 2014 10:13:48 +0800
Message-ID: <CANeU7Qk7sDezqhW2mPNxLMHvJHxffgvSix_q5wjQ2DgJJaFmEQ@mail.gmail.com>
References: <53DFD2B7.7080801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:49465 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbaI0CNu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 26 Sep 2014 22:13:50 -0400
Received: by mail-wi0-f179.google.com with SMTP id d1so486233wiv.6
        for <linux-sparse@vger.kernel.org>; Fri, 26 Sep 2014 19:13:48 -0700 (PDT)
In-Reply-To: <53DFD2B7.7080801@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

Compile-i386 is pretty much not maintained any more.

On Tue, Aug 5, 2014 at 2:36 AM, Ramsay Jones <ramsay@ramsay1.demon.co.uk> wrote:
>
> -       write(STDOUT_FILENO, s, strlen(s));
> +       printf("%s", s);

This change fix nothing. "printf" can return how many bytes it is written.
In the case that "write" can fail, "printf" can fail as well. e.g. disk full.
This patch did not check the return value from printf either.

If we really care about return value of write, (we don't). We can do some thing
like:
if (write(...)< len)
    die("....");

That at least check the return value.

Chris
