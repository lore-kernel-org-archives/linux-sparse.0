From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: fix bogus shift too big warning when rhs is a variable
Date: Sat, 28 Jun 2014 10:37:31 -0700
Message-ID: <CANeU7QnCN=DnGTMnoAioEvC6gz9zq6Ur2iL+UTB+Q6AWCpXOQg@mail.gmail.com>
References: <20140616171006.GA20387@ravnborg.org>
	<CANeU7QkLdQuZbDA7jLd=6UrFJgevBO_y0B9n9va7_GTGfR+C0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:49736 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752046AbaF1Rhc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jun 2014 13:37:32 -0400
Received: by mail-qg0-f53.google.com with SMTP id i50so611502qgf.40
        for <linux-sparse@vger.kernel.org>; Sat, 28 Jun 2014 10:37:31 -0700 (PDT)
In-Reply-To: <CANeU7QkLdQuZbDA7jLd=6UrFJgevBO_y0B9n9va7_GTGfR+C0A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparse <linux-sparse@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Josh Triplett <josh@joshtriplett.org>

On Sat, Jun 28, 2014 at 10:32 AM, Christopher Li <sparse@chrisli.org> wrote:

>
> That is right before your change. Plus I can't duplicate the bug myself.
>
> I suspect there is something else going on. Any way to help me reproduce
> the bug?

Never mind, I just saw the other email thread discussing this bug.
I will try the test case provide there.

Chris
