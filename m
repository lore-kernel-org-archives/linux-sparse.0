From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Update the information in README about using the library.
Date: Tue, 3 Dec 2013 16:12:01 -0800
Message-ID: <CANeU7Qmy4k=9tJJ+sGr3DXAcROvZBkmkXOtwLnamLWZbitYvog@mail.gmail.com>
References: <1386059165-3812-1-git-send-email-franzschrober@gmail.com>
	<CANeU7Qkh-bTrED7HeV-64Ngoi3ZhLZBo96v0mq-wMpCPJkHghA@mail.gmail.com>
	<20131203234517.GB15141@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:49642 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751206Ab3LDAMB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Dec 2013 19:12:01 -0500
Received: by mail-oa0-f43.google.com with SMTP id i7so15890856oag.16
        for <linux-sparse@vger.kernel.org>; Tue, 03 Dec 2013 16:12:01 -0800 (PST)
In-Reply-To: <20131203234517.GB15141@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Franz Schrober <franzschrober@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, James Westby <james@jameswestby.net>

On Tue, Dec 3, 2013 at 3:45 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Tue, Dec 03, 2013 at 03:17:37PM -0800, Christopher Li wrote:
>> That will make you as the author of this commit.
>
> The "From:" line at the top of the patch will make git set that person
> as the author rather than the sender of the mail.
>
>> I think not much people have pull from the sparse repository yet.
>
> Bad assumption; if you've already pushed the patch, I'd suggest just
> "git revert"ing the revert.
>

Thanks, that is just what I need. I will just do that then.

Chris
