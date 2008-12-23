From: "Christopher Li" <sparse@chrisli.org>
Subject: Re: [PATCH 7/16] Let void have sizeof 1
Date: Mon, 22 Dec 2008 21:51:58 -0800
Message-ID: <70318cbf0812222151x11be46a4yde0327a0e62bb0ba@mail.gmail.com>
References: <20081218181935.28136.60256.stgit@zaytsev.su>
	 <20081218223216.23692.711.stgit@zaytsev.su>
	 <70318cbf0812221951m4f9ee42bqac419b1f0b800bfa@mail.gmail.com>
	 <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:60310 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbYLWFv7 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 23 Dec 2008 00:51:59 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2237813rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 22 Dec 2008 21:51:59 -0800 (PST)
In-Reply-To: <f19298770812222037l6dbe5b35t4803138e20bab04d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Cc: Josh Triplett <josh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, linux-sparse@vger.kernel.org

> But how about void *? If void *p = x, what p+1 should be? Gcc defines
> sizeof(void) being 1, and people seem to know and use this.
> http://gcc.gnu.org/onlinedocs/gcc-4.3.2/gcc/Warning-Options.html#index-Wno_002dpointer_002darith-347

Using pointer arithmetic on void* is not as crazy as using
sizeof(void) directly. Most people using void* arithmetic is
thinking it as char *. You should able to add a one line change
in evaluate_ptr_add() to allow void* pointer arithmetic.

Still better than hard code sizeof(void) as 1.

Chris
