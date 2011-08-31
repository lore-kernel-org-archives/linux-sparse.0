From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/3] evaluate: warn on identical exprs around '&&'
Date: Tue, 30 Aug 2011 17:24:55 -0700
Message-ID: <CANeU7QkM+Umno8n5tpVBvrBit_RMphOqqkODKkoxM9SNUCRfUA@mail.gmail.com>
References: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52914 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab1HaAY5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 30 Aug 2011 20:24:57 -0400
Received: by wyg24 with SMTP id 24so120503wyg.19
        for <linux-sparse@vger.kernel.org>; Tue, 30 Aug 2011 17:24:55 -0700 (PDT)
In-Reply-To: <1314484015-7694-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Forbes <chrisf@ijw.co.nz>
Cc: linux-sparse@vger.kernel.org

On Sat, Aug 27, 2011 at 3:26 PM, Chris Forbes <chrisf@ijw.co.nz> wrote:
> Adds a warning when identical expressions are found on both sides of the '&&' operator. This is a common error resulting from copy & paste.
>
> Excludes identical expressions found while preprocessing, so we don't get upset about #if defined(FOO) && defined(BAR), which happens all the time, and is perfectly valid.

I create a branch for the identical expression check.

http://git.kernel.org/?p=devel/sparse/chrisl/sparse.git;a=shortlog;h=refs/heads/warn-equiv-expr

I did not plan to include it in this 0.4.4 release yet.
For now bug fix only.

I also want to see how it perform on project source code.
It is adding complexity and CPU run time to sparse, I like to see some
results.

> +static int ident_equal(struct ident *a, struct ident *b)
> +{
> +	/* only correct when used in the context of expr_equiv.
> +		should compare symbols? for general case? */
> +	return a->len == b->len &&
> +		!memcmp(a->name, b->name, a->len);
> +}

The ident_equal is overkill. The ident has been hashed and guarantee
unique.


You only need to compare pointer a == b. The whole point of
ident hashing is to reduce memcmp.

Chris
