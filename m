From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: unable to open limits.h
Date: Tue, 25 Nov 2008 16:04:50 +0300
Message-ID: <f19298770811250504r28a45e2fv56c10687df69ea3d@mail.gmail.com>
References: <20081125110703.GA23049@infradead.org>
	 <f19298770811250418p154bad86qf926c464d16aef02@mail.gmail.com>
	 <20081125123622.GA20420@infradead.org>
	 <20081125123743.GA21584@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:55848 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbYKYNEw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Nov 2008 08:04:52 -0500
Received: by yw-out-2324.google.com with SMTP id 9so1056572ywe.1
        for <linux-sparse@vger.kernel.org>; Tue, 25 Nov 2008 05:04:51 -0800 (PST)
In-Reply-To: <20081125123743.GA21584@infradead.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Tue, Nov 25, 2008 at 15:37, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Nov 25, 2008 at 07:36:22AM -0500, Christoph Hellwig wrote:
>> On Tue, Nov 25, 2008 at 03:18:58PM +0300, Alexey Zaytsev wrote:
>> > On Tue, Nov 25, 2008 at 14:07, Christoph Hellwig <hch@infradead.org> wrote:
>> > > On Ubuntu 8.10 (glibc 2.8.90) I get the following warnings when
>> > > compiling any program using limits.h:
>> > >
>> > > /usr/include/limits.h:125:17: error: unable to open 'limits.h'
>> >
>> > This is probably fixed by
>> > http://git.zaytsev.su/git?p=sparse.git;a=commitdiff;h=6f089b22a222dd086d14c985c5a67f8b3afd2177
>> >
>> > Josh, please pull the gsoc2008-up branch from git://zaytsev.su/git/sparse.git
>>
>> I still see the error with a sparse built from your repository.
>
> Oh, looks like your have the change in some bloody branch.  Care to send
> a patch or publish a proper repository?
>
Yes, the commit is located in the gsoc2008-up branch, but you've probably
already found it by the time. ;)
