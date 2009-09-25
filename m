From: Christopher Li <sparse@chrisli.org>
Subject: Re: new sparse release?
Date: Fri, 25 Sep 2009 10:12:32 -0700
Message-ID: <70318cbf0909251012q6e21a7b6g96c68351c19c772a@mail.gmail.com>
References: <20090925083109.18353a08@tlielax.poochiereds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f203.google.com ([209.85.212.203]:37231 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbZIYRM3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 25 Sep 2009 13:12:29 -0400
Received: by vws41 with SMTP id 41so1772407vws.4
        for <linux-sparse@vger.kernel.org>; Fri, 25 Sep 2009 10:12:33 -0700 (PDT)
In-Reply-To: <20090925083109.18353a08@tlielax.poochiereds.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jeff Layton <jlayton@poochiereds.net>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Fri, Sep 25, 2009 at 5:31 AM, Jeff Layton <jlayton@poochiereds.net> wrote:
> The sparse package in Fedora is based on the latest release of sparse
> (0.4.1). That seems to be really old (from 2007) and is lacking
> important patches (like the one to ignore the __cold__ attribute).
>
> Would it be possible to cut a newer release sometime in the near future
> so that distros can pick up a new official version?
>

Sure, I mean to do that. Currently the sparse wiki is up. I have been
syncing bits from chrisl branch from time to time.

I just need to:
- Get a PGP key.
- Sign the new release tag.
- Run magic git command to generate stat of changes.
- Add change log.
- make dist.
- Upload the tar package.
- Announce the release to mailing list.

I will cut 0.4.2.0-rc1 one over the week end.

Thanks

Chris
