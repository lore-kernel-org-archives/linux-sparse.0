From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: Make -Werror turn warnigns into errors
Date: Thu, 25 Sep 2014 07:16:10 +0800
Message-ID: <CANeU7QmMGAc9Y+VMhQbf9JyUBZAL5x=JGQKvMO=988S60wOwUg@mail.gmail.com>
References: <ddf8540942f71841dd90c5218da944cebef4a514.1409770383.git.tgraf@suug.ch>
	<CANeU7QnRFxZ+OV5G2W3tC+tBnYNNcQsH_YEB=cyHmAfmfYc1PQ@mail.gmail.com>
	<20140924154207.GD4966@casper.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38203 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820AbaIXXQL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 19:16:11 -0400
Received: by mail-wi0-f178.google.com with SMTP id z2so8293582wiv.11
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 16:16:10 -0700 (PDT)
In-Reply-To: <20140924154207.GD4966@casper.infradead.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Thomas Graf <tgraf@suug.ch>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Sep 24, 2014 at 11:42 PM, Thomas Graf <tgraf@suug.ch> wrote:
>
> The return value of thest will only be non zero if an actual error
> has been detected. It will remain zero if only warnings have been
> found. So we would need to parse the text between "check-exit-start"
> and "check-error-end" for the string "error:" or something a like
> that. I found that to be fragile and the explicit declaration of an
> expected failure to be superior as it also verifies whether an
> expected warning is properly treated as a warning or not.
>

It does not conflict with what I said. My point is setting the *default*
value of the test case. You can still set the expected return value
explicitly using ""check-exit-value". There is nothing imprecise about it.

It is just need a regular expression. In python that will be:
r"(?m)^\S+?:\d+:\d+: error:".
The test case is written in Perl, it will need some conversion in regular
expression pattern.

Otherwise, this change is very invasive in the sense that, patches
apply after your patch will need to update the test case return value.
Maybe I need to wait until I apply all other patches before yours?

You are still testing the return value, just the *default* is inferred from
error output. Which is pretty obvious.

Thanks

Chris
