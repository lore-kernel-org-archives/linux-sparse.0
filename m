From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH] sparse: Add cmd line --version option
Date: Wed, 6 Mar 2013 21:10:45 -0800
Message-ID: <CANeU7QksQ5rnxNF1p5=MxHkWtPCOykeLWewy6m-gkNpOg_obGg@mail.gmail.com>
References: <1362590578.1759.48.camel@joe-AO722>
	<20130306214550.GA8486@jtriplet-mobl1>
	<1362607043.2093.19.camel@joe-AO722>
	<CANeU7Q=vsxomdNSjy+84eTAnRq1OVXynpfkKqfkFGkYhF-FEmw@mail.gmail.com>
	<1362630786.5290.7.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:57989 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab3CGFKq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Mar 2013 00:10:46 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so51849obc.40
        for <linux-sparse@vger.kernel.org>; Wed, 06 Mar 2013 21:10:46 -0800 (PST)
In-Reply-To: <1362630786.5290.7.camel@joe-AO722>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Wed, Mar 6, 2013 at 8:33 PM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2013-03-06 at 20:18 -0800, Chris Li wrote:

> It's your patch now, I was just maybe an instigator.
> Looks good though.

Thanks. I start from your patch. I will just keep you
as the author for patch.

> Reviewed-by: Joe Perches <joe@perches.com>
>
> Maybe something like:
>
> git describe | cut -f1 -d"-"

You mean the first VERSION in the Makefile?
I want it to be there because sparse also release as
tar.gz package without the git tree. It is useful to keep a
version string outside of the git repository.

Chris
