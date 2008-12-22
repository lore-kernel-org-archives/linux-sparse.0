From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: Casting away noderef and address spaces?
Date: Tue, 23 Dec 2008 02:53:17 +0300
Message-ID: <f19298770812221553n5281505ex611e8e6f6fa1f0c2@mail.gmail.com>
References: <200812221606.13910.rusty@rustcorp.com.au>
	 <70318cbf0812221206o1b5e2aech2a36f723afc63ffa@mail.gmail.com>
	 <20081222205750.GK28946@ZenIV.linux.org.uk>
	 <70318cbf0812221323s53119420qcdb2ee0542185667@mail.gmail.com>
	 <20081222213953.GN28946@ZenIV.linux.org.uk>
	 <70318cbf0812221433y62197ec7y851f00fa5775f150@mail.gmail.com>
	 <20081222225708.GA4074@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:60905 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbYLVXxU (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 18:53:20 -0500
Received: by bwz14 with SMTP id 14so8969350bwz.13
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 15:53:18 -0800 (PST)
In-Reply-To: <20081222225708.GA4074@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Christopher Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>, Rusty Russell <rusty@rustcorp.com.au>, linux-sparse@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>, Josh Triplett <josh@kernel.org>

On Tue, Dec 23, 2008 at 01:57, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> BTW, I am normally lazy enough that I am happy about just submitting
>> patches. On the other hand, I am tried of these sparse patches floating
>> around the mailing list. I can start a branch to merge the proper patches.
>> Maybe some thing like a development branch for sparse.
>> Is that some thing other people want?
>
> Please do so. We need some progress on sparse and current maintainer
> seems to be occupied by other things at the moment.
>
>        Sam

Hello.

How about?
http://git.zaytsev.su/git?p=sparse.git;a=shortlog;h=discuss

This branch holds the two patch collections* I recently sent to the
mailing list. I
think it includes every useful patch that does not break the kernel check, and
even some that do. ;)
The last time we spoke (yesterday) Josh was going to merge the patches really
soon. The idea was to merge everything except the context patches, make a
release, add the context patches, and wait for someone to fix them.
