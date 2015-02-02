From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Sun, 1 Feb 2015 21:17:38 -0800
Message-ID: <CANeU7Qn9ORJ=uH6szkW2FpTT8hFhdNETjxndBYa8347Z1iON0Q@mail.gmail.com>
References: <54C15E0E.4000008@de.ibm.com>
	<CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
	<20150123222332.GB42179@macpro.local>
	<20150123223856.GB1489@cloud>
	<20150123235934.GA42931@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:38786 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbbBBFRj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2015 00:17:39 -0500
Received: by mail-qa0-f45.google.com with SMTP id n8so27689791qaq.4
        for <linux-sparse@vger.kernel.org>; Sun, 01 Feb 2015 21:17:38 -0800 (PST)
In-Reply-To: <20150123235934.GA42931@macpro.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Josh Triplett <josh@joshtriplett.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Sam Ravnborg <sam@ravnborg.org>

On Fri, Jan 23, 2015 at 3:59 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Thanks for bringing to my attention.
>
> Here is a new version of the patch taking care of that.
>

I like Sam's commit message better. So I merge a version using his
commit message.

The branch for review is here:
https://git.kernel.org/cgit/devel/sparse/chrisl/sparse.git/log/?h=review-counter

If there is no objects, I will merge it to master.

Chris
