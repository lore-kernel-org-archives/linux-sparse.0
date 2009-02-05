From: Christopher Li <sparse@chrisli.org>
Subject: Re: fun with declarations and definitions
Date: Thu, 5 Feb 2009 10:40:40 -0800
Message-ID: <70318cbf0902051040m7506a365s784a591667358f1f@mail.gmail.com>
References: <20090202073018.GB28946@ZenIV.linux.org.uk>
	 <70318cbf0902021907w634ffc6dm693022b23a0eabfc@mail.gmail.com>
	 <20090203041317.GH28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:22027 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbZBESkl (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 13:40:41 -0500
Received: by rv-out-0506.google.com with SMTP id k40so382917rvb.1
        for <linux-sparse@vger.kernel.org>; Thu, 05 Feb 2009 10:40:40 -0800 (PST)
In-Reply-To: <20090203041317.GH28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 2, 2009 at 8:13 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>> I read the patch, seems reasonable. It is only solve the inline case though.
>> The more generic problem still exist, symbol look up between partial
>> prototype declare and the real declare will get symbol with partial
>> information.
>
> ... and unfortunately, that's what we _have_ to do.  Reason: behaviour
> of typeof().  Example:
>
> extern int a[];
> int a[__builtin_types_compatible_p(typeof(a),int [3]) + 3];     /* 4 */
> int b[__builtin_types_compatible_p(typeof(a),int [3]) + 3];     /* 3 */
>
> Similar for
> extern int a[];         /* a is int [] */
> typedef typeof(a) A;    /* A is int []  _AND_ _WILL_ _REMAIN_ _SO_ */
> int a[10];              /* a is int [10] now */
> A b;                    /* int [] */
> int b[1];               /* no problem */
>
> Similar applies for functions getting pointers to functions, etc. - having
> the type refined by subsequent declaration is not retroactive.

I see. So the subsequent declaration for the same symbol should inherent
previous declaration attributes, but no the other way around.

> Mind you, we are not doing composite types in any useful way and _that_ is
> where we ought to change things.  Subsequent declarations should pick
> the additional type information; we do propagate the inline definition
> back to the call sites, provided that we had the function declared inline
> before those.  However, the type information should _not_ be spread back.

Right. I think currently sparse treat the subsequent declaration like a new
one. It check the type is compatible with previous declaration. But it does
not merge the previous declaration information.

> doesn't involve any extensions and having it barf on the second memset call
> there is certainly intended behaviour.

That is good to know. I will keep that in mind.

Chris
