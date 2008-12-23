From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Tue, 23 Dec 2008 09:09:36 +0300
Message-ID: <f19298770812222209w7ce56ba5q48ecc92554443879@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <20081218223216.23692.711.stgit@zaytsev.su>
	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
	 <70318cbf0812222151x11be46a4yde0327a0e62bb0ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:24140 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbYLWGJh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 01:09:37 -0500
Received: by fg-out-1718.google.com with SMTP id 19so907586fgg.17
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 22:09:36 -0800 (PST)
In-Reply-To: <70318cbf0812222151x11be46a4yde0327a0e62bb0ba@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

On Tue, Dec 23, 2008 at 08:51, Christopher Li <sparse@chrisli.org> wrote:
>> But how about void *? If void *p = x, what p+1 should be? Gcc defines
>> sizeof(void) being 1, and people seem to know and use this.
>> http://gcc.gnu.org/onlinedocs/gcc-4.3.2/gcc/Warning-Options.html#index-Wno_002dpointer_002darith-347
>
> Using pointer arithmetic on void* is not as crazy as using
> sizeof(void) directly. Most people using void* arithmetic is
> thinking it as char *. You should able to add a one line change
> in evaluate_ptr_add() to allow void* pointer arithmetic.
>
> Still better than hard code sizeof(void) as 1.

I don't really see the problem. It's not like you can pass
void i; or void *p; *p = 5; or store something into void anyway.
And in gcc void *p; sizeof(*p) == 1, so void realy looks like
being sizeof 1.
