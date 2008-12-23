From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: Casting away noderef and address spaces?
Date: Tue, 23 Dec 2008 03:20:29 +0300
Message-ID: <f19298770812221620s7ef34b9co55f1650220750b38@mail.gmail.com>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
	 <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
	 <20081222213953.GN28946@ZenIV.linux.org.uk>
	 <70318cbf0812221433y62197ec7y851f00fa5775f150@mail.gmail.com>
	 <20081222225708.GA4074@uranus.ravnborg.org>
	 <f19298770812221553n5281505ex611e8e6f6fa1f0c2@mail.gmail.com>
	 <1229990125.11628.0.camel@johannes>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:56047 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbYLWAUc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 19:20:32 -0500
Received: by bwz14 with SMTP id 14so8994351bwz.13
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 16:20:30 -0800 (PST)
In-Reply-To: <1229990125.11628.0.camel@johannes>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Tue, Dec 23, 2008 at 02:55, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Tue, 2008-12-23 at 02:53 +0300, Alexey Zaytsev wrote:
>
>> The last time we spoke (yesterday) Josh was going to merge the patches really
>> soon. The idea was to merge everything except the context patches, make a
>> release, add the context patches, and wait for someone to fix them.
>
> Make sure to revert those that are in the tree now though, before the
> release.
>

By the way, are you sure the latest series you have sent is correct? To me it
seems that it does not make any warnings go away, and adds quite some more:
http://zaytsev.su/tmp/build.diff.txt
