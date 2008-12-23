From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Tue, 23 Dec 2008 07:37:34 +0300
Message-ID: <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <20081218223216.23692.711.stgit@zaytsev.su>
	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:44965 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754467AbYLWEhg (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 22 Dec 2008 23:37:36 -0500
Received: by bwz14 with SMTP id 14so9207777bwz.13
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 20:37:35 -0800 (PST)
In-Reply-To: <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

On Tue, Dec 23, 2008 at 06:51, Christopher Li <sparse@chrisli.org> wrote:
> Void type is an incomplete type. It should not have storage size.
But how about void *? If void *p = x, what p+1 should be? Gcc defines
sizeof(void) being 1, and people seem to know and use this.
http://gcc.gnu.org/onlinedocs/gcc-4.3.2/gcc/Warning-Options.html#index-Wno_002dpointer_002darith-347

In the Linux kernel, we've got lots of void * address arithmetics:
linux/linux-2.6$ make -j 8 CC='gcc -Wpointer-arith' 2>&1 | grep
'warning: pointer of type \'void \*\' used in arithmetic' | uniq | wc
-l
45095

So even if we can't agree if such use is legid or not, we definetely
have to support this in sparse. And there is no need to warn about
it, as gcc already can do this.
