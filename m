From: Christopher Li <sparse@chrisli.org>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Mon, 23 Mar 2009 02:22:47 -0700
Message-ID: <70318cbf0903230222q3546233cn39071f19ab956f2c@mail.gmail.com>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com>
	 <20090319144622.GA28946@ZenIV.linux.org.uk>
	 <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com>
	 <20090319191431.GD28946@ZenIV.linux.org.uk>
	 <70318cbf0903191304k1fefe9afkb4be21550d8f9abe@mail.gmail.com>
	 <20090319215250.GF28946@ZenIV.linux.org.uk>
	 <20090319220906.GG28946@ZenIV.linux.org.uk>
	 <70318cbf0903191611i4ec1f5e5sa97ba53db3a7478c@mail.gmail.com>
	 <20090321044020.GL28946@ZenIV.linux.org.uk>
	 <20090321172823.GA5509@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:58271 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964AbZCWJWu (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 23 Mar 2009 05:22:50 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1687969rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 23 Mar 2009 02:22:47 -0700 (PDT)
In-Reply-To: <20090321172823.GA5509@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hannes Eder <hannes@hanneseder.net>, linux-sparse@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

>
> It needed testing, all right - #elif handling got broken by the initial
> variant...  Hopefully fixed version follows:

Looks good. BTW, it is simpler than my version which try to do
the processor in argument list.

Applied, thanks.

Chris
