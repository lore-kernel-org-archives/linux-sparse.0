From: Christopher Li <sparse@chrisli.org>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Thu, 19 Mar 2009 13:04:20 -0700
Message-ID: <70318cbf0903191304k1fefe9afkb4be21550d8f9abe@mail.gmail.com>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com>
	 <20090319144622.GA28946@ZenIV.linux.org.uk>
	 <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com>
	 <20090319191431.GD28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:50255 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760705AbZCSUEW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 19 Mar 2009 16:04:22 -0400
Received: by rv-out-0506.google.com with SMTP id f9so722849rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 19 Mar 2009 13:04:20 -0700 (PDT)
In-Reply-To: <20090319191431.GD28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Hannes Eder <hannes@hanneseder.net>, linux-sparse@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

On Thu, Mar 19, 2009 at 12:14 PM, Al Viro <viro@zeniv.linux.org.uk> wro=
te:
> a) some <expletives> has #define if(x) ....... (check it out, I'm not=
 kidding)
> b) ifdef that turd's conditional upon is present in your .config
> c) ... and now,
> =A0 =A0 =A0 =A0if (
> #ifdef .....
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0barf &&
> #endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vomit)
>
> steps into undefined behaviour.

We can complain about the bad C code.

We should stop the segfault though. I take a look at it. It seems that
there is a SYM_NODE with base_type is NULL. I guess in some of
the error path we result in an invalid AST three.

Maybe we should abort sparse after "too many error" ?

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
