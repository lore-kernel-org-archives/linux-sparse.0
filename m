From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: unable to open limits.h
Date: Tue, 25 Nov 2008 15:18:58 +0300
Message-ID: <f19298770811250418p154bad86qf926c464d16aef02@mail.gmail.com>
References: <20081125110703.GA23049@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:19793 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYKYMTA (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 25 Nov 2008 07:19:00 -0500
Received: by wf-out-1314.google.com with SMTP id 27so2751531wfd.4
        for <linux-sparse@vger.kernel.org>; Tue, 25 Nov 2008 04:18:59 -0800 (PST)
In-Reply-To: <20081125110703.GA23049@infradead.org>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-sparse@vger.kernel.org, Josh Triplett <josh@kernel.org>

On Tue, Nov 25, 2008 at 14:07, Christoph Hellwig <hch@infradead.org> wrote:
> On Ubuntu 8.10 (glibc 2.8.90) I get the following warnings when
> compiling any program using limits.h:
>
> /usr/include/limits.h:125:17: error: unable to open 'limits.h'

This is probably fixed by
http://git.zaytsev.su/git?p=sparse.git;a=commitdiff;h=6f089b22a222dd086d14c985c5a67f8b3afd2177

Josh, please pull the gsoc2008-up branch from git://zaytsev.su/git/sparse.git
