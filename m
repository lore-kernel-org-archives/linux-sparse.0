From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Tue, 23 Dec 2008 08:29:53 +0300
Message-ID: <f19298770812222129n556390ebwb1f2253dfc5f3086@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <20081218223216.23692.711.stgit@zaytsev.su>
	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.154]:21618 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbYLWF3z (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 00:29:55 -0500
Received: by fg-out-1718.google.com with SMTP id 19so904994fgg.17
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 21:29:53 -0800 (PST)
In-Reply-To: <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

On Tue, Dec 23, 2008 at 07:37, Alexey Zaytsev <alexey.zaytsev@gmail.com> wrote:
> On Tue, Dec 23, 2008 at 06:51, Christopher Li <sparse@chrisli.org> wrote:
> In the Linux kernel, we've got lots of void * address arithmetics:
> linux/linux-2.6$ make -j 8 CC='gcc -Wpointer-arith' 2>&1 | grep
> 'warning: pointer of type \'void \*\' used in arithmetic' | uniq | wc
> -l
> 45095
I screwed up, it should be | sort -u | uniq | wc -l
But it's still 14488.
