From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] sparse: fix bogus shift too big warning when rhs is a variable
Date: Sat, 28 Jun 2014 11:13:51 -0700
Message-ID: <CANeU7QnZA2RSZbq9b-azyFK3Pkw3uyR=YP98590sPqq4z+pjTQ@mail.gmail.com>
References: <20140616171006.GA20387@ravnborg.org>
	<CANeU7QkLdQuZbDA7jLd=6UrFJgevBO_y0B9n9va7_GTGfR+C0A@mail.gmail.com>
	<CANeU7QnCN=DnGTMnoAioEvC6gz9zq6Ur2iL+UTB+Q6AWCpXOQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:63481 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755412AbaF1SNw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 28 Jun 2014 14:13:52 -0400
Received: by mail-qc0-f178.google.com with SMTP id c9so5584118qcz.23
        for <linux-sparse@vger.kernel.org>; Sat, 28 Jun 2014 11:13:51 -0700 (PDT)
In-Reply-To: <CANeU7QnCN=DnGTMnoAioEvC6gz9zq6Ur2iL+UTB+Q6AWCpXOQg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sparse <linux-sparse@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>, Josh Triplett <josh@joshtriplett.org>

On Sat, Jun 28, 2014 at 10:37 AM, Christopher Li <sparse@chrisli.org> wrote:
>
> Never mind, I just saw the other email thread discussing this bug.
> I will try the test case provide there.
>


Ok, I just reply to the other email.
The bug is in the kernel source, a valid complain.
Sparse is doing the right thing here. Not a sparse bug, it is feature.

Chris
